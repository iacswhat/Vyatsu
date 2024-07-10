unit UBD;

interface
uses Classes, Contnrs;

type
  TEvidence = class (TObject) // свидетельство
  private
    FName   : String;
    FPPolus : String;
    FNPolus : String;
  public
    property Name   : String read FName;
    property PPolus : String read FPPolus;
    property NPolus : String read FNPolus;

    constructor Create(Nm,PP,NP: String);
    function Str: String;
  end;

  TEvdRef = class (TObject) // ссылки на свидетельства для гипотез
  private
    Mark : Integer; // оценка
  public
    constructor Create(AMark: Integer);
  end;

  THypothesis = class (TObject) // гипотеза
  private
    FName  : String;
  public
    EvdRef : TObjectList;
    property Name : String read FName;

    constructor Create(Nm: String);
    destructor  Destroy(); override;
  end;

  TMList = class (TObject) // прототип листа
  protected
    List: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Delete(Ind: Integer); 
    function Count: Integer;
  end;

  TEvdList = class (TMList)
  private
    function GetItems(Ind: Integer): TEvidence;
  public
    procedure Add(Evd: TEvidence); overload;
    procedure Add(Str: String);    overload;
    procedure Edit(Ind: Integer; Evd: TEvidence);
    procedure Names(Sts: TStrings);
    procedure Delete(Ind: Integer); 

    property Items[Ind: Integer]: TEvidence read GetItems; default;
  end;

  THypList = class (TMList)
  private
    function GetItems(Ind: Integer): THypothesis;
  public
    procedure Add(Hyp: THypothesis); overload;
    procedure Add(Str: String);      overload;
    procedure Edit(Ind: Integer; Hyp: THypothesis);
    procedure Names(Sts: TStrings);

    property Items[Ind: Integer]: THypothesis read GetItems; default;
  end;

  TBD = class (TObject)
  private
    function GetMark(IHyp, IEvd: Integer): Integer;
    procedure SetMark(IHyp, IEvd: Integer; const Value: Integer);

    function SearchSect(const str: String): Integer;
    procedure AddMarkStr(var IHyp: Integer; Str: String);
  public
    Evd   : TEvdList;    // список свидетельств
    Hyp   : THypList;    // список гипотез
    Scale : Integer;     // шкала 5, 20, 50

    constructor Create;
    destructor Destroy; override;

    procedure AddHyp(SHyp: String);
    procedure DelHyp(Ind: Integer);
    procedure EditHyp(Old: Integer; NHyp: String);

    procedure AddEv(SEv,PP,NP: String);
    procedure DelEv(Ind: Integer);
    procedure EditEv(Old: Integer; SEv,PP,NP: String);

    procedure VisualRepGrid;
    property Mark[IHyp, IEvd: Integer]: Integer read GetMark write SetMark;

    procedure SetScale(Sc: Integer);

    procedure Save(Name: String);
    procedure Open(Name: String);
//    procedure New;
    procedure Clear;

    function TestRepGrid(var Str: String): Boolean;
  end;

  function stspaces(Str: String; MinL: Integer): String;

const
  bdSectCount = 6;
  bdSect : array [0..bdSectCount - 1] of String =
    ('ШКАЛА:','ГИПОТЕЗЫ:','СВИДЕТЕЛЬСТВА:','РЕПЕРТУАРНАЯ РЕШЕТКА:','КЛАСТ. СВИДЕТЕЛЬСТВА:',
     'КЛАСТ. ГИПОТЕЗЫ:');
  nsNone = -1;
  nsScal = 0;
  nsHyp  = 1;
  nsEvid = 2;
  nsGrid = 3;
  nsCEvd = 4;
  nsCHyp = 5;

var
  BD : TBD;

implementation
uses FUEditHyp, SysUtils, FUEditEv, FUEditRep, Grids, FUEditMark, Math,FUExpEv, UBZ,
     FUSett;

function stspaces(Str: String; MinL: Integer): String;
begin
  if Length(Str) > MinL then Str := Copy(Str,1,MinL);
  repeat
    Str := ' ' + Str;
  until Length(Str) > MinL;
  Result := Str;
end;

procedure Words(Str: String; Words: TStrings); // разбивает строку на слова
const
  DelCh = ' ,'#9;
var
  i    : Integer;
  Word : String;
begin
  Word := '';
  Words.Clear;
  for i := 1 to Length(Str) do
    if not IsDelimiter(DelCh,Str,i) then
      Word := Word + Str[i]
    else
      if Word <> '' then begin
        Words.Add(Word);
        Word := '';
      end;
  if Word <> '' then
    Words.Add(Word);
end;

