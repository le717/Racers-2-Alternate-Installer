;  Click-And-Go LEGO Racers 2 Alternate Installer
;  Copyright © 2012 le717
;  http://triangle717.wordpress.com
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  Http://quick.mixnmojo.com

[Define]
#define MyAppInstallerName "Click-And-Go LEGO Racers 2 Alternate Installer"
#define MyAppName "LEGO Racers 2"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "LEGO Software"
#define MyAppExeName "LEGO Racers 2.exe"
[Setup]
AppID={
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 2001 {#MyAppPublisher}
LicenseFile=license.txt
DefaultDirName={pf}\LEGO Media\{#MyAppName}
DefaultGroupName=LEGO Media\{#MyAppName}
AllowNoIcons=true
SetupIconFile=ICON\1.ico
WizardImageFile=LR2 Sidebar Image.bmp
WizardSmallImageFile=InnoSetup LEGO Logo.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
OutputDir=Here Lie The EXE
OutputBaseFilename={#MyAppInstallerName}
UninstallFilesDir={app}
UninstallDisplayIcon={#MyAppExeName}
CreateUninstallRegKey=true
UninstallDisplayName={#MyAppName}
SolidCompression=True
Compression=lzma/ultra64
InternalCompressLevel=ultra
AllowRootDirectory=false
PrivilegesRequired=admin
ShowLanguageDialog=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
English.BeveledLabel={#MyAppInstallerName}

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{code:GetSourceDrive}install\LEGO Racers 2.exe"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}install\COMPRESS.INF"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}install\FILELIST.INF"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}ReadMe.txt"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Manual\Racers 2 USA PC manual.pdf"; DestDir: "{app}"; Flags: external ignoreversion
Source: "ICON\*"; DestDir: "{app}\ICON"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{code:GetSourceDrive}install\game data\*"; DestDir: "{app}\game data"; Flags: external ignoreversion recursesubdirs createallsubdirs
Source: "{code:GetSourceDrive}install\GAMEDATA.GTC"; DestDir: "{app}"; Flags: external ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "CDpath"; ValueData: "{code:GetSourceDrive}"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: none; ValueName: "moviespath"; ValueData: "{app}"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2\0.00.00.00.001a"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe\"; ValueType: string; ValueName: "(Default)"; ValueData: "{app}\LEGO Racers 2.exe"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletekey

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
 
[Code]
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
