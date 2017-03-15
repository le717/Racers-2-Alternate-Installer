; LEGO Racers 2 Alternate Installer
; Created 2012-2014 Triangle717
; <http://Triangle717.WordPress.com/>
; Contains source code from Grim Fandango Setup
; Copyright (c) 2007-2008 Bgbennyboy
; <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling,
; this error will be shown.
#if VER < EncodeVer(5, 5, 9)
  #error You must use Inno Setup 5.5.9 or newer to compile this script
#endif

#define MyAppInstallerName "LEGO Racers 2 Alternate Installer"
#define MyAppInstallerVersion "1.2.0"
#define MyAppName "LEGO Racers 2"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Attention to Detail"
#define MyAppExeName "LEGO Racers 2.exe"

[Setup]
AppID={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=(c) 2001 {#MyAppPublisher}
LicenseFile=license.txt

DefaultDirName={pf}\LEGO Media\{#MyAppName}
DefaultGroupName=LEGO Media\{#MyAppName}
AllowNoIcons=true

SetupIconFile=ICON\1.ico
WizardImageFile=LR2 Sidebar Image.bmp
WizardSmallImageFile=InnoSetup LEGO Logo.bmp
WizardImageStretch=True

OutputDir=bin
OutputBaseFilename=LEGO-Racers-2-Alternate-Installer-{#MyAppInstallerVersion}

UninstallFilesDir={app}
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\ICON\1.ico
CreateUninstallRegKey=true

Compression=lzma2/ultra64
SolidCompression=yes
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes

PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName}
 
; DiskSpaceMBLabel is overridden in order to report 
; a correct installation size
DiskSpaceMBLabel=At least 450 MB of free disk space is required.

; Both Types and Components sections are required to create the installation options.
[Types]
Name: "Minimal"; Description: "Minimal Installation (Without Movies/Music)"
Name: "Full"; Description: "Full Installation (With Movies/Music)"

[Components]
Name: "Minimal"; Description: "Minimal Installation (Without Movies/Music)"; Types: Minimal
Name: "Full"; Description: "Full Installation (With Movies/Music)"; Types: Full

[Files]
Source: "{code:GetSourceDrive}install\LEGO Racers 2.exe"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Minimal
Source: "{code:GetSourceDrive}install\COMPRESS.INF"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Minimal
Source: "{code:GetSourceDrive}install\FILELIST.INF"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Minimal
Source: "{code:GetSourceDrive}ReadMe.txt"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Minimal
Source: "{code:GetSourceDrive}Manual\Racers 2 USA PC manual.pdf"; DestDir: "{app}"; Flags: external ignoreversion skipifsourcedoesntexist; Components: Full Minimal
Source: "ICON\*"; DestDir: "{app}\ICON"; Flags: ignoreversion createallsubdirs recursesubdirs; Components: Full Minimal
Source: "{code:GetSourceDrive}install\game data\Music\*"; DestDir: "{app}\game data\Music"; Flags: external ignoreversion createallsubdirs recursesubdirs; Components: Full
Source: "{code:GetSourceDrive}install\game data\Movies\*"; DestDir: "{app}\game data\Movies"; Flags: external ignoreversion createallsubdirs recursesubdirs; Components: Full
Source: "{code:GetSourceDrive}install\GAMEDATA.GTC"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Minimal

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: none; Flags: uninsdeletevalue; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "CDpath"; ValueData: "{code:GetSourceDrive}"; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "moviespath"; ValueData: "{app}"; Flags: uninsdeletekey; Components: Full
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "moviespath"; ValueData: "{code:GetSourceDrive}\install\"; Flags: uninsdeletekey; Components: Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2"; ValueType: none; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2\0.00.00.00.001a"; ValueType: none; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe\"; ValueType: string; ValueName: "(Default)"; ValueData: "{app}\LEGO Racers 2.exe"; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletekey; Components: Full Minimal

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Dirs]
; Created to ensure the save games are not removed
; (which should never ever happen).
Name: "{app}\game data\Saved Games"; Flags: uninsalwaysuninstall; Components: Full Minimal

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up
// and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
    SourceDrive: string;

#include "FindDisc.pas"

function GetSourceDrive(Param: String): String;
begin
    Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
    SourceDrive:=GetSourceCdDrive();
end;
