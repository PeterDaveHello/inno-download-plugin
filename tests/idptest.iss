#pragma include __INCLUDE__ + ";" + ReadReg(HKLM, "Software\Mitrich Software\Inno Download Plugin", "InstallDir")

[Setup]
AppName                    = My Program
AppVersion                 = 1.5
DefaultDirName             = {pf}\My Program
DefaultGroupName           = My Program
ShowUndisplayableLanguages = yes
OutputDir                  = .

[Languages]
Name: en;    MessagesFile: "compiler:Default.isl"
Name: be;    MessagesFile: "compiler:Languages\Belarusian.isl"
Name: bg;    MessagesFile: "compiler:Languages\Bulgarian.isl"
Name: bs;    MessagesFile: "compiler:Languages\Bosnian.isl"
Name: zh;    MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: cz;    MessagesFile: "compiler:Languages\Czech.isl"
Name: de;    MessagesFile: "compiler:Languages\German.isl"
Name: hu;    MessagesFile: "compiler:Languages\Hungarian.isl"
Name: fi;    MessagesFile: "compiler:Languages\Finnish.isl"
Name: fr;    MessagesFile: "compiler:Languages\French.isl"
Name: it;    MessagesFile: "compiler:Languages\Italian.isl"
Name: pl;    MessagesFile: "compiler:Languages\Polish.isl"
Name: pt_br; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: ru;    MessagesFile: "compiler:Languages\Russian.isl"
Name: sr;    MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: sk;    MessagesFile: "compiler:Languages\Slovak.isl"
Name: sl;    MessagesFile: "compiler:Languages\Slovenian.isl"
Name: es;    MessagesFile: "compiler:Languages\Spanish.isl"

#define IDP_DEBUG

#include <idp.iss>
#include <idplang\Belarusian.iss>
#include <idplang\Bosnian.iss>
#include <idplang\Bulgarian.iss>
#include <idplang\ChineseSimplified.iss>
#include <idplang\Czech.iss>
#include <idplang\German.iss>
#include <idplang\Hungarian.iss>
#include <idplang\Finnish.iss>
#include <idplang\French.iss>
#include <idplang\Italian.iss>
#include <idplang\Polish.iss>
#include <idplang\BrazilianPortuguese.iss>
#include <idplang\Russian.iss>
#include <idplang\Serbian.iss>
#include <idplang\Slovak.iss>
#include <idplang\Slovenian.iss>
#include <idplang\Spanish.iss>

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

    idpAddFile('http://127.0.0.1/test1.rar', ExpandConstant('{src}\test1.rar'));
    idpAddFile('http://127.0.0.1/test2.rar', ExpandConstant('{src}\test2.rar'));
    idpAddFile('http://127.0.0.1/test3.rar', ExpandConstant('{src}\test3.rar'));

    idpDownloadAfter(wpWelcome);
end;