procedure DelSep(var Str: String; Sep: String); // убирает заданные символы из строки
var p : Integer;
begin
  p := LastDelimiter(Sep,Str);
  while p > 0 do begin
    Delete(Str,p,1);
    p := LastDelimiter(Sep,Str);
  end;
end;

{ TBD }

procedure TBD.AddEv(SEv, PP, NP: String);
begin
  Evd.Add(TEvidence.Create(SEv,PP,NP));
  FEditEv.ListBox1.Items.Add(SEv);
  FExpEv.ListBox1.Items.Add(SEv);
end;

procedure TBD.AddHyp(SHyp: String);
begin
  Hyp.Add(THypothesis.Create(SHyp));
  FEditHyp.ListBox1.Items.Add(SHyp);
end;

procedure TBD.AddMarkStr(var IHyp: Integer; Str: String);
var
  SL : TStringList;
  i  : Integer;
  ES : Integer;
begin
  if IHyp > Hyp.Count - 1 then Exit;
  SL := TStringList.Create;
  Words(Str,SL);
  ES := Min(Evd.Count, SL.Count);
  for i := 0 to ES - 1 do
    (Hyp[IHyp].EvdRef[i] as TEvdRef).Mark := StrToInt(SL[i]);
  SL.Free;
  IHyp := IHyp + 1;
end;

procedure TBD.Clear;
begin
  Hyp.Clear;
  FEditHyp.ListBox1.Clear;
  Evd.Clear;
  FEditEv.ListBox1.Clear;
  FExpEv.ListBox1.Clear;
  BZ.Free;
  BZ := nil;
end;

constructor TBD.Create;
begin
  Hyp := THypList.Create;
  Evd := TEvdList.Create;
  BZ := nil;
  Scale := 5;
end;

procedure TBD.DelEv(Ind: Integer);
begin
  Evd.Delete(Ind);
  FEditEv.ListBox1.Items.Delete(Ind);
  FExpEv.ListBox1.Items.Delete(Ind);
end;

procedure TBD.DelHyp(Ind: Integer);
begin
  Hyp.Delete(Ind);
  FEditHyp.ListBox1.Items.Delete(Ind);
end;

destructor TBD.Destroy;
begin
  Hyp.Free;
  Evd.Free;
end;

procedure TBD.EditEv(Old: Integer; SEv, PP, NP: String);
begin
  Evd.Edit(Old,TEvidence.Create(Sev,PP,NP));
  FEditEv.ListBox1.Items[Old] := SEv;
  FExpEv.ListBox1.Items[Old] := SEv;
end;

procedure TBD.EditHyp(Old: Integer; NHyp: String);
begin
  Hyp.Edit(Old,THypothesis.Create(NHyp));
  FEditHyp.ListBox1.Items[Old] := NHyp;
end;

function TBD.GetMark(IHyp, IEvd: Integer): Integer;
var R : Integer;
begin
  R := (Hyp[IHyp].EvdRef[IEvd] as TEvdRef).Mark;
  if R > Scale then
    Result := Scale
  else
    if R < -Scale then
      Result := -Scale
    else
      Result := R;
end;

{procedure TBD.New;
begin
  Hyp.Clear;
  FEditHyp.ListBox1.Clear;
  Evd.Clear;
  FEditEv.ListBox1.Clear;
  FExpEv.ListBox1.Clear;
  BZ.Free;
end;}

procedure TBD.Open(Name: String);
var
  SL         : TStringList;
  i          : Integer;
  Last,TLast : Integer;
  CStr       : String;
  IMarkStr   : Integer;
  Clast      : Boolean;        
begin
  SL := TStringList.Create;
  SL.LoadFromFile(Name);
  Clear;
  Last := nsNone;
  IMarkStr := 0;
  Clast := False;
  for i := 0 to SL.Count - 1 do begin
    CStr := Trim(SL[i]);
    TLast := SearchSect(CStr);
    if TLast <> nsNone then Last := TLast
    else
      if Length(CStr) > 0 then
        case Last of
          nsHyp  : Hyp.Add(CStr);
          nsEvid : Evd.Add(CStr);
          nsGrid : AddMarkStr(IMarkStr,CStr);
          nsCEvd : Clast := True;
          nsCHyp : Clast := True;
          nsScal :
            try
              SetScale(StrToInt(CStr));
            except
              raise Exception.Create('Ошибка в шкале');
            end;
        end;
  end;
  SL.Free;
  Hyp.Names(FEditHyp.ListBox1.Items);
  Evd.Names(FEditEv.ListBox1.Items);
  Evd.Names(FExpEv.ListBox1.Items);
  if Clast then begin
    BZ.Free;
    BZ := TBZ.Create(Self);
  end;    
end;

procedure TBD.Save(Name: String);
var
  SL  : TStringList;
  i,j : Integer;
  str : String;
