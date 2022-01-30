unit UBuscaBloqueDeCadenaEnFichero;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus,
  ComCtrls, AppEvnts, UBusquedaBloque;

const C_CONDICION = '*.txt';

type
  TFormBloqueDeCadenaEnFichero = class(TForm)
    StatusBar: TStatusBar;
    PopupMenu: TPopupMenu;
    Panel1: TPanel;
    gbParams: TGroupBox;
    Panel2: TPanel;
    lbFiles: TListBox;
    Button1: TButton;
    cbCaseSensitive: TCheckBox;
    cbRecurse: TCheckBox;
    Guardarlista1: TMenuItem;
    Abrirficheroseleccionado1: TMenuItem;
    Procesarficheroseleccionado1: TMenuItem;
    GroupBox1: TGroupBox;
    edtPathName: TEdit;
    btnPath: TButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    GroupBox4: TGroupBox;
    ComboBox1: TComboBox;
    btnSearch: TBitBtn;
    btnStop: TBitBtn;
    procedure btnSearchClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure lbFilesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbFilesDblClick(Sender: TObject);
    procedure edtTokenChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure Guardarlista1Click(Sender: TObject);
    procedure Abrirficheroseleccionado1Click(Sender: TObject);
    procedure Procesarficheroseleccionado1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    procedure ReadIni;
    procedure WriteIni;
    procedure OnTerminateThread(Sender: TObject);
  public
    Running: Boolean;
    SearchPri: Integer;
    SearchThread: TSearchThread;
    procedure EnableSearchControls(Enable: Boolean);
  end;

var
  FormBloqueDeCadenaEnFichero: TFormBloqueDeCadenaEnFichero;

implementation

{$R *.DFM}

uses Printers, ShellAPI, StrUtils, FileCtrl, Registry, UGuardaEnRegistro,
  Child, Frame;

//-----------------------------------------------------------------------------
// Activa o desactiva los controles.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.EnableSearchControls(Enable: Boolean);
begin
btnSearch.Enabled := Enable;
btnSearch.Visible := Enable;
btnStop.Enabled := not Enable;
btnStop.Visible := not Enable;
ComboBox1.Enabled := Enable;
cbRecurse.Enabled := Enable;
cbCaseSensitive.Enabled := Enable;
btnPath.Enabled := Enable;
edtPathName.Enabled := Enable;
Memo1.Enabled := Enable;
Running := not Enable;
edtTokenChange(nil);
end;

//-----------------------------------------------------------------------------
// Inicia la búsqueda.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.btnSearchClick(Sender: TObject);
var PeriodoBase: Integer;
begin
if Memo1.Text = '' then
   begin
   Application.MessageBox('Debe introducir un bloque para buscarlo.', 'Entrada incorrecta', MB_ICONERROR);
   Exit;
   end;
if Edit1.Text = '' then
   begin
   Application.MessageBox('Debe indicar el período en que se buscará.', 'Entrada incorrecta', MB_ICONERROR);
   Exit;
   end;
try PeriodoBase := StrToInt(Edit1.Text); except Exit end;
EnableSearchControls(False);
lbFiles.Clear;
SearchThread := TSearchThread.Create(cbCaseSensitive.Checked,          //Indica si se debe diferenciar entre May y Min.
                                     cbRecurse.Checked,                //Indica si se debe buscar dentro de las carpetas.
                                     Memo1.Lines,                      //Boque que se busca.
                                     PeriodoBase,                      //Período en que se busca el bloque.
                                     edtPathName.Text,                 //Carpeta en la que se debe buscar.
                                     C_CONDICION,                      //Condición para el nombre del fichero.
                                     lbFiles,                          //ListBox en el que se muestran los resultados.
                                     StatusBar,                        //StatusBarr en la que se muestran los ficheros que se están analizando.
                                     SearchPri);                       //Prioridad del subproceso.
SearchThread.OnTerminate := OnTerminateThread;
SearchThread.Resume;
end;

//-----------------------------------------------------------------------------
// Lo que se hace al finalizar la búsqueda.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.OnTerminateThread(Sender: TObject);
begin
if WindowState = wsMinimized then WindowState := wsNormal;             //Muestra la ventana si está minimizada.
EnableSearchControls(True);                                            //Activa los controles.
MessageBeep(MB_OK);                                                    //Lanza un menzaje sonoro.
end;


//-----------------------------------------------------------------------------
// Activa el botón de búsqueda.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.edtTokenChange(Sender: TObject);
begin
btnSearch.Enabled := not Running and(Memo1.Text <> '') and (Edit1.Text <> '');
end;

procedure TFormBloqueDeCadenaEnFichero.Edit1Change(Sender: TObject);
begin
btnSearch.Enabled := not Running and(Memo1.Text <> '') and (Edit1.Text <> '');
end;

//-----------------------------------------------------------------------------
// Permite al usuario seleccionar la ruta donde se encuentrar los
// ficheros que serán analizados.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.btnPathClick(Sender: TObject);
var ShowDir, msg: String;
begin
msg := 'Seleccione la carpeta que contiene los ficheros de demodulación que desea analizar.';
if SelectDirectory(msg, '', ShowDir) then edtPathName.Text := ShowDir + '\';
end;


//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.lbFilesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var CurStr: string;
begin
with lbFiles do
     begin
     CurStr := Items.Strings[Index];
     Canvas.FillRect(Rect);
     DrawText(Canvas.Handle, PChar(CurStr), Length(CurStr), Rect, DT_SINGLELINE);
     end;
end;

//-----------------------------------------------------------------------------
// Guarda la configuración en el registro.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.FormDestroy(Sender: TObject);
begin
WriteIni;
end;

