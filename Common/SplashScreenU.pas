unit SplashScreenU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.Imaging.jpeg;

type
  TFormSplash = class(TForm)
    ImageAppLogo: TImage;
    LabelDisplayInformation: TLabel;
    LabelVersionNumver: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure ShowSplashscreen(Const AString : String = 'Processing Data...'; const aPictureName : String ='');
Procedure HideSplashScreen;
Procedure ShowSplashScreenMessage( const S: String );
function GetFileVersion(FileName: string): String;

implementation

uses PBThreadedSplashscreenU;

{$R *.dfm}
var
  ThreadedSplashForm: TPBThreadedSplashscreen;


procedure LoadBmpImage(Res: String; aImage: TImage);
var
  aResStream : TResourceStream;
  aPNGImage  : TBitmap;
begin
  aResStream := TResourceStream.Create(hInstance, Res, RT_RCDATA);
  try
    aPNGImage := TBitmap.Create;
    try
      aPNGImage.LoadFromStream(aResStream);
      aImage.Picture.Graphic := aPNGImage;
    finally
      aPNGImage.Free
    end;
  finally
    aResStream.Free
  end;
end;

function GetFileVersion(FileName: string): String;
var
	Size, Size2: DWord;
  AMajor, AMinor, ARelease, ABuild: Word;
	Pt, Pt2: Pointer;
begin
	Result := '';
	// Get version information size in exe file
	Size := GetFileVersionInfoSize(PChar(FileName), Size2);
	// Make sure there is version information in the first place
	if Size > 0 then
	begin
		GetMem(Pt, Size);
		try
			if GetFileVersionInfo(PChar(FileName), 0, Size, Pt) then
			begin
			if VerQueryValue(Pt, '\', Pt2, Size2) then
				with TVSFixedFileInfo(Pt2^) do
				begin
					AMajor := HiWord(dwFileVersionMS);
					AMinor := LoWord(dwFileVersionMS);
					ARelease := HiWord(dwFileVersionLS);
					ABuild := LoWord(dwFileVersionLS);
				end;
			end;
		finally
			FreeMem(Pt, Size);
		end;
	end; // if Size > 0

  //Major version number
  Result := Format('Version: %d.', [AMajor]);
  //Minor version number
  if AMinor <= 9 then
    Result := Result + Format('0%d.', [AMinor])
  else
    Result := Result + Format('%d.', [AMinor]);
  //Release version number
  if ARelease <= 9 then
    Result := Result + Format('0%d.', [ARelease])
  else
    Result := Result + Format('%d.', [ARelease]);
  //Build version number
  if ABuild <= 9 then
    Result := Result + Format('0%d', [ABuild])
  else
    Result := Result + Format('%d', [ABuild]);

  if Result='' then
		Result := 'Version information not included in this file';
end;

{: Create a hidden instance of the TSplashForm class and use it as a
   template for the real splash form. The template is only a convenience
   to be able to design the splash from in the IDE, it may serve as
   an about box as well, however. }
Procedure ShowSplashscreen(Const AString : String = 'Processing Data...'; const aPictureName : String ='' );
  Var
    SplashForm: TFormSplash;
    bmp: TBitmap;
  Begin
    If Assigned( ThreadedSplashForm ) Then
      Exit;
    Splashform := TFormSplash.Create( Application );
    SplashForm.LabelVersionNumver.Caption := GetFileVersion(Application.ExeName);
    SplashForm.LabelDisplayInformation.Caption := AString;
    if aPictureName<>'' then
      LoadBmpImage(aPictureName, Splashform.ImageAppLogo);
    try
      ThreadedSplashForm:= TPBThreadedSplashscreen.Create( nil );
      Try
        ThreadedSplashform.Left  := Splashform.Left;
        ThreadedSplashform.Top   := Splashform.Top;
        ThreadedSplashform.Center:= True;
        bmp:= Splashform.GetFormImage;
        try
          ThreadedSplashform.Image := bmp;
        finally
          bmp.Free;
        end;
        ThreadedSplashForm.UseStatusbar  := True;
        ThreadedSplashForm.Show;
      Except
        FreeAndNil(ThreadedSplashForm);
        raise;
      End; { Except }
    finally
      Splashform.Free;
    end;
  End;

Procedure HideSplashScreen;
  Begin
    FreeAndNil(ThreadedSplashForm);
  End;

Procedure ShowSplashScreenMessage( const S: String );
  Begin
    If Assigned( ThreadedSplashForm ) Then
      ThreadedSplashForm.ShowStatusMessage( S );
  End;

end.
