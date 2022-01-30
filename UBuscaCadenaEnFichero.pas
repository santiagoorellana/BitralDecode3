unit UBuscaCadenaEnFichero;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus,
  ComCtrls, AppEvnts, UBusqueda;

const C_CONDICION = '*.txt';

type
  TFormCadenaEnFichero = class(TForm)
    StatusBar: TStatusBar;
    PopupMenu: TPopupMenu;
    Panel1: TPanel;
    gbParams: TGroupBox;
    LToken: TLabel;
    lPathName: TLabel;
    edtToken: TEdit;
    btnPath: TButton;
    edtPathName: TEdit;
    btnSearch: TBitBtn;
    Panel2: TPanel;
    lbFiles: TListBox;
    Button1: TButton;
    ComboBox1: TComboBox;
    cbCaseSensitive: TCheckBox;
    cbRecurse: TCheckBox;
    Guardarlista1: TMenuItem;
    btnStop: TBitBtn;
    Abrirficheroseleccionado1: TMenuItem;
    Procesarficheroseleccionado1: TMenuItem;
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
  FormCadenaEnFichero: TFormCadenaEnFichero;

implementation

{$R *.DFM}

uses Printers, ShellAPI, StrUtils, FileCtrl, Registry, UGuardaEnRegistro,
  Child, Frame;

//-----------------------------------------------------------------------------
// Activa o desactiva los controles.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.EnableSearchControls(Enable: Boolean);
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
edtToken.Enabled := Enable;
Running := not Enable;
edtTokenChange(nil);
end;

//-----------------------------------------------------------------------------
// Inicia la búsqueda.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.btnSearchClick(Sender: TObject);
begin
if edtToken.Text = '' then Exit;
EnableSearchControls(False);
lbFiles.Clear;
SearchThread := TSearchThread.Create(cbCaseSensitive.Checked,          //Indica si se debe diferenciar entre May y Min.
                                     cbRecurse.Checked,                //Indica si se debe buscar dentro de las carpetas.
                                     edtToken.Text,                    //Cadena que se busca.
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
procedure TFormCadenaEnFichero.OnTerminateThread(Sender: TObject);
begin
if WindowState = wsMinimized then WindowState := wsNormal;             //Muestra la ventana si está minimizada.
EnableSearchControls(True);                                            //Activa los controles.
MessageBeep(MB_OK);                                                    //Lanza un menzaje sonoro.
end;


//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.edtTokenChange(Sender: TObject);
begin
btnSearch.Enabled := not Running and(edtToken.Text <> '');
end;

//-----------------------------------------------------------------------------
// Permite al usuario seleccionar la ruta donde se encuentrar los
// ficheros que serán analizados.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.btnPathClick(Sender: TObject);
var ShowDir, msg: String;
begin
msg := 'Seleccione la carpeta que contiene los ficheros de demodulación que desea analizar.';
if SelectDirectory(msg, '', ShowDir) then edtPathName.Text := ShowDir + '\';
end;


//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.lbFilesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
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
procedure TFormCadenaEnFichero.FormDestroy(Sender: TObject);
begin
WriteIni;
end;

//-----------------------------------------------------------------------------
// Lee desde el registro, la configuración del programa.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.FormCreate(Sender: TObject);
begin
DoubleBuffered := True;
Panel1.DoubleBuffered := True;
Panel2.DoubleBuffered := True;
edtToken.DoubleBuffered := True;
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
procedure TFormCadenaEnFichero.lbFilesDblClick(Sender: TObject);
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
procedure TFormCadenaEnFichero.ReadIni;
begin
with SrchIniFile do
     begin
     edtPathName.Text := ReadString('HerramientaBuscadorDeCadenas', 'UltimaRutaDeBusqueda', 'C:\');
     edtToken.Text := ReadString('HerramientaBuscadorDeCadenas', 'UltimaCadenaBuscada', '');
     cbCaseSensitive.Checked := ReadBool('HerramientaBuscadorDeCadenas', 'DiferenciarMayusculasMinusculas', False);
     cbRecurse.Checked := ReadBool('HerramientaBuscadorDeCadenas', 'BuscarDentroDeSubcarpetas', False);
     end;
end;

//-----------------------------------------------------------------------------
// Escribe en el registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.WriteIni;
begin
with SrchIniFile do
     begin
     WriteString('HerramientaBuscadorDeCadenas', 'UltimaRutaDeBusqueda', edtPathName.Text);
     WriteString('HerramientaBuscadorDeCadenas', 'UltimaCadenaBuscada', edtToken.Text);
     WriteBool('HerramientaBuscadorDeCadenas', 'DiferenciarMayusculasMinusculas', cbCaseSensitive.Checked);
     WriteBool('HerramientaBuscadorDeCadenas', 'BuscarDentroDeSubcarpetas', cbRecurse.Checked);
     end;
end;

//-----------------------------------------------------------------------------
// Cambia la prioridad del subproceso.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.ComboBox1Change(Sender: TObject);
begin
if TComboBox(Sender).ItemIndex >= 0 then SearchPri := TComboBox(Sender).ItemIndex + 3;
end;

//-----------------------------------------------------------------------------
// Detiene el subproceso antes de terminar.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Running then SearchThread.Terminate;
end;

//------------------------------------------------------------------------------
// Muestra la ayuda de la ventana.
//------------------------------------------------------------------------------
procedure TFormCadenaEnFichero.Button1Click(Sender: TObject);
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
procedure TFormCadenaEnFichero.btnStopClick(Sender: TObject);
begin
if Running then SearchThread.Terminate
end;

//-----------------------------------------------------------------------------
// Guarda la lista en un fichero de texto.
//-----------------------------------------------------------------------------
procedure TFormCadenaEnFichero.Guardarlista1Click(Sender: TObject);
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
procedure TFormCadenaEnFichero.Abrirficheroseleccionado1Click(Sender: TObject);
begin
lbFilesDblClick(Self);
end;

procedure TFormCadenaEnFichero.Procesarficheroseleccionado1Click(
  Sender: TObject);
begin
MainForm.ProcesarFichero(lbFiles.Items[lbFiles.ItemIndex]);
end;

end.
