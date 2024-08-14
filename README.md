

## SendTo Tools for Windows

![GitHub Created At](https://img.shields.io/github/created-at/henrique-coder/windows-sendto-tools?style=for-the-badge&logoColor=white&labelColor=gray&color=white)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/henrique-coder/windows-sendto-tools?style=for-the-badge&logoColor=white&labelColor=gray&color=white)
![GitHub last commit](https://img.shields.io/github/last-commit/henrique-coder/windows-sendto-tools?style=for-the-badge&logoColor=white&labelColor=gray&color=white)

Scripts developed in batch to be used in the Windows SendTo folder. The scripts are used to automate tasks that are usually done manually.

#### Important Notes

- Built with [Batch](https://wikipedia.org/wiki/Batch_file).
- Works on Windows 10 and later versions.
- Every script has its own requirements and instructions for use.
- The scripts are designed to be used in the Windows SendTo folder. The SendTo folder is a hidden folder located at `C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo`.

#### Prerequisites

- [Windows 10](https://www.microsoft.com/windows/get-windows-10) or later.
- [Git](https://gitforwindows.org) (optional).
- [PowerShell](https://wikipedia.org/wiki/PowerShell) (optional).

### Available Tools

- **[analyze-file-hashes](https://github.com/Henrique-Coder/windows-sendto-tools/tree/main/analyze-file-hashes)**: Returns the MD5, SHA1, SHA256, SHA384 and SHA512 hashes of the chosen file.
- **[anyvideo-to-av1](https://github.com/Henrique-Coder/windows-sendto-tools/tree/main/anyvideo-to-av1)**: Quickly transcodes any video file to the `libsvtav1` (AV1) codec with the best parameters for efficient compression.
- **[fileditch-sender](https://github.com/Henrique-Coder/windows-sendto-tools/tree/main/fileditch-sender)**: Sends the chosen file to the file hosting service [FileDitch](https://fileditch.com). Supports [permanent](https://fileditch.com) and [temporary](https://fileditch.com/temp.html) file uploads. When the upload is finished, the direct url is automatically displayed and copied to your clipboard.

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Henrique-Coder/windows-sendto-tools.git

# 2. Change the directory
cd windows-sendto-tools

# 3. Choose the script you want to use and run the sendto_install.bat file that will be inside the folder of the chosen script. Example:
cd fileditch-sender
sendto_install.bat

# 4.1 The installer will automatically install the script in the SendTo directory in your Windows.
# 4.2 That's all, now just use the new tool from the Windows explorer context menu.
```

### Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have any suggestions that could improve this project, please [fork](https://github.com/Henrique-Coder/windows-sendto-tools/fork) the repository and open a pull request. Or simply open an [issue](https://github.com/Henrique-Coder/windows-sendto-tools/issues/new) and describe your ideas or let us know what bugs you've found. Don't forget to give the project a star. Thanks again!

1. Fork the project at https://github.com/Henrique-Coder/windows-sendto-tools/fork
2. Create your feature branch ・ `git checkout -b feature/{feature_name}`
3. Commit your changes ・ `git commit -m "{commit_message}"`
4. Push to the branch ・ `git push origin feature/{feature_name}`
5. Open a pull request describing the changes made and detailing the new feature. Then wait for an administrator to review it and you're done!

### License

Distributed under the MIT License. See [LICENSE](https://github.com/Henrique-Coder/windows-sendto-tools/blob/main/LICENSE) for more information.

### Disclaimer

Please note that this project is still under development and may contain errors or incomplete functionality. If you encounter any problems, feel free to open an [issue](https://github.com/Henrique-Coder/windows-sendto-tools/issues/new) in the GitHub repository.