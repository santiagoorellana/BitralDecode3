unit UAmpliador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, AppEvnts;

type
  TFormAmpliador = class(TForm)
    TrackBar1: TTrackBar;
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DibujarAMpliacion;
  end;

var
  FormAmpliador: TFormAmpliador;

  // variables
  Srect,Drect,PosForme:TRect;
  DmX,DmY:Integer;
  C:TCanvas;
  hDesktop: Hwnd;
  Kursor:TPoint;

implementation

{$R *.dfm}

procedure TFormAmpliador.DibujarAMpliacion;
begin
//Si la aplicación no está iconizada.
If not IsIconic(Application.Handle) then
  begin
  GetCursorPos(Kursor);
  hDesktop:= GetDesktopWindow;                                  //PosForme Representa el rectángulo del formulario.
  PosForme:=Rect(Left, Top, Left + Width, Top + Height);
//  If PtInRect(PosForme,Kursor) then Exit;
  Srect := Rect(Kursor.x, Kursor.y, Kursor.x, Kursor.y);
  InflateRect(Srect,                                            //Este código amplia el rectángulo.
              Round((Image1.Width / 2) / TrackBar1.Position),
              Round((Image1.Height / 2) / TrackBar1.Position));
  C := TCanvas.Create;                                          //Recupera el handle del Escritorio de Windows.
  try
     C.Handle := GetDC(GetDesktopWindow);
     Image1.Picture := nil;
     Image1.Canvas.CopyRect(Image1.ClientRect, C, Srect);
  finally
     ReleaseDC(hDesktop, C.Handle);
     C.Free;
  end;
  end;
Image1.Canvas.MoveTo(Image1.Width div 2, Image1.Height div 4);
Image1.Canvas.LineTo(Image1.Width div 2, Image1.Height - (Image1.Height div 4));
Image1.Canvas.MoveTo(Image1.Width div 4, Image1.Height div 2);
Image1.Canvas.LineTo(Image1.Width - (Image1.Width div 4), Image1.Height div 2);
Application.ProcessMessages;
end; 


procedure TFormAmpliador.Timer1Timer(Sender: TObject);
begin
DibujarAMpliacion;
Application.ProcessMessages;
end;

procedure TFormAmpliador.FormCreate(Sender: TObject);
begin
DoubleBuffered := True;
Caption := 'Ampliador x' + IntToStr(TrackBar1.Position);
end;

procedure TFormAmpliador.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
Image1.Picture := nil;
Image1.Repaint;
end;

procedure TFormAmpliador.TrackBar1Change(Sender: TObject);
begin
Caption := 'Ampliador x' + IntToStr(TrackBar1.Position);

end;

procedure TFormAmpliador.FormShow(Sender: TObject);
begin
Timer1.Enabled := True;
end;

end.
