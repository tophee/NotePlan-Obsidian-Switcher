-- Check which application is in the foreground
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell

-- Define the vault name
set vault to "co.noteplan.NotePlan-setapp"

if frontApp is "Obsidian" then
	-- send Ctrl + Shift + Option + Cmd + U
	tell application "System Events"
        	key code 32 using {control down, shift down, option down, command down}
    	end tell

	-- Wait for a short moment to ensure clipboard is updated
	delay 0.1

	-- Get the clipboard content
	set ObsidianURL to the clipboard as text

	-- Extract the part after &file=
	set AppleScript's text item delimiters to "&file="
	set urlComponents to text items of ObsidianURL
	if (count of urlComponents) > 1 then
    		set filePath to item 2 of urlComponents
	else
    		display dialog "Invalid URL format."
    		return
	end if

	-- Remove prefix if it starts with Notes%2F or Calendar%2F
	if filePath starts with "Notes%2F" then
    		set filePath to text 9 thru -1 of filePath
	else if filePath starts with "Calendar%2F" then
    		set filePath to text 12 thru -1 of filePath
	end if

	-- Add .md to the end
	set processedFilePath to filePath & ".md"
	
	-- Construct the NotePlan URL with the processed file path
	set notePlanURL to "noteplan://x-callback-url/openNote?filename=" & processedFilePath
	
	-- Open the file in NotePlan
	try
		do shell script "open " & quoted form of notePlanURL
	on error errMsg
		display dialog "Error opening NotePlan URL: " & errMsg buttons {"OK"} default button "OK"
	end try
	
else if frontApp is "NotePlan" then
	-- Get the URL of the currently open note in NotePlan
	tell application "NotePlan"
		set noteURL to selectedNoteUrl
	end tell
	
	-- Extract the file name from the URL
	set AppleScript's text item delimiters to "fileName="
	set fileNamePart to text item 2 of noteURL
	set AppleScript's text item delimiters to "&"
	if (count of text items of fileNamePart) > 1 then
		set fileName to text item 1 of fileNamePart
	else
		set fileName to fileNamePart
	end if
	
	-- Construct the Obsidian URL with the vault
	set obsidianURL to "obsidian://open?vault=" & vault & "&file=" & fileName
	
	-- Open the file in Obsidian
	try
		do shell script "open " & quoted form of obsidianURL
	on error errMsg
		display dialog "Error opening Obsidian URL: " & errMsg buttons {"OK"} default button "OK"
	end try
	
else
	-- Do nothing if neither Obsidian nor NotePlan is in the foreground
	return
end if
