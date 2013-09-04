#define ProgName "Inno Download Plugin"
#define ProgVer  Copy(GetFileVersion("unicode\idp.dll"), 1, 5)
#define WebSite  "http://mitrich.net23.net"
#define Forum    "https://groups.google.com/forum/#!forum/inno-download-plugin"

[Setup]
AppName              = {#ProgName}
AppVersion           = {#ProgVer}
AppId                = MitrichSoftware.InnoDownloadPlugin
AppCopyright         = (C)2013 Mitrich Software
AppPublisher         = Mitrich Software
AppPublisherURL      = {#WebSite}
AppSupportURL        = {#Forum}
DefaultDirName       = {pf}\{#ProgName}
DefaultGroupName     = {#ProgName}
AllowNoIcons         = yes
SolidCompression     = yes
;UninstallDisplayIcon= {app}\idp.ico
SetupIconFile        = compiler:\Images\Setup.ico
VersionInfoVersion   = {#ProgVer}
OutputBaseFilename   = idpsetup-{#ProgVer}
OutputDir            = .

[CustomMessages]
ForumDescription=Support Forum
Documentation   =Documentation
SourceCode      =Source code
AddIncludePath  =Add IDP include path to ISPPBuiltins.iss

[Components]
Name: main;   Description: "{#ProgName} binaries & documentation"; Types: full compact custom; Flags: fixed
Name: source; Description: "{cm:SourceCode}";                      Types: full

[Tasks]
Name: includepath; Description: "{cm:AddIncludePath}"

[Files]
Source: "unicode\idp.dll";        DestDir: "{app}\unicode";                Components: main
Source: "ansi\idp.dll";           DestDir: "{app}\ansi";                   Components: main
Source: "idp.iss";                DestDir: "{app}";                        Components: main
Source: "unicode\idplang\*.iss";  DestDir: "{app}\unicode\idplang";        Components: main
Source: "ansi\idplang\*.iss";     DestDir: "{app}\ansi\idplang";           Components: main
Source: "idp.html";               DestDir: "{app}";                        Components: main

Source: "idp.iss";                DestDir: "{app}\source";                 Components: source
Source: "unicode\idplang\*.iss";  DestDir: "{app}\source\unicode\idplang"; Components: source
Source: "ansi\idplang\*.iss";     DestDir: "{app}\source\ansi\idplang";    Components: source
Source: "setup.iss";              DestDir: "{app}\source";                 Components: source
Source: "DownloadForm.isf";       DestDir: "{app}\source";                 Components: source
Source: "InnoDownloadPlugin.sln"; DestDir: "{app}\source";                 Components: source
Source: "idp\idp.vcproj";         DestDir: "{app}\source\idp";             Components: source
Source: "idp\*.cpp";              DestDir: "{app}\source\idp";             Components: source
Source: "idp\*.h";                DestDir: "{app}\source\idp";             Components: source
Source: "idp\*.rc";               DestDir: "{app}\source\idp";             Components: source
Source: "idp\*.def";              DestDir: "{app}\source\idp";             Components: source

[Icons]
Name: "{group}\{#ProgName} {cm:Documentation}";    Filename: "idp.html"
Name: "{group}\{cm:ProgramOnTheWeb,{#ProgName}}";  Filename: "{#WebSite}"
Name: "{group}\{cm:ForumDescription}";             Filename: "{#Forum}"
Name: "{group}\{cm:UninstallProgram,{#ProgName}}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}"; Description: "Open Examples folder"; Flags: postinstall shellexec skipifsilent

[Registry]
Root: HKLM; Subkey: "Software\Mitrich Software";             Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\Mitrich Software\{#ProgName}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\Mitrich Software\{#ProgName}"; ValueType: string; ValueName: "InstallDir"; ValueData: "{app}"

[Code]
const idpPathStr = '#pragma include __INCLUDE__ + ";" + ReadReg(HKLM, "Software\Mitrich Software\Inno Download Plugin", "InstallDir")';

function GetInnoSetupInstallDir: String;
var dir: String;
begin
    if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 5_is1', 'InstallLocation', dir) then 
        result := dir
    else
        result := '';
end;

function IncludePathAlreadyAdded: Boolean;
var ISPPBuiltins: TArrayOfString;
    i: Integer;
begin
    LoadStringsFromFile(GetInnoSetupInstallDir + 'ISPPBuiltins.iss', ISPPBuiltins);
    result := false;

    for i := 0 to GetArrayLength(ISPPBuiltins)-1 do
        if ISPPBuiltins[i] = idpPathStr then
        begin
            result := true;
            break;
        end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall then
        if IsTaskSelected('includepath') then
            if FileExists(GetInnoSetupInstallDir + 'ISPPBuiltins.iss') then
                if not IncludePathAlreadyAdded then
                    SaveStringToFile(GetInnoSetupInstallDir + 'ISPPBuiltins.iss', #13#10 + '; Inno Download Plugin include path' + #13#10 + idpPathStr + #13#10, true);
end;