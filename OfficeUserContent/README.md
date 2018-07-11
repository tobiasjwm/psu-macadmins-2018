# Delivering Microsoft Office Content

See the original Paul Bowdden document at https://macadmins.software/docs/UserContentIn2016.pdf

	src $ munkipkg --create OfficeUserContent
	munkipkg: Created new package project at OfficeUserContent
	src $ cd ./OfficeUserContent/payload
	payload $ mkdir -p Library/Application\ Support/Microsoft/Office365/User\ Content.localized/Templates.localized
	payload $ open .