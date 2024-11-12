# Sunshine Virtual Display

Those two scripts add the possibility to make [Sunshine](https://github.com/LizardByte/Sunshine) set the right resolution, refresh rate and HDR settings on a virtual display, matching the client screen. You can use any virtual display driver but [the one](https://github.com/itsmikethetech/Virtual-Display-Driver) made by [@itsmikethetech](https://github.com/itsmikethetech) is recommended. The scripts are executed by Sunshine before a session starts. The actions executed by the scripts are reverted when the session ends. The scripts only enable the screen when a session is in progress, making impossible to interact with the virtual screen when using your computer normally.

> [!IMPORTANT]  
> I experienced a lot of issues with HDR (especially regarding calibration). I recommend disabling HDR for a best (and more consistent) experience. If you find a way to make it work, please let me know.

## Setup ⚙️

1. Install a virtual display driver. See instructions [here](https://github.com/itsmikethetech/Virtual-Display-Driver?tab=readme-ov-file#release-instructions) for the recommended driver.
2. Clone (or download) the repository somewhere on your computer.
3. _Optional_: Add custom resolutions to the `option.txt` file.
4. Open the _General_ section of Sunshine's configuration.
5. Add a command preparation entry.
6. For `config.do_cmd` enter the following and replace `<repository path>` by the path of the cloned (or downloaded) repository.

```bash
powershell.exe -File "<repository path>/enable-fake-display.ps1" -noexit
```

7. For `config.undo_cmd` enter the following and replace `<repository path>` by the path of the cloned (or downloaded) repository.

```bash
powershell.exe -File "<repository path>/disable-fake-display.ps1" -noexit
```

8. Set `config.elevated` to true by checking the checkbox.
9. Apply and restart Sunshine.
10. Open the `fake-display.json` file. Edit to match your configuration. To get the right display identifier refeer to [this section](#get-display-identifiers).

## How does it work? 🤔

When a session starts, Sunshine can execute user-defined scripts. When running those scripts, Sunshine also sets some environment variables describing the user's screen. The script executed upon session starts, enables the virtual display, makes it the primary display (to make sure the games are displayed on the virtual display), sets the resolution, refresh rate and HDR settings defined on the client (falling back to `1920x1080@60Hz SDR` if the client does not provide any information). The script executed upon session ends, disables the virtual display and sets the primary display back to the original one.

## Get display identifiers 🏷️

Open a PowerShell terminal (with administrator privileges) and run the following commands to install the `DisplayConfig` module that is required by the scripts.

```powershell
Install-Module -Name DisplayConfig
```

Then run the following command to get the current display configuration.

```powershell
Get-DisplayConfig
```

The output the command should look something similar to the following:

```
PathArray            : {MartinGC94.DisplayConfig.Native.Structs.DISPLAYCONFIG_PATH_INFO,
                       MartinGC94.DisplayConfig.Native.Structs.DISPLAYCONFIG_PATH_INFO,
                       MartinGC94.DisplayConfig.Native.Structs.DISPLAYCONFIG_PATH_INFO,
                       MartinGC94.DisplayConfig.Native.Structs.DISPLAYCONFIG_PATH_INFO...}
ModeArray            : {155906, 0, 155906, 155905...}
Flags                : QDC_ALL_PATHS, QDC_VIRTUAL_MODE_AWARE
TopologyID           : None
AvailablePathIndexes : {2, 0, 1, 3}
AvailablePathNames   : {DELL P190S, 24G1WG4, ASUS MX239, IDD HDR}
```

My primary monitor is the `24G1WG4`. The virtual monitor is the `IDD HDR`. The identifiers are the index of the display names in the `AvailablePathNames` array (starting from `1`). Therefore my `fake-display.json` should look like this:

```json
{
  "fakeDisplayId": 4,
  "mainDisplayId": 2
}
```
