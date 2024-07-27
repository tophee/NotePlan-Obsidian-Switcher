-- Check which application is in the foreground
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell

-- Define the vault name
set vault to "co.noteplan.NotePlan-setapp"

if frontApp is "Obsidian" then
	-- Ensure Obsidian is frontmost
	tell application "System Events"
		set frontmost of process frontApp to true
		repeat until frontmost of process frontApp
			delay 0.1
		end repeat
		if true is in value of attribute "AXFullScreen" of windows of process frontApp then
			-- Exit full screen mode
			key code 3 using {control down, command down}
			delay 1
		end if
	end tell
	
	-- Get the title of the front window in Obsidian
	tell application "System Events"
		tell process "Obsidian" to set windowTitle to title of front window
	end tell
	
	-- Filter out the vault name and Obsidian version from the window title
	set AppleScript's text item delimiters to " - " & vault
	set titleParts to text items of windowTitle
	if (count of titleParts) > 0 then
		set noteTitle to item 1 of titleParts
	else
		display dialog "Unable to parse the window title from Obsidian." buttons {"OK"} default button "OK"
		return
	end if
	
	-- Encode the window title for the URL
	try
		set encodedTitle to do shell script "python3 -c \"import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))\" " & quoted form of noteTitle
	on error errMsg
		display dialog "Error encoding note title: " & errMsg buttons {"OK"} default button "OK"
		return
	end try
	
	-- Construct the NotePlan URL with the encoded note title
	set notePlanURL to "noteplan://x-callback-url/openNote?noteTitle=" & encodedTitle
	
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
