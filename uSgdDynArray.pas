unit uSgdDynArray;

{.$DEFINE SRIGAU}

interface

uses SysUtils, Classes;

type

{$region 'interface class - Tu2ListStrings'}
  // String delimitat per un caracter separador
  Tu2ListStrings = class(TObject)
  private
    dades: TStringList;
    sep: Char;
  public
    constructor Create(Cadena: string; sepChar: Char); overload;
    constructor Create(sepChar: Char); overload;
    destructor Destroy; override;
    // Omple el objecte a partir d'un string delimitat
    procedure Split(str: string);
    // Serialitza el objecte en un string delimitat
    function Join(): string;
    // Serialitza el objecte en un string delimitat elimina les celdes buides
		function JoinIgnoreEmpty(): string;
    // Recupera un camp similar a la funcio FIELD() de UV
    function Field(posCamp: integer):string;
    // Assigna valor a un camp similar a la funcio FIELDSTORE() de UV
    procedure StoreField(posCamp: integer; valor:string);
    // Inserta un camp a una posicio similar a la funcio INSERT() de UV
    procedure InsertField(posCamp: integer; valor:string);
    // elimina un camp  similar a la funcio INSERT() de UV
    procedure DeleteField(posCamp: integer);
    // conta el numero de camps  similar a la funcio DCOUNT() de UV
    function DCount(): integer;
    // Localitza un camp amb el valor exacte  similar a la funcio LOCATE() de UV
    function Locate(cadena: string): integer;
    // Exposa con un TStringList
    property StringList : TStringList read dades write dades;
  end;
{$endregion}

{$region 'interface class - Tu2DynArray'}
  // Matriu dinamica tipus uniVerse
  Tu2DynArray = class(TObject)
	private
  	dataAM: Tu2ListStrings;
  	dataVM: Tu2ListStrings;
  	dataSVM: Tu2ListStrings;
    lastX, lastY: integer;
	  procedure getDataVM(X: integer);
    procedure getDataSVM(X, Y: integer);
		procedure setLastX(X: integer;valor: string);
    procedure setLastXY(X,Y: integer; valor: string);
		function _extract0():string;
		function _extract1(X: integer):string;
		function _extract2(X, Y: integer):string;
		function _extract3(X, Y, Z: integer):string;
    procedure _replace0(valor: string);
    procedure _replace1(X: integer; valor: string);
    procedure _replace2(X, Y: integer; valor: string);
    procedure _replace3(X, Y, Z: integer; valor: string);
	  procedure _insert1(X: integer; valor: string);
	  procedure _insert2(X, Y: integer; valor: string);
	  procedure _insert3(X, Y, Z: integer; valor: string);
    function getStringList: TStringList;
    procedure setStringList(valor :TStringList);
    procedure QuickSort_0(var iLo, iHi: Integer) ;
    procedure QuickSort_1(const y: Integer;var iLo, iHi: Integer) ;
	public
    constructor create; overload;
    constructor create(valor: string); overload;
    destructor Destroy; override;
    // Torna com string la coordinada de la matriu x,y,z o tota la matriu
		function _extract():string; overload;
		function _extract(X: integer):string; overload;
		function _extract(X, Y: integer):string; overload;
		function _extract(X, Y, Z: integer):string; overload;
    // Remplaça amb un string la coordinada de la matriu x,y,z o tota la matriu
    procedure _replace(valor: string); overload;
    procedure _replace(X: integer; valor: string); overload;
    procedure _replace(X, Y: integer; valor: string); overload;
    procedure _replace(X, Y, Z: integer; valor: string); overload;
    // inserta un string la coordinada de la matriu x,y,z
	  procedure _insert(X: integer; valor: string); overload;
	  procedure _insert(X, Y: integer; valor: string); overload;
	  procedure _insert(X, Y, Z: integer; valor: string); overload;
    // elimina la coordinada de la matriu x,y,z
	  procedure delete(X: integer) overload;
	  procedure delete(X, Y: integer) overload;
	  procedure delete(X, Y, Z: integer) overload;
    // busca una cadena exacte en la coordinada de la matriu x,y,z o a tota la matriu
	  function locate(cadena: string): integer; overload;
	  function locate(cadena: string; X: integer): integer; overload;
	  function locate(cadena: string; X, Y: integer): integer; overload;
	  function locate(cadena: string; X, Y, Z: integer): integer; overload;
    // conta el numero d'elements en la coordinada de la matriu x,y,z o a tota la matriu
    function DCount: integer; overload;
    function DCount(X: integer):integer; overload;
    function DCount(X, Y: integer):integer; overload;
    function DCount(X, Y, Z:integer):integer; overload;
    // guarda en un fitxer el TStrings
    procedure SaveToFile(nomFitxer:string);
    // recupera el TStrings d'un fitxer
    procedure LoadFromFile(nomFitxer:string);
    // ****************************************
    // ** Per compatibilitat amb SgdDynArray **
    // ****************************************
    // Trona com string la coordinada de la matriu x,y,z
    property Extract[x,y,z:integer]: string read _extract3 write _replace3;
    // Trona com string la matriu sencera
    property ExtractAll: string read _extract0 write _replace0;
    // Trona com string la coordinada de la matriu x atribut
    property ExtractField[x:integer]: string read _extract1 write _replace1;
    // Trona com string la coordinada de la matriu x,y valor
    property ExtractVal[x,y:integer]: string read _extract2 write _replace2;
    // Trona com string la coordinada de la matriu x,y,z subvalor
    property ExtractSubVal[x,y,z:integer]: string read _extract3 write _replace3;
    // Exposa el objecte con un Tu2ListStrings
    property u2ListStrings : Tu2ListStrings read dataAM write dataAM;
    // Remplaça amb un string la coordinada de la matriu x,y,z
    property Replace[x,y,z:integer]: string write _replace3;
    // Remplaça amb un string tota la matriu
    property ReplaceAll: string write _replace0;
    // Remplaça amb un string la coordinada de la matriu x atribut
    property ReplaceField[x:integer]: string write _replace1;
    // Remplaça amb un string la coordinada de la matriu x,y valor
    property ReplaceVal[x,y:integer]: string write _replace2;
    // Remplaça amb un string la coordinada de la matriu x,y,z subvalor
    property ReplaceSubVal[x,y,z:integer]: string write _replace3;
    // inserta un string la coordinada de la matriu x atribut
    property InsertAtt[x:integer]: string write _insert1;
    // inserta un string la coordinada de la matriu x,y valor
    property InsertVal[x,y:integer]: string write _insert2;
    // inserta un string la coordinada de la matriu x,y,z subvalor
    property InsertSub[x,y,z:integer]: string write _insert3;
    // Exposa el objecte con un TStringList
    property StringList : TStringList read getStringList write setStringList;
    // Ordena els atributs de la matriu
    procedure RAMSort(); overload;
    // Ordena els atributs de la matriu prenen con referencia un determinat valor
    procedure RAMSort(y:integer); overload;
  end;
{$endregion}