begin
  SL := TStringList.Create;

  SL.Add(bdSect[nsScal]);
  SL.Add(IntToStr(Scale));

  SL.Add('');
  SL.Add(bdSect[nsHyp]);
  Hyp.Names(SL);

  SL.Add('');
  SL.Add(bdSect[nsEvid]);
  for i := 0 to Evd.Count - 1 do
    SL.Add(Evd[i].Str);

  SL.Add('');
  SL.Add(bdSect[nsGrid]);
  for i := 0 to Hyp.Count - 1 do begin
    Str := '';
    for j := 0 to Evd.Count - 1 do
      Str := Str + stspaces(IntToStr(Mark[i,j]),2) + ', ';
    SL.Add(Str);
  end;

  if BZ <> nil then BZ.Save(SL);

  SL.SaveToFile(Name);
  SL.Free;
end;

function TBD.SearchSect(const str: String): Integer;
var i : Integer;
begin
  Result := nsNone;
  for i := 0 to bdSectCount - 1 do begin
    if str = bdSect[i] then begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TBD.SetMark(IHyp, IEvd: Integer; const Value: Integer);
begin
  if (Value < -Scale) and (Value > Scale) then raise Exception.Create('Неверное значение оценки');
  (Hyp[IHyp].EvdRef[IEvd] as TEvdRef).Mark := Value;
  FEditRep.StringGrid1.Cells[IEvd + 1, IHyp + 1] := IntToStr(Value);
end;

procedure TBD.SetScale(Sc: Integer);
begin
  Scale := Sc;
  case Scale of
    5  : begin
      MSett.RadioGroup1.ItemIndex := 0;
      FEditMark.Label7.Visible := True;
      FEditMark.Label8.Visible := False;
      FEditMark.Label9.Visible := False;
    end;
    20 : begin
      MSett.RadioGroup1.ItemIndex := 1;
      FEditMark.Label7.Visible := False;
      FEditMark.Label8.Visible := True;
      FEditMark.Label9.Visible := False;
    end;
    50 : begin
      MSett.RadioGroup1.ItemIndex := 2;
      FEditMark.Label7.Visible := False;
      FEditMark.Label8.Visible := False;
      FEditMark.Label9.Visible := True;
    end;
  end;
  FEditMark.TrackBar1.Position := 0;
  FEditMark.TrackBar1.Min := -Scale;
  FEditMark.TrackBar1.Max :=  Scale;
end;

function TBD.TestRepGrid(var Str: String): Boolean;
var
  i, j, k  : Integer;
  TMark    : Integer;
  IsEq     : Boolean;
begin
  Result := True;
  for i := 0 to Hyp.Count - 1 do begin
    TMark := Mark[i,0];
    IsEq := True;
    for j := 1 to Evd.Count - 1 do
      if Mark[i,j] <> TMark then IsEq := False;
    if IsEq then begin
      Str := 'Гипотеза ' + Hyp[i].Name + ' имеет одинаковые оценки для всех гипотез';
      Result := False;
      Break;
    end;
  end;
  for i := 0 to Evd.Count - 1 do begin
    TMark := Mark[0,i];
    IsEq := True;
    for j := 1 to Hyp.Count - 1 do
      if Mark[j,i] <> TMark then IsEq := False;
    if IsEq then begin
      Str := 'Свидетельство ' + Evd[i].Name + ' имеет одинаковые оценки для всех гипотез';
      Result := False;
      Break;
    end;    
  end;
  for i := 0 to Hyp.Count - 2 do begin
    for j := i + 1 to Hyp.Count - 1 do begin
      IsEq := True;
      for k := 0 to Evd.Count - 1 do
        if Mark[i,k] <> Mark[j,k] then IsEq := False;
      if IsEq then begin
        Str := 'Гипотезы ' + Hyp[i].Name + ' и ' + Hyp[j].Name + ' имеет совпадающие оценки';
        Result := False;
        Break;        
      end;
    end;
  end;
end;

procedure TBD.VisualRepGrid;
var
  i,j   : Integer;
  MR,MC : Integer;
begin
  with FEditRep.StringGrid1 do begin
    RowCount := Hyp.Count + 1;
    ColCount := Evd.Count + 1;
    FixedRows := 1;
    FixedCols := 1;
    for i := 1 to ColCount - 1 do
      Cells[i,0] := Evd[i - 1].Name;
    for j := 1 to RowCount - 1 do
      Cells[0,j] := Hyp[j - 1].Name;
    for i := 1 to ColCount - 1 do
      for j := 1 to RowCount - 1 do
        Cells[i,j] := IntToStr(BD.Mark[j - 1, i - 1]);
    MC := ColCount; if MC > 8 then MC := 8;
    MR := RowCount; if MR > 15 then MR := 15;
    FEditRep.Width  := (DefaultColWidth + 1)*MC + 30;
    FEditRep.Height := (DefaultRowHeight + 1)*MR + 100;
  end;
