; Uncomment one of following lines, if you haven't checked "Add IDP include path to ISPPBuiltins.iss" option during IDP installation:
;#pragma include __INCLUDE__ + ";" + ReadReg(HKLM, "Software\Mitrich Software\Inno Download Plugin", "InstallDir")
;#pragma include __INCLUDE__ + ";" + "c:\lib\InnoDownloadPlugin"

[Setup]
AppName          = My Program
AppVersion       = 1.0
DefaultDirName   = {pf}\My Program
DefaultGroupName = My Program
OutputDir        = userdocs:Inno Setup Examples Output

[Languages]
Name: en;    MessagesFile: "compiler:Default.isl"
;Name: be;   MessagesFile: "compiler:Languages\Belarusian.isl"
;Name: bg;   MessagesFile: "compiler:Languages\Bulgarian.isl"
;Name: bs;   MessagesFile: "compiler:Languages\Bosnian.isl"
;Name: zh;   MessagesFile: "compiler:Languages\ChineseSimplified.isl"
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
;Name: sk;   MessagesFile: "compiler:Languages\Slovak.isl"
Name: sl;    MessagesFile: "compiler:Languages\Slovenian.isl"
Name: es;    MessagesFile: "compiler:Languages\Spanish.isl"

#include <idp.iss>
; Language files must be included after idp.iss and after [Languages] section
;#include <idplang\Belarusian.iss>
;#include <idplang\Bosnian.iss>
;#include <idplang\Bulgarian.iss>
;#include <idplang\ChineseSimplified.iss>
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
;#include <idplang\Slovak.iss>
#include <idplang\Slovenian.iss>
#include <idplang\Spanish.iss>

; Let's change some of standard strings:
[CustomMessages]
en.IDP_FormCaption=Downloading lot of files...

[Icons]
Name: "{group}\{cm:UninstallProgram,My Program}"; Filename: "{uninstallexe}"

[Code]
procedure InitializeWizard();
begin
    idpAddFile('http://127.0.0.1/test1.zip', ExpandConstant('{tmp}\test1.zip'));
    idpAddFile('http://127.0.0.1/test2.zip', ExpandConstant('{tmp}\test2.zip'));
    idpAddFile('http://127.0.0.1/test3.zip', ExpandConstant('{tmp}\test3.zip'));

    idpDownloadAfter(wpReady);
end;