{$region 'interface function / procedure - Split , Join i Dcount'}
// ************************
// ** TString <-> string **
// ************************
// serialitza en un string delimitat per un separador un TStrings
function SgdJoin(const slDades: TStrings; const Separador: char): string; //overload;
// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
procedure SgdSplit(const sTexte: String; const sSeparador: Char; var stResultat: TStringList) ; overload;
// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
function SgdSplit(const sTexte, sSeparador: String) : TStringList ;  overload;
// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
function SgdSplit(const sTexte:string; sSeparador: Char) : TStringList ;  overload;
// Ompla un TStringList a partir de un string i un separador, algoritme millorat
function SgdSplit2(const MatDin: string; Separador: Char): TStringList;
// **********************************************
// ** contar camps delimitats per un separador **
// **********************************************
// emula la funcio DCOUNT() de uniVerse, versio obsoleta millor utilitzar SgdDCount2
function SgdDcount(const Cadena: string; const Delim: char): integer; overload;
// emula la funcio DCOUNT() de uniVerse, versio obsoleta millor utilitzar SgdDCount2
function SgdDcount(const Cadena: string; const Delim: string): integer; overload;
// emula la funcio DCOUNT() de uniVerse, algoritme millorat
function SgdDCount2(const MatDin: string; Separador: Char): Integer;
{$endregion}

{$region 'interface function / procedure'}
// ********************************************
// **** Tractament de matrius en funcions. ****
// ********************************************
// sempre que es pugui dona millor rendiment utilitzar l'objecte: Tu2DynArray
// Field UV, algoritme no obtimitzat.
function SgdField(const Cadena: string; const Delim: char; const Pos: Integer): string; overload;
function SgdField(const Cadena: string; const Delim: char; const Pos: Integer; const NumCamps: Integer): string; overload;
// FieldStore UV
function SgdFieldStore(const Cadena: string; const Delim: char; const Pos: Integer; const NuevaCadena: String): String;
// elimina un camp
function SgdFieldDelete(const Cadena: string; const Delim: char; const Pos: Integer): String;
// Inserta un camp
function SgdFieldInsert(const Cadena: string; const Delim: char; const Pos: Integer; const NuevaCadena: String): String; overload;
// busca un camp pel contingut
function SgdFieldLocate(const Cadena, CadenaBuscada: string; const Delim: char): Integer;
// Inset UV inserta "NuevaCadena" a la coordenada x,y,z de la matriu "Cadena"
function SgdInsert(const Cadena:string; const x,y,z:integer; const NuevaCadena: String): string; overload;
function SgdInsert(const Cadena:string; const x,y:integer; const NuevaCadena: String): string; overload;
function SgdInsert(const Cadena:string; const x:integer; const NuevaCadena: String): string; overload;
// Extract UV, millor utilitzar SgdMatDinTreu.
function SgdExtract(const Cadena:string;const x:integer): string; overload;
function SgdExtract(const Cadena:string;const x,y:integer): string; overload;
function SgdExtract(const Cadena:string;const x,y,z:integer): string; overload;
// Extract UV, algoritme millor
function SgdMatDinTreu(const MatDin: string; NumAtr: integer): string; overload;
function SgdMatDinTreu(const MatDin: string; NumAtr,NumVal: integer): string; overload;
function SgdMatDinTreu(const MatDin: string; NumAtr,NumVal,NumSub: integer): string; overload;
// Replace UV, substitueix "NuevaCadena" a la coordenada x,y,z de la matriu "Cadena"
function SgdReplace(const Cadena:string;const x,y,z:integer;const NuevaCadena: String): string; overload;
function SgdReplace(const Cadena:string;const x,y:integer;const NuevaCadena: String): string; overload;
function SgdReplace(const Cadena:string;const x:integer;const NuevaCadena: String): string; overload;
// Delete UV, elimina una coordenada x,y,z de la matriu "Cadena"
function SgdDelete(const Cadena:string;const x,y,z:integer): string; overload;
function SgdDelete(const Cadena:string;const x,y:integer): string; overload;
function SgdDelete(const Cadena:string;const x:integer): string; overload;
// Locate UV, busca CadenaBuscada dins la coordinada x,y,z de la matriu "Cadena"
function SgdLocate(const Cadena,CadenaBuscada:string;const x, y, z: integer):integer; overload;
function SgdLocate(const Cadena,CadenaBuscada:string;const x, y: integer):integer; overload;
function SgdLocate(const Cadena,CadenaBuscada:string;const x: integer):integer; overload;
function SgdLocate(const Cadena,CadenaBuscada:string):integer; overload;
// Remove UV  (iPosicio inicialment a 0), Recupera un element de la matriu de forma sequencial sigui quin sigui el delimitador
function SgdRemove(const MatDin: string; var iPosicio,iNivel :integer): string;
// Convert UV Remplaxa cada caracter de sCadenaDatos un a un de la carcteresBuscar per un a un de carcteresRemplazar
function SgdConvert(carcteresBuscar,carcteresRemplazar,sCadenaDatos: String): String;
// Lower UV, canvia les marques de la matriu. Baixa @am -> @vm, @vm -> @svm
function SgdLower(const Cadena:string): string;
// Raise UV, canvia les marques de la matriu. Puja @vm -> @am, @svm -> @vm
function SgdRaise(const Cadena:string): string;
// Trim "D" elimina els carecters al inici, al final i els redundants
function SgdTrimD(const Cadena:string; separador: Char): string;
// Substring idem que el operador [1,1] [1]
function SgdSubstring(const Cadena:string; posicioInicial, longitud: integer): string; overload;
function SgdSubstring(const Cadena:string; longitud: integer): string; overload;
{$endregion}

