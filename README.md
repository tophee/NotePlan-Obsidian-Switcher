# NotePlan-Obsidian-Switcher
This AppleScript allows you to seamlessly switch between Obsidian and NotePlan by opening the corresponding note in the other application. 

## Features

- Detects whether Obsidian or NotePlan is the active application. (If neither app is active, the script does nothing.)´
- Retrieves the title of the current note in Obsidian and opens it in NotePlan. (Credit to [Alex](https://alexwlchan.net/2023/obsidian-open-note/) for this workaround) 
- Retrieves the URL of the current note in NotePlan and opens it in Obsidian.
- If Obsidian is in full-screen mode, the script will exit full-screen before retrieving the title. (This is necessary because I wasn't able to get the Obsidian window title in full-screen mode.)

## Requirements

- Obsidian
- NotePlan
- BetterTouchTool (or some other way of triggering the script)

Your Obsidian Vault has to be set to Your Noteplan directory, i.e. the one containing the `Calendar` and `Notes` directories. Without this setup, this script will not work. For more information about running NotePlan and Obsidian in parallel, see: https://help.noteplan.co/article/61-use-noteplan-with-obsidian)

## Testing the Script

1. **Access the script [here](https://github.com/tophee/Note-Editor-Switcher/blob/main/Toggle-Note-Editor.scpt)**

2. **Run the Script:**
   - Open the script with Script Editor or or your preferred AppleScript execution tool.
   - Add `delay 5` as the first line of the script (this gives you time to switch to NotePlan or Obsidian)
   - Set `vault` to the name of your bbsidian Vault (replace "co.noteplan.NotePlan-setapp")
   - Run the script 

## Triggering the Script

There are many ways to trigger the script. Here is one example using BetterTouchTool:

1. **Install BetterTouchTool:**
   - Download and install BetterTouchTool from [folivora.ai](https://folivora.ai/).

2. **Create a Keyboard Shortcut:**
   - Open BetterTouchTool and navigate to the `Keyboard` section.
   - Add a new shortcut by clicking the `+` button.
   - Set the keyboard shortcut to `Ctrl + <`.

3. **Set the Action:**
   - In the action configuration, choose `Run Apple Script (blocking)` (or `Run Apple Script (in background)` if you prefer).
   - Paste the content of Toggle-Note-Editor.scpt into the script editor.

4. **Save the Configuration**

## Customization

- **Vault Name:**
  - The script uses a hardcoded vault name `"co.noteplan.NotePlan-setapp"`. You can customize this by changing the `vault` variable in the script to match your vault name.

## Troubleshooting

- Ensure that the path to your Obsidian Vault and your Noteplan folder are identical and that the vault name is set correctly in the script. 
- When you run the script for the first time, BTT will ask for permission to control Obsidian and Noteplan. Make sure to grant those persmissions. 
- Adjust delay values in the script if it is not performing as expected under different system loads.

## Contributing

If you have suggestions for improving this script or encounter any issues, please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
