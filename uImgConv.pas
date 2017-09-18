{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2003 by the Free Pascal development team

    Image conversion example.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$mode objfpc}{$h+}
unit uImgConv;
 

interface

uses FPWriteXPM, FPWritePNG, FPWriteBMP,
     FPReadXPM, FPReadPNG, FPReadBMP, fpreadjpeg,fpwritejpeg,
     fpreadtga,fpwritetga,fpreadpnm,fpwritepnm,
     classes,
     FPImage, sysutils;

var img : TFPMemoryImage;
    reader : TFPCustomImageReader;
    Writer : TFPCustomimageWriter;
    ReadFile, WriteFile, WriteOptions : string;

procedure ReadImage(srf : string; rdr : TFPCustomImageReader; im : TFPMemoryImage );
procedure WriteImage(swf : string; wtr : TFPCustomimageWriter; wo : string; im : TFPMemoryImage);
procedure clean(rdr : TFPCustomImageReader; wtr : TFPCustomimageWriter; im : TFPMemoryImage);

implementation

procedure ReadImage(srf : string; rdr : TFPCustomImageReader; im : TFPMemoryImage);
{$ifndef UseFile}var str : TStream;{$endif}
begin
  Writeln('Passed ReadFile in Unit ' + srf);
  if assigned (reader) then
    //img.LoadFromFile (ReadFile, Reader)
    //img.LoadFromFile (srf, Reader)
    //img.LoadFromFile (srf, rdr)
    im.LoadFromFile (srf, rdr)
  else
 
    {$ifdef UseFile}
    //img.LoadFromFile (ReadFile);
    //img.LoadFromFile (srf);
    im.LoadFromFile (srf);
    {$else}
    //if fileexists (ReadFile) then
    if fileexists (srf) then
      begin
      //str := TFileStream.create (ReadFile,fmOpenRead);
      str := TFileStream.create (srf,fmOpenRead);
      try
        //img.loadFromStream (str);
        im.loadFromStream (str);
      finally
        str.Free;
      end;
      end
    else
      Writeln ('File ',srf,' doesn''t exists!');
    {$endif}
end;

procedure WriteImage(swf : string; wtr : TFPCustomimageWriter; wo : string; im : TFPMemoryImage);
var t : string;
begin
  
  //t := WriteOptions;
  t := wo;
  Writeln('Passed WriterFile in Unit ' + swf+ ' WriteOptions ' + wo);
  if (t[1] = 'P') then
    //with (Writer as TFPWriterPNG) do
    with (wtr as TFPWriterPNG) do
      begin
      Grayscale := pos ('G', t) > 0;
      Indexed := pos ('I', t) > 0;
      WordSized := pos('W', t) > 0;
      UseAlpha := pos ('A', t) > 0;
      Writeln ('Grayscale ',Grayscale, ' - Indexed ',Indexed,
               ' - WordSized ',WordSized,' - UseAlpha ',UseAlpha);
      end
  else if (t[1] = 'X') then
    begin
    if length(t) > 1 then
    //with (Writer as TFPWriterXPM) do
    with (wtr as TFPWriterXPM) do
      begin
      ColorCharSize := ord(t[2]) - ord('0');
      end;
    end;
  Writeln ('Options checked, now writing...');
  //img.SaveToFile (WriteFile, Writer);
  im.SaveToFile (swf, wtr);
end;

procedure clean(rdr : TFPCustomImageReader; wtr : TFPCustomimageWriter; im : TFPMemoryImage);
begin
  Writeln ('In Clean');
  rdr.Free;
  wtr.Free;
   
  im.Free;
end;

end. 