{$region 'interface const'}
const
  I_KRM:  char = char(255) ;
  I_KAM:  char = char(254);
  I_KVM:  char = char(253);
  I_KSVM: char = char(252);
  I_KTM:  char = char(251);

  I_CKRM  = #255;
  I_CKAM  = #254;
  I_CKVM  = #253;
  I_CKSVM = #252;
  I_CKTM  = #251;
{$endregion}

implementation

{$region 'class - Tu2ListStrings'}
constructor Tu2ListStrings.Create(Cadena: string; sepChar: Char);
begin
	inherited Create;
  self.sep:= sepChar;
	self.dades:=TStringList.Create;
  Split(cadena);
end;

constructor Tu2ListStrings.Create(sepChar: Char);
begin
	inherited Create;
  self.sep:= sepChar;
	self.dades:=TStringList.Create;
  Split('');
end;

destructor Tu2ListStrings.Destroy;
begin
  dades.Free;
  inherited;
end;

procedure Tu2ListStrings.Split(str: string);
var
  kPos, lm: integer;
  m,s: string;
  c: char;
begin
  s:='';
  m:=str; lm:=Length(m);
  kPos:=0;
  if Assigned(dades) then dades.Clear else dades:=TStringList.Create;
  if str='' then exit;
  try
    while kPos<lm do begin
      Inc(kPos);
      c:=m[kPos];
      if c=sep then begin
        dades.Add(s); s:='';
      end else s:=s+c;
    end;
    dades.Add(s); s:='';
  finally

  end;
end;

function Tu2ListStrings.Join(): string;
var i : integer; s: string;
begin
  result:=''; s:='';
  for i := 0 to dades.Count - 1 do begin
    result:= result + s + dades[i];
    s:=sep;
  end;
end;

function Tu2ListStrings.JoinIgnoreEmpty(): string;
var i : integer; s: string;
begin
  result:=''; s:='';
  for i := 0 to dades.Count - 1 do begin
    if dades[i]='' then continue;
    result:= result + s + dades[i];
    s:=sep;
  end;
end;

function Tu2ListStrings.Field(posCamp: integer):string;
begin
  if ((posCamp < 0) or (posCamp > dades.Count)) then begin
    Result:='';
  end else if (posCamp = 0) then begin
    Result:=Join();
  end else begin
    Result:=dades[posCamp - 1];
  end;
end;

procedure Tu2ListStrings.StoreField(posCamp: integer; valor:string);
var bCal: boolean; i: integer;
begin
  bCal:=False;
  if (posCamp < 0) then begin
    dades.Add(valor);
    bCal:=True;
  end else if (posCamp = 0) then begin
    Split(valor);
  end else if (posCamp <= dades.Count) then begin
    dades[posCamp - 1]:=valor;
    bCal:=True;
  end else begin
    for i := dades.Count to (posCamp - 1) do begin
      dades.Add('');
    end;
    dades[posCamp - 1]:=valor;
    bCal:=True;
  end;
  if ((bCal) and ((Pos(sep,valor)) > 0)) then begin
    Split(Join());
  end;
end;

procedure Tu2ListStrings.InsertField(posCamp: integer; valor:string);
var bCal: boolean;
begin
  bCal:=False;
  if (posCamp < 0) then begin
    dades.Add(valor);
    bCal:=True;
  end else if (posCamp = 0) then begin
    dades.Insert(0, valor);
    bCal:=True;
	end else if (posCamp <= dades.Count) then begin
    dades.Insert(posCamp - 1, valor);
    bCal:= true;
	end else begin
    StoreField(posCamp, valor);
  end;
  if ((bCal) and ((Pos(sep, valor)) > 0)) then begin
    Split(Join());
  end;
end;

procedure Tu2ListStrings.DeleteField(posCamp: integer);
begin
  if (posCamp < 0) then begin
    dades.Delete(dades.Count-1);
	end else if ((posCamp > 0)and(posCamp <= dades.Count)) then begin
    dades.Delete(posCamp-1);
  end;
end;

function Tu2ListStrings.DCount(): integer;
begin
  if (dades.Count = 0) then begin
    Result:=0;
  end else if ((dades.Count=1) and (dades[0]='')) then begin
    Result:=0;
  end else begin
    Result:=dades.Count;
  end;
end;

function Tu2ListStrings.Locate(cadena: string): integer;
begin
  Result:=dades.indexOf(cadena)+1;
end;
{$endregion}

{$region 'class - Tu2DynArray'}
procedure Tu2DynArray.getDataVM(X: integer);
begin
  if (lastX <> X) then begin
    dataVM.Split(dataAM.Field(X));
  end;
