#!/bin/bash

#	configFinderDefaults.sh
#	version: 1.0
#	created: 23 Feb 2018
#	author: Tobias Morrison
#
#	A script to configure sane defaults in a new user account.
#	Choices are based on years of feedback from clients. Nothing
#+	is forced here and users can customise their envoiroment
#+	after this has run.
#
#	Designed to run as an Outset 'login-once' script.

###	Set PATH ###

PATH=/usr/bin:/bin:/usr/sbin:/sbin export PATH

###	Variables ###

# Where is mysides? Not in the PATH. Let's set it.
mysides=/usr/local/bin/mysides

# Get the Username of the currently logged user
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`


### Give the Finder Sidebar sane defaults ###

# Check that mysides is installed then run
if [ -e /usr/local/bin/mysides ]
then
	$mysides remove iCloud x-apple-finder:icloud && sleep 2
	$mysides add Shared file:///Users/Shared && sleep 2
	touch /Users/$loggedInUser/.sidebarshortcuts
fi


### Set Finder preferences ###

# New Window opens ~/Desktop
# Other popular views: $HOME=`PfHm`, Desktop=`PfDe`, Documents=`PfDo`
defaults write com.apple.finder NewWindowTarget -string "PfDe"

# Default Finder search path is current folder
# Other search paths: This Mac=`SCev`, Previous Scope=`SCsp`
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Other view modes: Icon=`icnv`, column=`clmv`
defaults write com.apple.finder  FXPreferredViewStyle -string "Nlsv"

# Display mounted server shares
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true


### Set Global values ###
# TEST TO SEE IF THIS WOULD BE BETTER IN A STARTUP SCRIPT

# Expand Save and Print Dialogs
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Set Show scroll bars to 'always'
defaults write -g AppleShowScrollBars -string "Always"


### Refresh cached preferences ###
killall cfprefsd
killall Finder