#include "netfile.h"
#include "trace.h"

NetFile::NetFile(tstring fileurl, tstring filename, DWORDLONG filesize, tstring comp): url(fileurl)
{
    name            = filename;
    size            = filesize;
    destDir         = _T("");
    bytesDownloaded = 0;
    downloaded      = false;
    handle          = NULL;
    mirrorUsed      = _T("");

    tstringtoset(components, comp, _T(' '));
}

NetFile::~NetFile()
{
}

DWORDLONG NetFile::getSize(HINTERNET internet)
{
    DWORDLONG s = url.getSize(internet);
    if(name.empty())
        name = addbackslash(destDir) + filenamefromurl(url.urlString);
    return s;
}

bool NetFile::open(HINTERNET internet)
{
    bytesDownloaded = 0; //NOTE: remove, if download resume will be implemented
    handle = url.open(internet);
    
    //TODO: remove?
    if(name.empty())
        name = addbackslash(destDir) + filenamefromurl(url.urlString);

    return handle != NULL;
}

void NetFile::close()
{
    url.close();
}

bool NetFile::read(void *buffer, DWORD size, DWORD *bytesRead)
{
    BOOL res = InternetReadFile(handle, buffer, size, bytesRead);
    bytesDownloaded += *bytesRead;
    return res != FALSE;
}

tstring NetFile::getShortName()
{
    return filenamefrompath(name);
}

bool NetFile::selected(set<tstring> comp)
{
    if(components.empty())
        return true;

    TRACE(_T("NetFile::selected for %s"), getShortName().c_str());

    for(set<tstring>::iterator i = components.begin(); i != components.end(); i++)
    {
        tstring comp1 = *i;
        for(set<tstring>::iterator j = comp.begin(); j != comp.end(); j++)
        {
            tstring comp2 = *j;
            TRACE(_T("1=%s 2=%s"), comp1.c_str(), comp2.c_str());
            if(comp1 == comp2)
                return true;
        }
    }

    return false;
}