end;

procedure Tu2DynArray.getDataSVM(X, Y: integer);
var b: boolean;
begin
  b:=False;
  if (lastX <> X) then begin
    dataVM.Split(dataAM.Field(X));
    b:=True;
  end;
  if ((b) or (lastY <> Y)) then begin
    dataSVM.Split(dataVM.Field(Y));
  end;
end;

procedure Tu2DynArray.setLastX(X: integer;valor: string);
begin
  if (Pos(I_KAM,valor) <= 0) then begin
    lastX:= X;
  end else begin
    lastX:= -2;
  end;
  lastY:= -2;
end;

procedure Tu2DynArray.setLastXY(X,Y: integer; valor: string);
var b: boolean;
begin
  b:=(Pos(I_KAM,valor) <= 0);
  if (b) then begin
    lastX:=X;
    if ((b) and (Pos(I_KVM,valor) <= 0)) then begin
      lastY:= Y;
    end else begin
      lastY:= -2;
    end;
  end else begin
    lastX:= -2;
    lastY:= -2;
  end;
end;

constructor Tu2DynArray.create;
begin
  Inherited;
	dataAM:=Tu2ListStrings.Create(I_KAM);
	dataVM:=Tu2ListStrings.Create(I_KVM);
	dataSVM:=Tu2ListStrings.Create(I_KSVM);
	lastX:= -2;
	lastY:= -2;
  self._replace('');
end;

constructor Tu2DynArray.create(valor: string);
begin
  self.create;
  self._replace(valor);
end;

destructor Tu2DynArray.Destroy;
begin
  dataAM.Free;
  dataVM.Free;
  dataSVM.Free;
  Inherited;
end;

function Tu2DynArray._extract():string;
begin
  Result:=dataAM.Field(0);
end;

function Tu2DynArray._extract(X: integer):string;
begin
  Result:=dataAM.Field(X);
end;

function Tu2DynArray._extract(X, Y: integer):string;
begin
  getDataVM(X);
  if (lastX <> X) then begin
    lastX:= X; lastY:= -2;
  end;
  Result:=dataVM.Field(Y);
end;

function Tu2DynArray._extract(X, Y, Z: integer):string;
begin
  getDataSVM(X, Y);
  lastX:= X;
  lastY:= Y;
  Result:=dataSVM.Field(Z);
end;

function Tu2DynArray.DCount :integer;
begin
  Result:=dataAM.DCount;
end;

function Tu2DynArray.DCount(x:integer):integer;
begin
  getDataVM(X);
  if (lastX <> X) then begin
    lastX:= X; lastY:= -2;
  end;
  Result:=dataVM.DCount;
end;

function Tu2DynArray.DCount(x,y:integer):integer;
begin
  getDataSVM(X, Y);
  lastX:= X;
  lastY:= Y;
  Result:=dataSVM.DCount;
end;

function Tu2DynArray.DCount(X, Y, Z:integer):integer;
var ls: Tu2ListStrings;
begin
  ls:=Tu2ListStrings.Create(_extract(X ,Y ,Z), I_KTM);
  Result:=ls.DCount;
  ls.Free;
end;

procedure Tu2DynArray._replace(valor: string);
begin
  dataAM.StoreField(0, valor);
  lastX:= -2;
  lastY:= -2;
end;

procedure Tu2DynArray._replace(X: integer; valor: string);
begin
  dataAM.StoreField(X, valor);
  lastX:= -2;
  lastY:= -2;
end;

procedure Tu2DynArray._replace(X, Y: integer; valor: string);
begin
  getDataVM(X);
  dataVM.StoreField(Y, valor);
  dataAM.StoreField(X, dataVM.Field(0));
  setLastX(X, valor);
end;

procedure Tu2DynArray._replace(X, Y, Z: integer; valor: string);
begin
  getDataSVM(X, Y);
  dataSVM.StoreField(Z, valor);
  dataVM.StoreField(Y, dataSVM.Field(0));
  dataAM.StoreField(X, dataVM.Field(0));
  setLastXY(X, Y, valor);
end;

procedure Tu2DynArray._insert(X: integer; valor: string);
begin
  dataAM.InsertField(X, valor);
  lastX:= -2;
  lastY:= -2;
end;

procedure Tu2DynArray._insert(X, Y: integer; valor: string);
begin
  getDataVM(X);
  dataVM.InsertField(Y, valor);
  dataAM.StoreField(X, dataVM.Field(0));
  setLastX(X, valor);
end;

procedure Tu2DynArray._insert(X, Y, Z: integer; valor: string);
begin
  getDataSVM(X, Y);
  dataSVM.InsertField(Z, valor);
  dataVM.StoreField(Y, dataSVM.Field(0));
  dataAM.StoreField(X, dataVM.Field(0));
  setLastXY(X, Y, valor);
end;

procedure Tu2DynArray.delete(X: integer);
begin
  dataAM.DeleteField(X);
  lastX:= -2;
  lastY:= -2;
end;

procedure Tu2DynArray.delete(X, Y: integer);
begin
  getDataVM(X);
  dataVM.DeleteField(Y);
  dataAM.StoreField(X, dataVM.Field(0));
  lastX:= X;
  lastY:= -2;
end;

procedure Tu2DynArray.delete(X, Y, Z: integer);
begin
  getDataSVM(X, Y);
  dataSVM.DeleteField(Z);
  dataVM.StoreField(Y, dataSVM.Field(0));
  dataAM.StoreField(X, dataVM.Field(0));
  lastX:= X;
  lastY:= Y;
end;

function Tu2DynArray.locate(cadena: string): integer;
begin
	Result:=dataAM.Locate(cadena);
end;

