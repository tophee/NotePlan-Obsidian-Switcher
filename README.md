# NotePlan-Obsidian-Switcher
This AppleScript allows you to seamlessly switch between Obsidian and NotePlan by opening the corresponding note in the other application. 

## Features

- Detects whether Obsidian or NotePlan is the active application. (If neither app is active, the script does nothing.)´
- Retrieves the URL of the current note and opens it in the other app respectively.
   - In Noteplan, the URL is retrieved via AppleScript.
   - Obsidian doesn't support AppleScript, so we use a Hotkey to copy the URL.

## Requirements

- **Obsidian**
   - with the Hotkey for "Copy Obsidian URL" set to Hyper + U, i.e. Cmd + Option + Ctrl + Shift + U. If you use a different hotkey, you need to change the script accordingly). ![CleanShot 2024-07-31 at 02 11 40@2x](https://github.com/user-attachments/assets/0a78feda-e64c-4d13-9f09-4329a050a8ff)

   - Your Obsidian Vault has to be set to your Noteplan directory, i.e. the one containing the `Calendar` and `Notes` directories. If you have your Obsidian Vault set to the `Notes` folder, you may need to adjust the script to get the paths right. If your Obsidian Vault is not insde the Noteplan folder at all, this script will not work. For more information about running NotePlan and Obsidian in parallel, see: https://help.noteplan.co/article/61-use-noteplan-with-obsidian)
- **NotePlan**
  - No specific preparations needed (assuming that you already have a aorking setup with Obsidian and Noteplan sharing the same notes).
- **BetterTouchTool** (or some other way of triggering the script)

## Testing the Script

1. **Access the script [here](https://github.com/tophee/Note-Editor-Switcher/blob/main/Toggle-Note-Editor.scpt)**

2. **Run the Script:**
   - Open the script with Script Editor or or your preferred AppleScript execution tool.
   - Add `delay 5` as the first line of the script (this gives you time to switch to NotePlan or Obsidian)
   - Set `vault` to the name of your bbsidian Vault (replace "co.noteplan.NotePlan-setapp")
   - Run the script 

## Triggering the Script in Everyday Use

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
The script uses a hardcoded vault name `co.noteplan.NotePlan-setapp`. You can customize this by changing the `vault` variable in the script to match your vault name.
- **Obsidian Hotkey:**
The script assumes that Hyper + U is the Hotkey in Obsidian for copying the note URL. If you have a different Hotkey, change the script accordingly.
- **An Alternative Approach:**
I think the chosen approach of getting the note URL in the respective app is the most robust way of making sure that we open the correct note in the other app. But here is an alternative way of getting the note URL in Obsidian: you can configure the [Obsidian Windows Title Changer plugin](https://github.com/jplattel/open-note-to-window-title) so that the default title template includes not just the note's name but also the path and then retrieve that information from the Obsidian Window (Noteplan needs the entire path to reliably find all notes). The disadvantages of this strategy are, however:
  - We need a plugin in Obsidian.
  - We need to check whether Obsidian is in Full Screen Mode and exit it because there seem to be issues with retrieving the window title when in Full Screen mode.
  - We need to encode the note path when construcing the URL. When we extract the path from the URL, it os already encoded.
- **Another Alternative Approach:**
  - It might be easier for some users to just install and enable a plugin in Obsidian (which opens the note in Noteplan) and a plugin in Noteplan (which opens the note in Obsidian). But I have no experience with writing a plugin from scratch for either app, so it was easier for me to use Apple script. I also feel it is easier to maintain one script rather than two plugins. But to popularize the Switcher, two plugins would clearly be the better option. (There are probably other criteria to decide which is the better approach to implementing this functionality at the OS level versus at the App level, but I'm not sure about these. What do you think?) 

## Troubleshooting

- Ensure that the path to your Obsidian Vault and your Noteplan folder are identical and that the vault name is set correctly in the script.
- Ensure that your Obsidian Shortcut for "Copy Obsidian URL" is the same as the one called in the script (default: Hyper + U)
- When you run the script for the first time, BTT will ask for permission to control Obsidian and Noteplan. Make sure to grant those persmissions. 
- Adjust delay values in the script if it is not performing as expected under different system loads.



## Contributing

If you have suggestions for improving this script or encounter any issues, please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
