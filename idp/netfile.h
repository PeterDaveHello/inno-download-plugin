#pragma once

#include "tstring.h"
#include "url.h"

using namespace std;

class NetFile
{
public:
    NetFile(tstring url, tstring filename = _T(""), DWORDLONG filesize = FILE_SIZE_UNKNOWN, tstring comp = _T(""));
    ~NetFile();

    bool    open(HINTERNET internet);
    void    close();
    bool    read(void *buffer, DWORD size, DWORD *bytesRead);
    tstring getShortName();
    bool    selected(set<tstring> comp);
    DWORDLONG getSize(HINTERNET internet);

    Url          url;
    tstring      name;
    tstring      destDir;
    set<tstring> components;
    DWORDLONG    size;
    DWORDLONG    bytesDownloaded;
    bool         downloaded;
    HINTERNET    handle;
    tstring      mirrorUsed;
};
