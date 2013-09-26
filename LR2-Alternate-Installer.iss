;  Click-And-Go LEGO Racers 2 Alternate Installer V1.1
;  Copyright © 2012-2013 le717
;  http://triangle717.wordpress.com
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  Http://quick.mixnmojo.com

; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

[Define]
#define MyAppInstallerName "Click-And-Go LEGO Racers 2 Alternate Installer"
#define MyAppInstallerVersion "1.1"
#define MyAppName "LEGO Racers 2"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "LEGO Software"
#define MyAppExeName "LEGO Racers 2.exe"

[Setup]
AppID={
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 2001 {#MyAppPublisher}
LicenseFile=license.txt
DefaultDirName={pf}\LEGO Media\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=true
SetupIconFile=ICON\1.ico
WizardImageFile=LR2 Sidebar Image.bmp
WizardSmallImageFile=InnoSetup LEGO Logo.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
OutputDir=Here Lie The EXE
OutputBaseFilename={#MyAppInstallerName} {#MyAppInstallerVersion}
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
English.BeveledLabel={#MyAppInstallerName} {#MyAppInstallerVersion}
; English.WelcomeLabel2 is overridden because I'm unsure if every LEGO Racers 2 disc says version 1.0.0.0 or just mine.
English.WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; English.DiskSpaceMBLabel is disabled because it reports an incorrect installation size.
English.DiskSpaceMBLabel=
English.StatusExtractFiles=Installing files...

; Both Types and Components sections are required to create the installation options.

[Types]
Name: "Minimal"; Description: "Minimal Installation (Without Movies/Music)"
Name: "Full"; Description: "Full Installation (With Movies/Music)"  

[Components]
Name: "Minimal"; Description: "Minimal Installation (Without Movies/Music)"; Types: Minimal
Name: "Full"; Description: "Full Installation (With Movies/Music)"; Types: Full 

[Dirs]
Name: "{app}\game data\Saved Games"; Flags: uninsalwaysuninstall; Components: Full Minimal

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

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: none; Flags: uninsdeletevalue; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "CDpath"; ValueData: "{code:GetSourceDrive}"; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "moviespath"; ValueData: "{app}"; Flags: uninsdeletekey; Components: Full
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\Games\LEGO Racers 2"; ValueType: string; ValueName: "moviespath"; ValueData: "{code:GetSourceDrive}\install\"; Flags: uninsdeletekey; Components: Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2"; ValueType: none; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO Racers 2\0.00.00.00.001a"; ValueType: none; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe\"; ValueType: string; ValueName: "(Default)"; ValueData: "{app}\LEGO Racers 2.exe"; Flags: uninsdeletekey; Components: Full Minimal
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGO Racers 2.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletekey; Components: Full Minimal

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

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
