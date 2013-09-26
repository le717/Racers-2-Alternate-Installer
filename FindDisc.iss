//  Click-And-Go LEGO LOCO Alternate Installer
//  Copyright (c) 2012 le717
//  http://triangle717.wordpress.com
//  Contains source code from Grim Fandango Setup
//  Copyright (c) 2007-2008 Bgbennyboy
//  Http://quick.mixnmojo.com
//  And http://www.vincenzo.net/isxkb/index.php?title=Ask_for_a_drive_to_install
//  Code modified by Bgbennyboy to search for a unique file
//  and by le717 to support ANSI and Unicode InnoSetup

[Code]

var
	DrvLetters: array of AnsiString;

	function GetDriveType( lpDisk: AnsiString ): Integer;
	external 'GetDriveTypeA@kernel32.dll stdcall';

	function GetLogicalDriveStrings( nLenDrives: LongInt; lpDrives: AnsiString ): Integer;
	external 'GetLogicalDriveStringsA@kernel32.dll stdcall';

const
	UniqueFile = 'install\game data\music\bonus.1';

	DRIVE_UNKNOWN = 0; // The drive type cannot be determined.
	DRIVE_NO_ROOT_DIR = 1; // The root path is invalid. For example, no volume is mounted at the path.
	DRIVE_REMOVABLE = 2; // The disk can be removed from the drive.
	DRIVE_FIXED = 3; // The disk cannot be removed from the drive.
	DRIVE_REMOTE = 4; // The drive is a remote (network) drive.
	DRIVE_CDROM = 5; // The drive is a CD-ROM drive.
	DRIVE_RAMDISK = 6; // The drive is a RAM disk.

//Convert disk type to string
function DriveTypeString( dtype: Integer ): AnsiString ;
begin
	case dtype of
		DRIVE_NO_ROOT_DIR : Result := 'Root path invalid';
		DRIVE_REMOVABLE : Result := 'Removable';
		DRIVE_FIXED : Result := 'Fixed';
		DRIVE_REMOTE : Result := 'Network';
		DRIVE_CDROM : Result := 'CD-ROM';
		DRIVE_RAMDISK : Result := 'Ram disk';
		else
			Result := 'Unknown';
	end;
end;

procedure FindAllCdDrives();
var
	n: Integer;
	drivesletters: AnsiString; lenletters: Integer;
	drive: AnsiString;
	disktype, posnull: Integer;
	sd: AnsiString;
begin
	//get the system drive
	sd := UpperCase(ExpandConstant('{sd}'));

	//get all drives letters of system
	drivesletters := StringOfChar( ' ', 64 );
	lenletters := GetLogicalDriveStrings( 63, drivesletters );
	SetLength( drivesletters , lenletters );

	drive := '';
	n := 0;
	while ( (Length(drivesletters) > 0) ) do
	begin
		posnull := Pos( #0, drivesletters );
		if posnull > 0 then
		begin
			drive:= UpperCase( Copy( drivesletters, 1, posnull - 1 ) );

			// get number type of disk
			disktype := GetDriveType( drive );

			//Make sure its a cd drive
			if disktype = DRIVE_CDROM then
			begin
				SetArrayLength(DrvLetters, N+1);
				DrvLetters[n] := drive;
				n := n + 1;
			end;

			drivesletters := Copy( drivesletters, posnull+1, Length(drivesletters));
		end;
	end;
end;

function FindUniqueFile(): Ansistring;
var
	i: integer;
begin
	for i:=0 to GetArrayLength(DrvLetters) -1 do
	begin
		if FileExists( DrvLetters[i] + UniqueFile) then
		begin
			result:=DrvLetters[i];
			exit;
		end
		else

	end;

	result:='';
end;

function GetSourceCdDrive(): Ansistring;
begin
	FindAllCdDrives();
	if GetArrayLength(DrvLetters) < 1 then
	begin
		MsgBox('I''m sorry, but I could not find any disc drives attached to your computer. Are you sure you are even have an optical drive?', mbError, MB_OK);
		Abort;
	end;


	if FindUniqueFile() <> '' then
	begin
		MsgBox('A LEGO Racers 2 disc has been found. Installation will now continue.', mbError, MB_OK);
	end
	else
	begin
		while FindUniqueFile() = '' do
		begin
			if MsgBox('Well, this is embarrassing. I seem to have misplaced your LEGO Racers 2 disc. Perhaps you can refresh my memory. Please remind me where your disc is and press OK, or press Cancel to exit the Setup.', mbConfirmation, MB_OKCANCEL or MB_DEFBUTTON1) = IDOK then

			else
				Abort;
		end;
	end;

	Result:=FindUniqueFile(); //Not a nice way of doing things at all but it'll do for now
end;