function Tu2DynArray.locate(cadena: string; X: integer): integer;
begin
  getDataVM(X);
  lastX:= X;
  lastY:= -2;
  Result:=dataVM.Locate(cadena);
end;

function Tu2DynArray.locate(cadena: string; X, Y: integer): integer;
begin
  getDataSVM(X, Y);
  lastX:= X;
  lastY:= Y;
  Result:=dataSVM.Locate(cadena);
end;

function Tu2DynArray.locate(cadena: string; X, Y, Z: integer): integer;
var ls: Tu2ListStrings;
begin
  ls:=Tu2ListStrings.Create(_extract(X ,Y ,Z), I_KTM);
  Result:=ls.Locate(cadena);
  ls.Free;
end;

procedure Tu2DynArray.SaveToFile(nomFitxer:string);
begin
  dataAM.StringList.SaveToFile(nomFitxer);
end;

procedure Tu2DynArray.LoadFromFile(nomFitxer:string);
begin
  dataAM.StringList.LoadFromFile(nomFitxer);
end;

function Tu2DynArray._extract0():string;
begin Result:=_extract; end;

function Tu2DynArray._extract1(X: integer):string;
begin Result:=_extract(X); end;

function Tu2DynArray._extract2(X, Y: integer):string;
begin Result:=_extract(X, Y); end;

function Tu2DynArray._extract3(X, Y, Z: integer):string;
begin Result:=_extract(X, Y, Z); end;

procedure Tu2DynArray._replace0(valor: string);
begin _replace(valor); end;

procedure Tu2DynArray._replace1(X: integer; valor: string);
begin _replace(X, valor); end;

procedure Tu2DynArray._replace2(X, Y: integer; valor: string);
begin _replace(X, Y, valor); end;

procedure Tu2DynArray._replace3(X, Y, Z: integer; valor: string);
begin _replace(X, Y, Z, valor); end;

procedure Tu2DynArray._insert1(X: integer; valor: string);
begin _insert(X, valor); end;

procedure Tu2DynArray._insert2(X, Y: integer; valor: string);
begin _insert(X, Y, valor); end;

procedure Tu2DynArray._insert3(X, Y, Z: integer; valor: string);
begin _insert(X, Y, Z, valor); end;

function Tu2DynArray.getStringList: TStringList;
begin Result:=dataAM.StringList; end;

procedure Tu2DynArray.setStringList(valor :TStringList);
begin dataAM.StringList:=valor; end;

procedure Tu2DynArray.RAMSort();
var lo,hi:integer;
begin
  lo:=1;
  hi:=self.DCount();
  QuickSort_0(lo, hi);
end;

procedure Tu2DynArray.RAMSort(y:integer);
var lo,hi:integer;
begin
  lo:=1;
  hi:=self.DCount();
  QuickSort_1(y,lo,hi);
end;

// ordena els atributs
procedure Tu2DynArray.QuickSort_0(var iLo, iHi: Integer) ;
var
  Lo, Hi : Integer; Pivot, T : string ;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := _extract(((Lo + Hi) div 2));
  repeat
    while _extract(Lo) < Pivot do Inc(Lo) ;
    while _extract(Hi) > Pivot do Dec(Hi) ;
//    if Lo <= Hi then
    if Lo < Hi then begin
      T := _extract(Lo);
      _replace(Lo,_extract(Hi));
      _replace(Hi,T);
      Inc(Lo) ;
      Dec(Hi) ;
    end else if Lo = Hi then begin
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort_0( iLo, Hi) ;
  if Lo < iHi then QuickSort_0( Lo, iHi) ;
end;

// ordena els atributs per un valor
procedure Tu2DynArray.QuickSort_1(const y: Integer;var iLo, iHi: Integer) ;
var
  Lo, Hi : Integer; Pivot, T : string ;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := _extract(((Lo + Hi) div 2),y);
  repeat
    while _extract(Lo,y) < Pivot do Inc(Lo) ;
    while _extract(Hi,y) > Pivot do Dec(Hi) ;
//    if Lo <= Hi then begin
    if Lo < Hi then begin
      T := _extract(Lo);
      _replace(Lo,_extract(Hi));
      _replace(Hi,T);
      Inc(Lo) ;
      Dec(Hi) ;
    end else if Lo = Hi then begin
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort_1(y, iLo, Hi) ;
  if Lo < iHi then QuickSort_1(y, Lo, iHi) ;
end;
{$endregion}

{$region 'function / procedure - Split , Join i Dcount'}
// serialitza en un string delimitat per un separador un TStrings
function SgdJoin(const slDades: TStrings; const Separador: char): string;
var i : integer; sep: string;
begin
  //MyStringList.Delimiter := Separador;
  //Join:=MyStringList.DelimitedText;
  result:=''; sep:='';
  for i := 0 to slDades.Count - 1 do begin
    result:= result + sep + slDades[i];
    sep:=Separador;
  end;
end;

// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
procedure SgdSplit(const sTexte: String; const sSeparador: Char; Var stResultat: TStringList) overload;
begin
  if (stResultat = nil ) then stResultat := TStringList.create ;
  stResultat:=SgdSplit(sTexte,sSeparador);
end;

// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
function SgdSplit(const sTexte, sSeparador: String) : TStringList ;  overload;
var sCadena, sSubCadena: string; iPos,iPosSep: Integer;
begin
  SgdSplit := TStringList.create ;
  // Iniciar variables.
  sCadena:=sTexte; sSubCadena:='';
  // Tractament cadena.
  iPosSep:=0;
  repeat
    iPos:=Pos(sSeparador,sCadena)-1;
    if iPos<0 then begin iPos:=Length(sCadena); iPosSep:=1; end;
    sSubCadena:=Copy(sCadena,1,iPos);
    SgdSplit.Add(sSubCadena);
    Delete(sCadena,1,iPos+Length(sSeparador));
  until iPosSep=1;