//-----------------------------------------------------------------------------
// Lee desde el registro, la configuración del programa.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.FormCreate(Sender: TObject);
begin
DoubleBuffered := True;
Panel1.DoubleBuffered := True;
Panel2.DoubleBuffered := True;
GroupBox1.DoubleBuffered := True;
GroupBox2.DoubleBuffered := True;
GroupBox3.DoubleBuffered := True;
GroupBox4.DoubleBuffered := True;
Memo1.DoubleBuffered := True;
edtPathName.DoubleBuffered := True;
gbParams.DoubleBuffered := True;
lbFiles.DoubleBuffered := True;
Constraints.MinHeight := Height;
Constraints.MinWidth := Width;
ReadIni;
ComboBox1.ItemIndex := 0;
end;


//-----------------------------------------------------------------------------
// Permite abrir con el Notepad, los ficheros encontrados.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.lbFilesDblClick(Sender: TObject);
var ProgramStr, FileStr: string;
    RetVal: THandle;
begin
if lbFiles.ItemIndex >= 0 then
   begin
   ProgramStr := SrchIniFile.ReadString('Defaults', 'Editor', 'notepad');                         //Carga el editor de textos desde el fichero INI.  Por defecto el Notepad.
   FileStr := lbFiles.Items[lbFiles.ItemIndex];                                                   // coger el fichero seleccionado
   RetVal := ShellExecute(Handle, 'open', PChar(ProgramStr), PChar(FileStr), nil, SW_SHOWNORMAL); //Muestra el fichero con el editor de textos.
   if RetVal < 32 then RaiseLastWin32Error;                                                       //Comprueba si hay error.
   end;
end;


//-----------------------------------------------------------------------------
// Lee del registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.ReadIni;
begin
with SrchIniFile do
     begin
     edtPathName.Text := ReadString('HerramientaBuscadorDeBloque', 'UltimaRutaDeBusqueda', 'C:\');
     Memo1.Text := ReadString('HerramientaBuscadorDeBloque', 'UltimaCadenaBuscada', '');
     cbCaseSensitive.Checked := ReadBool('HerramientaBuscadorDeBloque', 'DiferenciarMayusculasMinusculas', False);
     cbRecurse.Checked := ReadBool('HerramientaBuscadorDeBloque', 'BuscarDentroDeSubcarpetas', False);
     end;
end;

//-----------------------------------------------------------------------------
// Escribe en el registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.WriteIni;
begin
with SrchIniFile do
     begin
     WriteString('HerramientaBuscadorDeBloque', 'UltimaRutaDeBusqueda', edtPathName.Text);
     WriteString('HerramientaBuscadorDeBloque', 'UltimaCadenaBuscada', Memo1.Text);
     WriteBool('HerramientaBuscadorDeBloque', 'DiferenciarMayusculasMinusculas', cbCaseSensitive.Checked);
     WriteBool('HerramientaBuscadorDeBloque', 'BuscarDentroDeSubcarpetas', cbRecurse.Checked);
     end;
end;

//-----------------------------------------------------------------------------
// Cambia la prioridad del subproceso.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.ComboBox1Change(Sender: TObject);
begin
if TComboBox(Sender).ItemIndex >= 0 then SearchPri := TComboBox(Sender).ItemIndex + 3;
end;

//-----------------------------------------------------------------------------
// Detiene el subproceso antes de terminar.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Running then SearchThread.Terminate;
end;

//------------------------------------------------------------------------------
// Muestra la ayuda de la ventana.
//------------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.Button1Click(Sender: TObject);
var msg: String;
begin
msg := 'BUSCADOR DE CADENAS EN FICHEROS' + #13#13;
msg := msg + 'Esta herramienta analiza todos los ficheros de texto' + #13;
msg := msg + 'con extensión TXT que se encuentren en el directorio' + #13;
msg := msg + 'indicado como parámetro. También puede buscar en los' + #13;
msg := msg + 'directorios que se encuentren anidados.' + #13#13;
msg := msg + 'La herramienta devuelve en una lista, los nombres de' + #13;
msg := msg + 'los ficheros que contienen en su interior la cadena' + #13;
msg := msg + 'de texto pasada como parámetro.';
MessageBox(0, PChar(msg), 'AYUDA', MB_OK);
end;

//-----------------------------------------------------------------------------
// Detiene el subproceso si cerrar la aplicación.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.btnStopClick(Sender: TObject);
begin
if Running then SearchThread.Terminate
end;

//-----------------------------------------------------------------------------
// Guarda la lista en un fichero de texto.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.Guardarlista1Click(Sender: TObject);
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(nil);                                                //Crea un diálogo.
dlg.Title := 'Guardar lista...';                                               //Título del diálogo.
dlg.DefaultExt := 'txt';
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Tipos de ficheros que se muestran.
if dlg.Execute then
   lbFiles.Items.SaveToFile(dlg.FileName);
dlg.Free;                                                                      //Destruye el diálogo creado.
end;

//-----------------------------------------------------------------------------
// Muestra el fichero seleccionado.
//-----------------------------------------------------------------------------
procedure TFormBloqueDeCadenaEnFichero.Abrirficheroseleccionado1Click(Sender: TObject);
begin
lbFilesDblClick(Self);
end;

procedure TFormBloqueDeCadenaEnFichero.Procesarficheroseleccionado1Click(
  Sender: TObject);
begin
if lbFiles.ItemIndex >= 0 then
   MainForm.ProcesarFichero(lbFiles.Items[lbFiles.ItemIndex]);
end;


end.
