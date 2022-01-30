unit UGuardaEnRegistro;

interface

uses Registry;

var
  SrchIniFile: TRegIniFile;

implementation

initialization
  SrchIniFile := TRegIniFile.Create('\Software\SetVmas\BitralDecode');
finalization
  SrchIniFile.Free;
  SrchIniFile := nil;
end.