end;

// Ompla un TStringList a partir de un string i un separador, versio obsoleta mmillor utilitzar SgdSplit2
function SgdSplit(const sTexte : string; sSeparador: char) : TStringList ;  overload;
begin
  Result:=SgdSplit(sTexte,StringOfChar(sSeparador,1));
end;

// Ompla un TStringList a partir de un string i un separador, algoritme millorat
function SgdSplit2(const MatDin: string; Separador: Char): TStringList;
var
  kPos, lm: integer;
  m,s: string;
  c: char;
begin
  s:='';
  m:=MatDin; lm:=Length(m);
  kPos:=0;
  Result:=TStringList.Create;
  if MatDin='' then exit;
  try
    while kPos<lm do begin
      Inc(kPos);
      c:=m[kPos];
      if c =Separador then begin
        Result.Add(s); s:='';
      end else s:=s+c;
    end;
    Result.Add(s); s:='';
  finally

  end;
end;

// emula la funcio DCOUNT() de uniVerse, versio obsoleta millor utilitzar SgdDCount2
function SgdDcount(const Cadena: string; const Delim: char): integer; overload;
var
sl : TStringList;
begin
  sl:=SgdSplit(cadena,Delim);
  result:=sl.Count;
  sl.Free;
end;

// emula la funcio DCOUNT() de uniVerse, versio obsoleta millor utilitzar SgdDCount2
function SgdDcount(const Cadena: string; const Delim: string): integer; overload;
begin
  result:= Sgddcount(cadena,delim[1]);
end;

// emula la funcio DCOUNT() de uniVerse, algoritme millorat
function SgdDCount2(const MatDin: string; Separador: Char): Integer;
var
  iAtr, kPos, lm: integer;
  m,s: string;
  c: char;
begin
  s:='';
  iAtr:=1;
  m:=MatDin; lm:=Length(m);
  kPos:=0;
  Result:=0;
  if m='' then exit;
  while kPos<lm do begin
    Inc(kPos);
    c:=m[kPos];
    if c=Separador then Inc(iAtr);
  end;
  Result:=iAtr;
end;
{$endregion}

{$region 'function / procedure'}
function SgdField(const Cadena: string; const Delim: char; const Pos: Integer): string; overload;
var
  sl: TStringList;
  s: string;
  p: Integer;
begin
  s:='';
  if pos = 0 then begin
    s:=Cadena;
  end else if pos < 0 then begin
    s:='';
  end else begin
    sl:=SgdSplit(Cadena, Delim);
    p := sl.Count;
    if Pos>p then begin
      s:='';
    end else begin
      s:=sl[pos-1];
    end;
    sl.Free;
  end;
  result := s;
end;

function SgdField(const Cadena: string; const Delim: char; const Pos: Integer; const NumCamps: Integer): string; overload;
var
  sl: TStringList;
  s: string;
  p , i, maxi: Integer;
  nc, pp : Integer;
  sep: string ;
begin
  s:='';
  if pos = 0 then begin
    s:=Cadena;
  end else if pos < 0 then begin
    s:='';
  end else begin
    sl:=SgdSplit(Cadena, Delim );
    p := sl.Count-1;
    nc := Pos -1 + NumCamps -1;
    pp := Pos -1;
    if pp>p then begin
      s:='';
    end else begin
      sep :='';
      maxi := nc; if p<nc then maxi:=p; // maxi:=Minim(nc,p)
      for i := pp to maxi do begin
        s:=s + sep + sl[i];
        sep:= delim;
      end;
    end;
    sl.Free;
  end;
  result := s;
end;

function SgdFieldStore(const Cadena: string; const Delim: char; const Pos: Integer; const NuevaCadena: String): String;
var
{$IFDEF SRIGAU}
  ls: Tu2ListStrings;
{$ELSE}
p,i : Integer;
//s: string;
sl: TStringList;
{$ENDIF}
begin
  Result:='';
{$IFDEF SRIGAU}
  ls:=Tu2ListStrings.Create(Cadena,Delim);
  ls.StoreField(Pos,NuevaCadena);
  Result:=ls.Join;
  ls.Free;
{$ELSE}
  if pos = 0 then begin
    Result:=Cadena; Exit;
  end else if pos < 0 then begin
    if Cadena='' then begin Result:=NuevaCadena;Exit;
    end else begin Result:=Cadena + Delim + NuevaCadena; Exit; end;
  end else begin
    sl:=SgdSplit(Cadena, Delim);
    p := sl.Count;
    if Pos>p then begin
      for I := p to pos - 1 do begin
        sl.add('');
      end;
    end;
    sl[pos-1]:=NuevaCadena;
    Result:=SgdJoin(sl,Delim );
    sl.Free;
  end;
{$ENDIF}
end;

function SgdFieldInsert(const Cadena: string; const Delim: char; const Pos: Integer; const NuevaCadena: String): String;
var
{$IFDEF SRIGAU}
  ls: Tu2ListStrings;
{$ELSE}
p,i : Integer;
//s: string;
sl: TStringList;
{$ENDIF}
begin
  Result:='';
{$IFDEF SRIGAU}
  ls:=Tu2ListStrings.Create(Cadena,Delim);
  ls.InsertField(Pos,NuevaCadena);
  Result:=ls.Join;
  ls.Free;
{$ELSE}
  if pos = 0 then begin
    Result:=Cadena; Exit;
  end else if pos < 0 then begin
    if Cadena='' then begin Result:=NuevaCadena;Exit;
    end else begin Result:=Cadena + Delim + NuevaCadena; Exit; end;
