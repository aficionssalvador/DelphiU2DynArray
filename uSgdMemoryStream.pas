unit uSgdMemoryStream;

interface

uses Classes;

type
  // Aquest objecte permet les carregas de Rtf a partir d'un string
  //   Recuperar el valor de un control TRichEdit reEditor en la variable sTexte
  //     SgdMs:=TSgdMemoryStream.Create; reEditor.Lines.SaveToStream(SgdMs);
  //     sTexte:=SgdMs.AnsiTexte; FreeAndNil(SgdMs);
  //   Assignar el valor de la variable sTexte en un control TRichEdit reEditor
  //     SgdMs:=TSgdMemoryStream.Create; SgdMs.AnsiTexte:=sTexte;
  //     reEditor.Lines.Clear; reEditor.Lines.LoadFromStream(SgdMs); FreeAndNil(SgdMs);
  // Aquest objecte permet el pas de parametres per post a les crides http
  //   Enviar sXmlEnt i recuperar resposta sXmlStr
  //     SgdMs:=TSgdMemoryStream.Create; SgdMs.AnsiTexte:=sXmlEnt;
  //     FreeAndNil(IdHTTP1); IdHTTP1:=TIdHTTP.Create(nil); IdHTTP1.HTTPOptions:=[];
  //     sXmlStr:=IdHTTP1.Post(URL,SgdMs); SgdMs.Free;
{$region 'interface class TSgdMemoryStream'}
  TSgdMemoryStream = class(TMemoryStream)
    protected
      function GetString : string;
      procedure SetString(s: string);
      function GetAnsiString : AnsiString;
      procedure SetAnsiString(s: AnsiString);
      procedure SetWideString(s: WideString);
      function GetWideString : WideString;
    public
      // Exposa el contingut del objecte com string
      property Texte : string read GetString write SetString;
      // Exposa el contingut del objecte com AnsiString
      property AnsiTexte : AnsiString read GetAnsiString write SetAnsiString;
      // Exposa el contingut del objecte com WideString
      property WideTexte : WideString read GetWideString write SetWideString;
  end;
{$endregion}

implementation

{$region 'class TSgdMemoryStream'}
function TSgdMemoryStream.GetString : string;
var i, p: Int64;
begin
  i:=self.Size;
  if i>0 then begin
    Result:=StringOfChar(#0,i div SizeOf(Char));
    p:=self.Position;
    self.Seek(0,soBeginning);
    self.Read(Result[1],i);
    self.Seek(p,soBeginning);
  end else Result:='';
end;

procedure TSgdMemoryStream.SetString(s: string);
begin
  self.Clear;
  //self.Write(s[1],length(s));
  self.WriteBuffer(s[1],length(s)*SizeOf(Char));
  self.Seek(0,soBeginning);
end;

function TSgdMemoryStream.GetAnsiString : AnsiString;
var i, p: Int64;
begin
  i:=self.Size;
  if i>0 then begin
    Result:=AnsiString(StringOfChar(#0,i));
    p:=self.Position;
    self.Seek(0,soBeginning);
    self.Read(Result[1],i);
    self.Seek(p,soBeginning);
  end else Result:='';
end;

procedure TSgdMemoryStream.SetAnsiString(s: AnsiString);
begin
  self.Clear;
  //self.Write(s[1],length(s));
  self.WriteBuffer(s[1],length(s));
  self.Seek(0,soBeginning);
end;

function TSgdMemoryStream.GetWideString : WideString;
var i, p: Int64;
begin
  i:=self.Size;
  if i>0 then begin
    Result:=StringOfChar(#0,i div SizeOf(WideChar));
    p:=self.Position;
    self.Seek(0,soBeginning);
    self.Read(Result[1],i);
    self.Seek(p,soBeginning);
  end else Result:='';
end;

procedure TSgdMemoryStream.SetWideString(s: WideString);
begin
  self.Clear;
  //self.Write(s[1],Length(s)*SizeOf(s[1]));
  self.WriteBuffer(s[1],Length(s)*SizeOf(s[1]));
  self.Seek(0,soBeginning);
end;
{$endregion}

end.
