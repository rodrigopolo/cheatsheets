/*
npm install axios cheerio fast-xml-parser

Usage:
  node 360cities.js \
  https://www.360cities.net/image/URL \
  ./download/uris.txt \
  ./download/exiftool.sh
*/

//const path = require('path');
const fs = require('fs');
const axios = require('axios');
const cheerio = require('cheerio');
const { XMLParser } = require('fast-xml-parser');

function parseDataString(data) {
    const result = {};
    const lines = data.trim().split('\n');
    
    for (let line of lines) {
        line = line.trim();
        // Skip empty lines or lines we don't want to parse
        if (line === 'Views: ...') continue;

        // Split the line into key and value
        const[key, ...valueParts] = line.split(':');
        let value = valueParts.join(':').trim();

        // Special handling for tags to convert into an array
        if (key === 'Tags') {
            value = value.split('; ').map(tag => tag.trim());
        }

        result[key.trim()] = value;
    }

    return result;
}

const generateExifToolCommand = (metadata, output) => {
    // Helper function to format date from DD/MM/YYYY to YYYY:MM:DD
    const formatDate = (dateStr) => {
        const [day, month, year] = dateStr.split('/');
        return `${year}:${month}:${day} 00:00:00`;
    };

    // Helper to determine GPS reference based on coordinate
    const getGPSRef = (coordinate, type) => {
        const value = parseFloat(coordinate);
        if (type === 'lat') {
            return value >= 0 ? 'N' : 'S';
        }
        return value >= 0 ? 'E' : 'W';
    };

    // Build the command parts
    const commandParts = [
        'exiftool',
        '-overwrite_original',
        '-ProjectionType="equirectangular"',
        '-XMP-GPano:InitialViewHeadingDegrees=0',
    ];

    // Add Keywords (including 360i)
    if (metadata.Tags && metadata.Tags.length > 0) {
        const allTags = ['360i', ...metadata.Tags];
        commandParts.push(`-Keywords+="${allTags.join(', ')}"`);
    }

    // Add Copyright
    if (metadata.Copyright) {
        commandParts.push(`-Copyright="${metadata.Copyright}"`);
    }

    // Add DateTimeOriginal
    if (metadata.Taken) {
        commandParts.push(`-DateTimeOriginal="${formatDate(metadata.Taken)}"`);
    }

    // Add GPS coordinates if available
    if (metadata.metaTags?.latitude && metadata.metaTags?.longitude) {
        const lat = metadata.metaTags.latitude;
        const lng = metadata.metaTags.longitude;
        const latRef = getGPSRef(lat, 'lat');
        const lngRef = getGPSRef(lng, 'lng');

        commandParts.push(
            `-GPSLatitude=${Math.abs(parseFloat(lat))}`,
            `-GPSLatitudeRef=${latRef}`,
            `-GPSLongitude=${Math.abs(parseFloat(lng))}`,
            `-GPSLongitudeRef=${lngRef}`
        );
    }

    // Add the target image file
    commandParts.push(output);

    // Join with newlines and backslashes for better readability
    return commandParts.join(' \\\n');
};

async function extractXML(url) {

    const base = url.split('/').pop();
    const xmlUrl = `https://www.360cities.net/embed_iframe/${base}.xml?no_hotspots=false&home_main_pano=false&portfolio_view=false&pro_embed=false`;

    try {
        // Make HTTP request to get XML content
        const response = await axios.get(xmlUrl);
        const xmlData = response.data;

        // Configure XML parser
        const parser = new XMLParser({
            ignoreAttributes: false,
            attributeNamePrefix: '_',
            parseAttributeValue: true
        });

        // Parse XML
        const parsedData = parser.parse(xmlData);

        // Navigate through the XML structure
        const krpano = parsedData.krpano;
        const image = krpano.image;
        const levels = Array.isArray(image.level) ? image.level : [image.level];
        
        // Get the last level (index 3 in your example)
        const lastLevel = levels[levels.length - 1];
        
        // Extract tiledimageheight
        const tiledImageHeight = lastLevel._tiledimageheight;

        // Extract the URL from the left tag
        const leftUrl = lastLevel.left._url;

        // Return both the tiledimageheight and the left URL
        return {
            tiledImageHeight: tiledImageHeight,
            leftUrl: leftUrl
        };
    } catch (error) {
        console.error('Error:', error.message);
        throw error;
    }
}


async function extractData(url, XMLData = null) {
    try {
        // Fetch the HTML content from the URL
        const response = await axios.get(url);
        const html = response.data;

        // Load HTML into cheerio
        const $ = cheerio.load(html);
        //const $ = cheerio.load(dummy_data);

        var info;
        $('.data_list .col_wrap_2').each((i, el) => {
            info = $(el).text();
        });
        var panoInfo = parseDataString(info);

        if (XMLData !== null) {
            panoInfo.XMLData = XMLData;
        }

        panoInfo.metaTags = {
            latitude: $('meta[property="og:latitude"]').attr('content'),
            longitude: $('meta[property="og:longitude"]').attr('content'),
            image: $('meta[property="og:image"]').attr('content')
        };

        if(panoInfo.Resolution){
            var res=panoInfo.Resolution.split('x');
            panoInfo.width = parseInt(res[0]);
            panoInfo.height = parseInt(res[1]);
        }

        // Combine meta tags and parsed data
        return panoInfo;

    } catch (error) {
        console.error('Error fetching or parsing data:', error.message);
        return null;
    }
}

// Write the content to the file asynchronously
async function writeFileAsync(filePath, content, cb) {
    try {
        await fs.promises.writeFile(filePath, content);
        cb();
    } catch (error) {
        console.error('An error occurred while writing the file:', error);
    }
}

const selfScript = process.argv[1];
const args = process.argv.slice(2);
if (args.length !== 3) {
    console.error(`Usage: node ${selfScript} <URL> <PathToURIs> <PathToExifBash>`);
    process.exit(1);
}

// Example usage
const url = args[0];

// URIs file
const urisFilePath =  args[1];

// Exiftool file
const exiftoolFilePath =  args[2];

// First call extractXML
extractXML(url).then(XMLData => {
    extractData(url, XMLData).then(data => {
        if (data) {

            var panoBaseURL = data.XMLData.leftUrl.split('/cube')[0];
            var sides = ['back','down','front','left','right','up']

            //var maxloop = data.height/2/512; // FIX
            var maxloop = data.XMLData.tiledImageHeight/512; // FIX

            // Open the URIs file
            fs.writeFileSync(urisFilePath, '', { flag: 'w' });
            const urisWriteStream = fs.createWriteStream(urisFilePath, { flags: 'a' });

            urisWriteStream.on('error', (err) => {
                console.error('Error writing to URIs file:', err);
            });

            for (var k = 0; k < sides.length; k++) {
                var currentSide = []
                for (var j = 0; j < maxloop; j++) {
                    for (var i = 0; i < maxloop; i++) {
                        currentSide.push(`${sides[k]}-${j}-${i}.jpg`)
                        urisWriteStream.write(`${panoBaseURL}/cube/${sides[k]}/tile/512/3/${j}/${i}.jpg?orig=\n  out=${sides[k]}-${j}-${i}.jpg\n`);
                    }
                }
            }

            // Close URIs file
            urisWriteStream.end(() => {
                console.log('URIs file created');
            });

            var exiftoolCommand = generateExifToolCommand(data,'$1');
            writeFileAsync(exiftoolFilePath, exiftoolCommand,function(){
                console.log('Metadata Bash file created.');
            });

        } else {
            console.log("Failed to extract data.");
        }
    });
}).catch(error => {
    console.error('Error in extractXML:', error);
});