//    Result:=Cadena + Delim + NuevaCadena;  Exit;
  end else begin
    sl:=SgdSplit(Cadena, Delim);
    p := sl.Count;
    if Pos>p then begin
      for I := p to pos - 1 do begin
        sl.add('');
      end;
      sl[pos-1]:=NuevaCadena;
    end else begin
      sl.Insert(pos-1,NuevaCadena);
    end;
    Result:=SgdJoin(sl,Delim );
    sl.Free;
  end;
{$ENDIF}
end;

function SgdFieldDelete(const Cadena: string; const Delim: char; const Pos: Integer): String;
var
{$IFDEF SRIGAU}
  ls: Tu2ListStrings;
{$ELSE}
p: Integer;
//s: string;
sl: TStringList;
{$ENDIF}
begin
  Result:='';
{$IFDEF SRIGAU}
  ls:=Tu2ListStrings.Create(Cadena,Delim);
  ls.DeleteField(Pos);
  Result:=ls.Join;
  ls.Free;
{$ELSE}
  if pos = 0 then begin
    Result:=Cadena;  Exit;
  end else if pos < 0 then begin
    Result:=Cadena; Exit;
  end else begin
    sl:=SgdSplit(Cadena, Delim);
    p := sl.Count;
    if Pos<=p then begin
      sl.delete(pos-1);
    end;
    Result:=SgdJoin(sl,Delim );
    sl.Free;
  end;
{$ENDIF}
end;

function SgdFieldLocate(const Cadena, CadenaBuscada: string; const Delim: char): Integer;
var
{$IFDEF SRIGAU}
  ls: Tu2ListStrings;
{$ELSE}
sl: TStringList;
{$ENDIF}
begin
{$IFDEF SRIGAU}
  ls:=Tu2ListStrings.Create(Cadena,Delim);
  Result:=ls.Locate(CadenaBuscada);
  ls.Free;
{$ELSE}
  sl:=SgdSplit(Cadena, Delim);
  result:=sl.IndexOf(CadenaBuscada)+1;
  sl.Free;
{$ENDIF}
end;

function SgdLocate(const Cadena,CadenaBuscada:string;const x,y,z :integer):integer; overload;
begin
  result:=SgdFieldLocate(SgdExtract(Cadena,x,y,z),CadenaBuscada,I_KTM)
end;

function SgdLocate(const Cadena,CadenaBuscada:string; const x, y :integer):integer; overload;
begin
  result:=SgdFieldLocate(SgdExtract(Cadena,x,y),CadenaBuscada,I_KSVM)
end;

function SgdLocate(const Cadena,CadenaBuscada:string; const x :integer):integer; overload;
begin
  result:=SgdFieldLocate(SgdExtract(Cadena,x),CadenaBuscada,I_KVM)
end;

function SgdLocate(const Cadena, CadenaBuscada:string):integer; overload;
begin
  result:=SgdFieldLocate(Cadena,CadenaBuscada,I_KAM)
end;

function SgdDelete(const Cadena:string;const x,y,z:integer): string; overload;
begin
  result:= SgdFieldStore( cadena, I_KAM,x,SgdFieldStore(SgdExtract(cadena,x),I_KVM,y,SgdFieldDelete( SgdExtract(cadena,x,y),I_KSVM,z )));
end;

function SgdDelete(const Cadena:string;const x,y:integer): string; overload;
begin
  result:= SgdFieldStore( cadena, I_KAM,x,SgdFieldDelete(SgdExtract(cadena,x),I_KVM,y ));
end;

function SgdDelete(const Cadena:string;const x:integer): string; overload;
begin
  result:= SgdFieldDelete(cadena,I_KAM,x);
end;

function SgdInsert(const Cadena:string; const x,y,z:integer;const NuevaCadena: String): string; overload;
begin
  result:= SgdFieldStore( cadena, I_KAM,x,SgdFieldStore(SgdExtract(cadena,x),I_KVM,y,SgdFieldInsert( SgdExtract(cadena,x,y),I_KSVM,z,NuevaCadena )));
end;

function SgdInsert(const Cadena:string; const x,y:integer; const NuevaCadena: String): string; overload;
begin
  result:= SgdFieldStore( cadena, I_KAM,x,SgdFieldInsert(SgdExtract(cadena,x),I_KVM,y,NuevaCadena ));
end;

function SgdInsert(const Cadena:string;const x:integer;const NuevaCadena: String): string; overload;
begin
  result:= SgdFieldInsert(cadena,I_KAM,x,NuevaCadena);
end;

function SgdExtract(const Cadena:string;const x:integer): string; overload;
begin
  Result := SgdField(cadena,I_KAM,x);
end;

function SgdExtract(const Cadena:string;const x,y:integer): string; overload;
begin
  Result := SgdField(SgdField(cadena,I_KAM,x),I_KVM,y);
end;

function SgdExtract(const Cadena:string;const x,y,z:integer): string; overload;
begin
  Result := SgdField(SgdField(SgdField(cadena,I_KAM,x),I_KVM,y),I_KSVM,z);
end;

function SgdReplace(const Cadena:string;const x,y,z:integer;const NuevaCadena: String): string; overload;
begin
  Result :=SgdFieldStore(cadena,I_KAM,x,SgdFieldStore(SgdExtract(cadena, x),I_KVM,y,SgdFieldStore(SgdExtract(cadena,x,y),I_KSVM,z,NuevaCadena)));
end;

function SgdReplace(const Cadena:string;const x,y:integer;const NuevaCadena: String): string; overload;
begin
  Result :=SgdFieldStore(cadena,I_KAM,x,SgdFieldStore(SgdExtract(cadena,x),I_KVM,y,NuevaCadena));
end;

function SgdReplace(const Cadena:string;const x:integer;const NuevaCadena: String): string; overload;
begin
  Result :=SgdFieldStore(cadena,I_KAM,x,NuevaCadena);
end;

