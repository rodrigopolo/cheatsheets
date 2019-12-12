# YouTube Upload on Terminal

Requirements

* Python 2.5 or higher
* Install the [Google APIs Client Library for Python](https://developers.google.com/api-client-library/python/start/installation) (`google-api-python-client`)
* [Register your application with Google](https://developers.google.com/youtube/registering_an_application) so that it can use the OAuth 2.0 protocol to authorize access to user data.
* To use OAuth 2.0 steps with this script, you'll need to create a client_secrets.json file that contains information from the [Developers Console](https://console.developers.google.com/). The file should be in the same directory as the script.

```
{
	"web": {
		"client_id": "[[INSERT CLIENT ID HERE]]",
		"client_secret": "[[INSERT CLIENT SECRET HERE]]",
		"redirect_uris": [],
		"auth_uri": "https://accounts.google.com/o/oauth2/auth",
		"token_uri": "https://accounts.google.com/o/oauth2/token"
	}
}
```

And the `client_secrets.json` file:
```
{
	"installed": {
		"client_id": "---123---",
		"client_secret": "---123---",
		"redirect_uris": ["http://locahost", "urn:ietf:wg:oauth:2.0:oob"],
		"auth_uri": "https://accounts.google.com/o/oauth2/auth",
		"token_uri": "https://accounts.google.com/o/oauth2/token"
	}
}
```

In this example, the script would build and insert the following video resource for the video:

```bash
python upload_video.py \
--file="/tmp/test_video_file.mp4" \
--title="Summer vacation in California" \
--description="Had fun surfing in Santa Cruz" \
--keywords="surfing,Santa Cruz" \
--category="22" \
--privacyStatus="private" \
--noauth_local_webserver
```

Auth JSON File
```bash
upload_video.py-oauth2.json
```

Categories
```
1       Film & Animation
2       Autos & Vehicles
10      Music
15      Pets & Animals
17      Sports
19      Travel & Events
20      Gaming
22      People & Blogs
23      Comedy
24      Entertainment
25      News & Politics
26      Howto & Style
27      Education
28      Science & Technology
29      Nonprofits & Activism
```


[Source](https://developers.google.com/youtube/v3/guides/uploading_a_video)