{$mode objfpc}{$h+}
program initImgConv;

{_$define UseFile}

uses FPWriteXPM, FPWritePNG, FPWriteBMP,
     FPReadXPM, FPReadPNG, FPReadBMP, fpreadjpeg,fpwritejpeg,
     fpreadtga,fpwritetga,fpreadpnm,fpwritepnm,
     {$ifndef UseFile}classes,{$endif}
     FPImage, uImgConv, sysutils;

var img : TFPMemoryImage;
    reader : TFPCustomImageReader;
    Writer : TFPCustomimageWriter;
    ReadFile, WriteFile, WriteOptions : string;
    


 begin

     
 
  Writer := TFPWriterBMP.Create;
  Reader := TFPReaderPNG.Create;
  WriteOptions := 'B';
  ReadFile := 'lena_rgb_2048.png';
  WriteFile := 'MyBitmap.bmp';
  img := TFPMemoryImage.Create(0,0);
  img.UsePalette:=false;
     try
      writeln ('Initing');
      //Init;
      writeln ('In initInitConv Reading image '+ ReadFile );
      ReadImage(ReadFile,Reader,img); 
      writeln ('In initInitConv Writing image ');
      WriteImage(WriteFile,Writer,WriteOptions,img);
      writeln ('Clean up');
      Clean(Reader,Writer,img);
    except
      on e : exception do
        writeln ('Error: ',e.message);
    end;
end.
