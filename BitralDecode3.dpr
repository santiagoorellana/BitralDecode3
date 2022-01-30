program BitralDecode3;

uses
  Forms,
  FRAME in 'FRAME.PAS' {MainForm},
  Child in 'CHILD.PAS' {ChildForm},
  DataManager in 'DataManager.pas',
  HistoryDataManager in 'HistoryDataManager.pas',
  SimpleRaster in 'SimpleRaster.pas',
  ULista in 'ULista.pas',
  UAmpliador in 'UAmpliador.pas' {FormAmpliador},
  EditableRaster in 'EditableRaster.pas',
  EditableText in 'EditableText.pas',
  UBuscaBloqueDeCadenaEnFichero in 'UBuscaBloqueDeCadenaEnFichero.pas' {FormBloqueDeCadenaEnFichero},
  UBuscaPeriodos in 'UBuscaPeriodos.pas',
  UBusquedaBloque in 'UBusquedaBloque.pas',
  UCoincidencia in 'UCoincidencia.pas' {FormCoincidencia},
  UComparadorDeFicheros in 'UComparadorDeFicheros.pas',
  UComparadorDeFicherosMost in 'UComparadorDeFicherosMost.pas',
  UComparadorDIFF in 'UComparadorDIFF.pas' {FormComparadorDIFF},
  UComparadorMOST in 'UComparadorMOST.pas' {FormComparadorMost},
  UDialogoBuscar in 'UDialogoBuscar.pas' {FormBuscaCoincidencia},
  UDiff in 'UDiff.pas',
  UFuenteDeDemodulacion in 'UFuenteDeDemodulacion.pas',
  UGuardaEnRegistro in 'UGuardaEnRegistro.pas',
  UInterfaceBuscaPeriodo in 'UInterfaceBuscaPeriodo.pas' {FormBuscaPeriodos},
  UListaMost in 'UListaMost.pas',
  UListaSegmentos in 'UListaSegmentos.pas',
  UProcedencia in 'UProcedencia.pas' {FormProcedencia},
  UConvertirEnBinario in 'UConvertirEnBinario.pas' {FormConvertirEnBinario},
  UEstadisticas in 'UEstadisticas.pas' {FormEstadisticas},
  UEstructurarDemodulacion in 'UEstructurarDemodulacion.pas' {FormEstructurarDemodulacion},
  UBuscaCadenaEnFichero in 'UBuscaCadenaEnFichero.pas' {FormCadenaEnFichero},
  UBusqueda in 'UBusqueda.pas',
  UComparadorLevenshtein in 'UComparadorLevenshtein.pas' {FormComparadorLevenshtein};

{$R *.RES}

begin
  Application.Title := 'Bitral Decode';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

