
`cron.txt`
```sh
SHELL="/bin/bash"
# Mail
MAILTO="email@example.com"

# Bash script
*/30 * * * *    /home/user/script.sh
```

`script.sh`
```sh
#!/usr/bin/env bash

# Make a list of the files
phantomjs /home/user/phantom_script.js > /home/user/current.txt

# Compare the list with the previous list
diff --side-by-side --suppress-common-lines /home/user/current.txt /home/user/prev.txt 1>&2

# Copy current to prev.
cp /home/user/current.txt /home/user/prev.txt
```

`phantom_script.js`
```js
var system = require('system');
var page = require('webpage').create();
page.onConsoleMessage = function(msg) {
        system.stdout.writeLine(msg);
};
page.open('http://store.apple.com/us/browse/home/specialdeals/mac/mac_pro', function() {
        page.includeJs("http://code.jquery.com/jquery-1.11.2.min.js", function() {
                page.evaluate(function() {
                        $('.product').each(function() {
                                var self = $(this);
                                var title = self.find('.specs h3 a').first().text().trim();
                                var price = self.find('.purchase-info .price .current_price').first().text().trim();
                                console.log(price+' - '+title);
                        });
                });
        });
        setTimeout(function(){
                phantom.exit();
        }, 1000);
});
```