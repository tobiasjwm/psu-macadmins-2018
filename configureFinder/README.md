# Setting Sane Finder Defaults

In our continuing effort to automate our client's new employee set up requests, we see requests to clean up the Finder; both seting Sidebar items and window view options. Almost every client wants to remove iCloud Drive and AirDrop as well as add their own items such as local file server or shortcuts to file services like Dropbox. They also tend to prefer list or column views to the default icon view.

In macOS 10.11 El Capitan, Apple looked poised to give us a robust tool to accomplish the task of setting Sidebar items with their `sfltool` binary, but in macOS 10.13 High Sierra, our dreams were dashed as they removed all useful functionallity from this tool.


## Sidebar

Thankfully, the great [mosen][mo] had created [mysides][ms] prior to the release of `sfltool` and luckily for us, it is still working in 10.13.

There are lots of options for adding items, but the format is a bit esoteric so if you want to add items, JAMF Nation has several threads on usage including [com.apple.sidebarlists in El Capitan][sbl]. 


## View Settings

Here we will set a couple simple items that have been popular requests by clients. We are using PlistBuddy here in an effort to move away from `defaults` because a) Apple has long warned against using it in scripts and b) Although it was acknowledged as a bug, `defaults` started [deleting invalid plists][dip] in 10.13.3.

### New Finder windows show

First, we will set the default path for a new Finder window. In High Sierra we saw Apple change frome the interesting but ultimately useless "All My Files" built-in smart folder to the much more useful "Recents" folder. None the less, this is still less desirable for many than a common working folder. Since `~/Desktop` has been our perennial favorite, we will use this. 

	defaults write com.apple.finder NewWindowTarget -string "PfDe"

Apple is using a special identifier for these items. You can use the table below to assign your preferred item.

| TARGET       | STRING |  
| ------------ | ------ |  
| Computer     | PfCm   |  
| Volume       | PfVo   |  
| $HOME        | PfHm   |  
| Desktop      | PfDe   |  
| Documents    | PfDo   |  
| All My Files | PfAF   |  
| Other…       | PfLo   |  

When `NewWindowTarget` is set to `PfLo`, you can use the key `NewWindowTargetPath` with a string like "file:///Users/tobias/Dropbox/"

### When performing a new search

When Apple introduced Spotlight, users quickly learned that cmd + space was a great way to search their Mac. But many users still discover the search box in a Finder window and, curiously, started using the search box in the Finder window Toolbar to search the contents of the current window. But to accomplish this, an employee needs to initiate a search then click on the name of the current folder in the choices bar that appears after entering the search. Since we had long been setting this for new employee setups, it makes sense to set it automatically.

	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

Again we have special valuse for the available choices which can be found in the table below.


| TARGET         | STRING |  
| -------------- | ------ |  
| This Mac       | SCev   |  
| Current Folder | SCcf   |  
| Previous Scope | SCsp   |

### Display mounted server shares

I never saw this one as an issue, but I don't count when considering how "average employees" work. If Help Desk tickets are any indication, if employees don't see their mounted file shares on the desktop, they believe they are not connected to their shares, even as they stare at the contents of the share in an open Finder window. ¯\_(ツ)_/¯

	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

There are several other "show on desktop" items, but they are of little use to manage. You could show CDs/DVDs on the Desktop, but since optical drives don't ship on any current model Mac, it hardley bares consideration.




[mo]:https://github.com/mosen
[ms]:https://github.com/mosen/mysides
[dip]:https://scriptingosx.com/2018/02/defaults-the-plist-killer/
[sbl]:https://www.jamf.com/jamf-nation/discussions/17204/com-apple-sidebarlists-in-el-capitan