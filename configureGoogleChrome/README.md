# Google Chrome Management

People, nerds especially, have very strong feelings about their browser choices. Setting aside political affiliations (I use Vim), Google Chrome provides more-than-decent management capabilities including providing a customized first-run experience, enforcement of security settings and simple installation of company-approved extensions.

## Install Extensions with Profiles

Google Chrome can install extensions via mobile profile.

### Requires

1. Extension ID: Can be found in [chrome://extensions](chrome://extensions). 

	- _Extension must be installed_
	- _Check the box next to_ ***Developer mode*** to reveal the ID
	
2. Download link: 'https://clients2.google.com/service/update2/crx'

For more details, see this Chrome developer article on [Alternative Extension Distribution Options][cpa].

### Building the Profile

Chrome management happens in the managed preferences (MCX) domain and are best created using Server.app Profile Manager.

See [this example][cpf] from Nick McSpadden. In addition to installing an extension, he is also managing other settings including setting home page, disabling password manager and 'restore on startup'.

Darren Wallace has done some really great work on making all the configuration things happen with a profile. See [this article][dwcf] for more info and [this profile][tpcf] for all the naughty bits.

## Chrome Master Preferences

Chrome also has a master settings file that will copy settings to all new user accounts. it is located at `/Library/Google/Google Chrome Master Preferences`. This file is JSON markup.

You should set the defaults up here. It is fine to have them overlap with the profile as long as they match. What is in the profile is *enforced*, what is here is the First Run experience, or management updates.


*A full reference for Chrome Master Preferences is available at the [Configuring Other Settings][cos] section of the Chromium Projects site.*

In our example, we are using the following items:

- `import_bookmarks_from_file`: Silently imports bookmarks from the given HTML file.
- `import_*`: Each of these import parameters will trigger automatic imports of settings on first run. We are disabling most of these.
- do_not_register_for_update_launch: does not register with Google Update to have Chrome launched after install.
- `make_chrome_default`: Although this does not set Chrome as default on macOS, it appears to trigger the "set as default" dialog, which is good enough.
- `make_chrome_default_for_user`: Same as above.
- `first_run_tabs`: these are the tabs & URLs shown on the first launch (and only on first launch) of the browser.
- `sync_promo.show_on_first_run_allowed`: Prevents the Google sign-in page from appearing on first run.

### Pre-installed Bookmarks

To add pre-installed bookmarks, you have to create a file that contains all of your bookmarks, then tell Chrome to import them when a user runs Chrome for the first time.

1. Set up bookmarks in Chrome as you'd like them to appear to the end-user
2. Go to the Elipsis Menu > Bookmarks > Bookmark Manager. From within the Bookmark Manager, click the Elipsis Menu and choose *Export bookmarks*. The file that is saved/exported contains all of the bookmark data that will be imported.
3. **Important:** change the file permissions to have read access for the group. By default, the generated file has permissions of 600.
4. To make Chrome import these bookmarks, include these elements in your master_preferences:

**Example**

	{
	   "distribution": {
	      "import_bookmarks": false,
	      "import_bookmarks_from_file": "/path/to/bookmarks.html"
	   },
	   "bookmark_bar": {
	      "show_on_all_tabs": true
	   }
	 }

**Here are the interesting bits:**

- `import_bookmarks_from_file` needs to have the path to bookmark file. The file must exist _before_ a Chrome first-run for a given user.
- `import_bookmarks` references importing from Safari. Make this `false` to prevent over-writing your given bookmarks
- "show_on_all_tabs": can either be true or false, whether we've promised the partner to show the bookmarks bar on by default or not.

[cpa]:https://developer.chrome.com/extensions/external_extensions
[dwcf]:http://www.amsys.co.uk/2017/02/chrome-first-run-messages-revisited-added-profiles/
[tpcf]:https://github.com/amsysuk/public_config_profiles/blob/master/Google/Chrome/GoogleChrome_FirstRun.mobileconfig
[cpf]:https://github.com/nmcspadden/Profiles/blob/master/Chrome.mobileconfig
[cos]:https://www.chromium.org/administrators/configuring-other-preferences