function SgdRemove(const MatDin: string; var iPosicio,iNivel :integer): string;
var
  lm: integer;
  m,s: string;
  c: char;
  bAquest: boolean;
begin
  s:='';
  m:=MatDin; lm:=Length(m);
  if iPosicio<0 then iPosicio:=0;
  iNivel:=0;
  bAquest:=true;
  while (iPosicio<lm)and(bAquest) do begin
    Inc(iPosicio);
    c:=m[iPosicio];
    case c of
      I_CKRM: begin
        iNivel:=1; bAquest:=false;
      end;
      I_CKAM: begin
        iNivel:=2; bAquest:=false;
      end;
      I_CKVM: begin
        iNivel:=3; bAquest:=false;
      end;
      I_CKSVM: begin
        iNivel:=4; bAquest:=false;
      end;
      I_CKTM: begin
        iNivel:=5; bAquest:=false;
      end;
      else if bAquest then s:=s+c;
    end;
  end;
  Result:=s;
end;

function SgdMatDinTreu(const MatDin: string; NumAtr: integer): string;
var
  iAtr, kPos, lm: integer;
  m,s: string;
  c: char;
  Aquest: boolean;
begin
  s:='';
  iAtr:=1;
  m:=MatDin; lm:=Length(m);
  Aquest:=(iAtr=NumAtr);
  kPos:=0;
  while kPos<lm do begin
    Inc(kPos);
    c:=m[kPos];
    case c of
      I_CKAM: begin
        Inc(iAtr);
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr);
      end;
      else if Aquest then s:=s+c;
    end;
  end;
  Result:=s;
end;

function SgdMatDinTreu(const MatDin: string; NumAtr,NumVal: integer): string;
var
  iAtr, iVal, kPos, lm: integer;
  m,s: string;
  c: char;
  Aquest: boolean;
begin
  s:='';
  iAtr:=1; iVal:=1;
  m:=MatDin; lm:=Length(m);
  Aquest:=(iAtr=NumAtr)and(iVal=NumVal);
  kPos:=0;
  while kPos<lm do begin
    Inc(kPos);
    c:=m[kPos];
    case c of
      I_CKAM: begin
        Inc(iAtr); iVal:=1;
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr)and(iVal=NumVal);
      end;
      I_CKVM: begin
        Inc(iVal);
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr)and(iVal=NumVal);
      end;
      else if Aquest then s:=s+c;
    end;
  end;
  Result:=s;
end;

function SgdMatDinTreu(const MatDin: string; NumAtr,NumVal,NumSub: integer): string;
var
  iAtr, iVal, iSub, kPos, lm: integer;
  m,s: string;
  c: char;
  Aquest: boolean;
begin
  s:='';
  iAtr:=1; iVal:=1; iSub:=1;
  m:=MatDin; lm:=Length(m);
  Aquest:=(iAtr=NumAtr)and(iVal=NumVal)and(iSub=NumSub);
  kPos:=0;
  while kPos<lm do begin
    Inc(kPos);
    c:=m[kPos];
    case c of
      I_CKAM: begin
        Inc(iAtr); iVal:=1; iSub:=1;
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr)and(iVal=NumVal)and(iSub=NumSub);
      end;
      I_CKVM: begin
        Inc(iVal); iSub:=1;
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr)and(iVal=NumVal)and(iSub=NumSub);
      end;
      I_CKSVM: begin
        Inc(iSub);
        if Aquest then Break;
        Aquest:=(iAtr=NumAtr)and(iVal=NumVal)and(iSub=NumSub);
      end;
      else if Aquest then s:=s+c;
    end;
  end;
  Result:=s;
end;

function SgdConvert(carcteresBuscar,carcteresRemplazar,sCadenaDatos: String): String;
Var
  i : Integer;
  j : Integer;
  maxi : integer;
  maxj : integer;
Begin
  Result := sCadenaDatos;
  maxi :=Length(sCadenaDatos);
  maxj :=Length(carcteresBuscar);
  if length(carcteresRemplazar)<length(carcteresBuscar) then
    maxj :=Length(carcteresRemplazar);
  For i := 1 to maxi Do Begin
    j := Pos(sCadenaDatos[i],carcteresBuscar);
    if ((j>0) and (j<=maxj)) then begin
      Result[i]:= carcteresRemplazar[j] ;
    end;
  End;
End;

function SgdLower(const Cadena:string): string;
begin
  result:=SgdConvert(I_KRM+I_KAM+I_KVM+I_KSVM, I_KAM+I_KVM+I_KSVM+I_KTM, Cadena);
end;

function SgdRaise(const Cadena:string): string;
begin
  result:=SgdConvert(I_KAM+I_KVM+I_KSVM+I_KTM, I_KRM+I_KAM+I_KVM+I_KSVM, Cadena);
end;

function SgdTrimD(const Cadena:string; separador: Char): string;
var ls: Tu2ListStrings;
begin
  ls:=Tu2ListStrings.Create(Cadena,separador);
  Result:=ls.JoinIgnoreEmpty;
  ls.Free;
end;

function SgdSubstring(const Cadena:string; posicioInicial, longitud: integer): string; overload;
var Size, From, lCadena: integer;
begin
  Size:=longitud; lCadena:=Length(Cadena); From:=posicioInicial;
  Result:='';
  if From>lCadena then Exit;
  if (From+Size-1)>lCadena then Size:=lCadena-From+1;
  Result := Copy(Cadena, From, Size)
end;

function SgdSubstring(const Cadena:string; longitud: integer): string; overload;
var Size, lCadena: integer;
begin
  Size:=longitud; lCadena:=Length(Cadena);
  if Size > lCadena then Size := LCadena ;
  Result:=Copy(Cadena, LCadena - Size + 1, Size);
end;
{$endregion}

end.
