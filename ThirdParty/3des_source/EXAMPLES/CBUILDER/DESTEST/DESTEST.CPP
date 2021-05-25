//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Destest.res");
USEFORM("frmTest.cpp", frmTestDes);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->Title = "DESTest";
                 Application->CreateForm(__classid(TfrmTestDes), &frmTestDes);
                 Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
