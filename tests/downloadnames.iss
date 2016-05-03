[Setup]
AppName                    = My Program
AppVersion                 = 1.5
DefaultDirName             = {pf}\My Program
DefaultGroupName           = My Program
ShowUndisplayableLanguages = yes
OutputDir                  = .

#define IDP_DEBUG
#include <idp.iss>

[Files]
Source: "idptest.iss"; DestDir: "{app}"

[Icons]
Name: "{group}\{cm:UninstallProgram,My Program}"; Filename: "{uninstallexe}"

[Code]
procedure InitializeWizard();
begin
    idpSetOption('DetailedMode',  '1');
    idpSetOption('AllowContinue', '1');
    idpSetOption('ErrorDialog',   'URLList');

    idpSetDestDir(ExpandConstant('{src}'), false);
    idpAddF('http://127.0.0.1/test1.rar');
    idpAddF('http://127.0.0.1/test2.rar');

    idpDownloadAfter(wpWelcome);
end;

procedure CurPageChanged(CurPageID: Integer);
var fileList: TStringList;
    i: Integer;
begin
    if CurPageID = wpReady then
    begin
        fileList := TStringList.Create;

        MsgBox('Downloaded files', mbInformation, MB_OK);
        idpGetFileList(fileList, IDP_DOWNLOADED);
        for i := 0 to fileList.Count-1 do
            MsgBox(fileList[i], mbInformation, MB_OK);
    end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var r: Boolean;
    filename: String;
begin
    SetLength(filename, 260);

    if CurStep = ssInstall then
    begin
        MsgBox('Testing idpDownloadFile & idpDownloadFileDir', mbInformation, MB_OK);

        r := idpDownloadFile('http://127.0.0.1/test1.rar', ExpandConstant('{src}\test1_2.rar'));
        if r then MsgBox('idpDownloadFile OK',     mbInformation, MB_OK)
        else      MsgBox('idpDownloadFile FAILED', mbError,       MB_OK);

        r := idpDownloadFileDir('http://127.0.0.1/test3.rar', ExpandConstant('{src}'), filename);
        if r then MsgBox('idpDownloadFileDir OK: ' + filename, mbInformation, MB_OK)
        else      MsgBox('idpDownloadFileDir FAILED',          mbError,       MB_OK);
    end;
end;