end;

{ TEvidence }

constructor TEvidence.Create(Nm, PP, NP: String);
begin
  inherited Create;
  if (Nm = '') or (PP = '') or (NP = '') then raise Exception.Create('Пустые прямые и обратные свидетельства');
  if PP = NP then raise Exception.Create('Одинаковые прямые и обратные свидетельства');
  FName   := Nm;
  FPPolus := PP;
  FNPolus := NP;
end;

function TEvidence.Str: String;
begin
  Result := FName   + ' {' + FPPolus + ', ' + FNPolus + '}';
end;

{ TEvdList }

procedure TEvdList.Add(Evd: TEvidence);
var i : Integer;
begin
  for i := 0 to List.Count - 1 do
    if Evd.Name = (List[i] as TEvidence).Name then begin
      Evd.Destroy;
      raise Exception.Create('Повторное имя свидетельства');
    end;
  List.Add(Evd);
  for i := 0 to BD.Hyp.Count - 1 do
    BD.Hyp[i].EvdRef.Add(TEvdRef.Create(0));
end;

procedure TEvdList.Add(Str: String);
var
  SL : TStringList;
begin
  DelSep(Str,',{}');
  SL := TStringList.Create;
  Words(Str,SL);
  if SL.Count <> 3 then begin
    SL.Free;
    raise Exception.Create('Ошибка в описании свидетельств');
  end;
  Add(TEvidence.Create(SL[0],SL[1],SL[2]));
  SL.Free;
end;

procedure TEvdList.Delete(Ind: Integer);
var i : Integer;
begin
  inherited Delete(Ind);
  for i := 0 to BD.Hyp.Count - 1 do
    BD.Hyp[i].EvdRef.Delete(Ind);
end;

procedure TEvdList.Edit(Ind: Integer; Evd: TEvidence);
var i : Integer;
begin
  for i := 0 to List.Count - 1 do
    if (i <> Ind) and (Evd.Name = (List[i] as TEvidence).Name) then begin
      Evd.Destroy;
      raise Exception.Create('Повторное имя свидетельства');
    end;
  List[Ind] := Evd;
end;

function TEvdList.GetItems(Ind: Integer): TEvidence;
begin
  Result := List[Ind] as TEvidence;
end;

procedure TEvdList.Names(Sts: TStrings);
var  i  : Integer;
begin
  for i := 0 to List.Count - 1 do
    Sts.Add((List[i] as TEvidence).Name);
end;

{ TMList }

procedure TMList.Clear;
begin
  List.Clear;
end;

function TMList.Count: Integer;
begin
  Result := List.Count;
end;

constructor TMList.Create;
begin
  inherited Create;
  List := TObjectList.Create;
end;

procedure TMList.Delete(Ind: Integer);
begin
  List.Delete(Ind);
end;

destructor TMList.Destroy;
begin
  List.Free;
  inherited Destroy;
end;

{ THypList }

procedure THypList.Add(Str: String);
begin
  Add(THypothesis.Create(Str));
end;

procedure THypList.Add(Hyp: THypothesis);
var i : Integer;
begin
  for i := 0 to List.Count - 1 do
    if Hyp.Name = (List[i] as THypothesis).Name then begin
      Hyp.Destroy;
      raise Exception.Create('Повторное имя гипотезы');
    end;
  List.Add(Hyp);
end;

procedure THypList.Edit(Ind: Integer; Hyp: THypothesis);
var i : Integer;
begin
  for i := 0 to List.Count - 1 do
    if (i <> Ind) and (Hyp.Name = (List[i] as THypothesis).Name) then begin
      Hyp.Destroy;
      raise Exception.Create('Повторное имя свидетельства');
    end;
  List[Ind] := Hyp;
end;

function THypList.GetItems(Ind: Integer): THypothesis;
begin
  Result := List[Ind] as THypothesis;
end;

procedure THypList.Names(Sts: TStrings);
var i : Integer;
begin
  for i := 0 to List.Count - 1 do
    Sts.Add((List[i] as THypothesis).Name);
end;

{ THypothesis }

constructor THypothesis.Create(Nm: String);
var i : Integer;
begin
  inherited Create;
  if Nm = '' then raise Exception.Create('Пустое имя гипотезы');
  FName := Nm;
  EvdRef := TObjectList.Create;
  for i := 0 to BD.Evd.Count - 1 do
    EvdRef.Add(TEvdRef.Create(0));
end;

destructor THypothesis.Destroy;
begin
  EvdRef.Free;
  inherited;
end;

{ TEvdRef }

constructor TEvdRef.Create(AMark: Integer);
begin
  inherited Create;
  Mark := AMark;
end;

end.
