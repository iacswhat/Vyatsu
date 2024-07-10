unit UBZ;

interface
uses UBD, Classes;

type
  RCluster = record
    V   : Real;    // ������ ������
    m   : Integer; // �����
    a,b : Integer; // ������ ������������ ���������
    Act : Boolean; // true - ���� ������� (��������� � ����������� ���������)
  end;

  TClusters = class (TObject)
  private
    Hm : array of array of Real; // ������� ����������
    Cl : array of RCluster;      // ������ ���������
    QT : Integer;
    function GetCount: Integer;                // ���������� ������������ �����
  public
    constructor Create(AQT: Integer);  // ���������� ������������ �����
    procedure CalcTHEvd(BD: TBD);      // ��������� ���������� ����� ������������� ��������
    procedure CalcTHHyp(BD: TBD);      // ��� ������������� ������������ � �������
    procedure Clusterization();        // �������������
    procedure Strings(Sts: TStrings);  // ���������� � ���������
    procedure DStrings(Sts: TStrings); // ������� ����������
    property Count: Integer read GetCount;
  end;

  TBZ = class (TObject)
  private
    CEvd : TClusters;
    CHyp : TClusters;
    BD   : TBD;
  public
    InM  : array of Integer; // ������ ������ ��� ������
    OutK : array of Integer; // ������ ������������� �����������
    
    constructor Create(ABD: TBD);
    procedure Save(SL: TStringList);  // ��������� � �����
    procedure Conclusion;             // �����
    procedure OutResConc(SHyp, SK: TStrings); // ������� ���������� ������
  end;

var
  BZ : TBZ;

implementation
uses SysUtils;

{ TClusters }

procedure TClusters.CalcTHEvd(BD: TBD);
var
  i,j,k : Integer;
  S     : Real;
  dm    : Integer;
begin
  for k := 0 to BD.Evd.Count - 1 do begin
    Hm[k,k] := 0;
    for j := k + 1 to BD.Evd.Count - 1 do begin
      S := 0;
      for i := 0 to BD.Hyp.Count - 1 do begin
        dm := BD.Mark[i,j] - BD.Mark[i,k];
        S := S + dm*dm;
      end;
      S := Sqrt(S);
      Hm[k,j] := S;
      Hm[j,k] := S;
    end;
  end;
end;

procedure TClusters.CalcTHHyp(BD: TBD);
var
  i,j,k : Integer;
  S     : Real;
  dm    : Integer;
begin
  for k := 0 to BD.Hyp.Count - 1 do begin
    Hm[k,k] := 0;
    for i := k + 1 to BD.Hyp.Count - 1 do begin
      S := 0;
      for j := 0 to BD.Evd.Count - 1 do begin
        dm := BD.Mark[i,j] - BD.Mark[k,j];
        S := S + dm*dm;
      end;
      S := Sqrt(S);
      Hm[k,i] := S;
      Hm[i,k] := S;
    end;
  end;
end;

procedure TClusters.Clusterization;
var
  i,j,k     : Integer;
  MinD      : Real;    // ���. ����������
  D         : Real;
  a,b       : Integer; // ������� ��������� � ���. �����������
  ma,mb,mi  : Integer;
begin
  for k := QT to 2*QT - 2 do begin // ���������� ����������� (����� ���������)
    // ����� ������������ ����������
    a := 0;     while not Cl[a].Act do Inc(a);
    b := a + 1; while not Cl[b].Act do Inc(b);
    MinD := Hm[a,b];
    for i := 0 to 2*QT - 2 do
      if Cl[i].Act then
        for j := i + 1 to 2*QT - 2 do
          if Cl[j].Act and (MinD > Hm[i,j]) then begin
            a := i;
            b := j;
            MinD := Hm[a,b];
          end;
    // �������� ������ ��������
    ma := Cl[a].m; mb := Cl[b].m;
    Cl[k].a := a;
    Cl[k].b := b;
    Cl[k].m := ma + mb;
//    Cl[k].V := ma*mb*MinD*MinD/(ma + mb); // ��� � ������ ��
    Cl[k].V := ma*mb*MinD/((ma + mb)*(ma + mb));
    Cl[k].Act := True;
    Cl[a].Act := False;
    Cl[b].Act := False;
    // �������� ���������� ��� ������ ��������
    for i := 0 to k - 1 do
      if Cl[i].Act then begin
        mi := Cl[i].m;
        D  := ((ma + mb)*Hm[a,b] + (ma + mi)*Hm[a,i] + (mb + mi)*Hm[b,i]
               - ma*Cl[a].V - mb*Cl[b].V - mi*Cl[i].V) / (ma + mb + mi);
        Hm[i,k] := D;
        Hm[k,i] := D;
      end;
  end;
end;

constructor TClusters.Create(AQT: Integer);
var i : Integer;
begin
  inherited Create;
  QT := AQT;
  SetLength(Hm,2*QT - 1, 2*QT - 1);
  SetLength(Cl,2*QT - 1);
  for i := 0 to QT - 1 do begin
    Cl[i].V   := 0;
    Cl[i].m   := 1;
    Cl[i].a   := -1;
    Cl[i].b   := -1;
    Cl[i].Act := True;
  end;
  for i := QT to 2*QT - 2 do
    Cl[i].Act := False;
end;

procedure TClusters.DStrings(Sts: TStrings);
var
  i,j : Integer;
  Str : String;
begin
  STS.Clear;
  for i := 0 to 2*QT - 2 do begin
    Str := '';
    for j := 0 to 2*QT - 2 do
      Str := Str + stspaces(FloatToStr(Hm[i,j]),5) + '; ';
    STS.Add(Str);
  end;
end;

function TClusters.GetCount: Integer;
begin
  Result := QT*2 - 1;
end;

procedure TClusters.Strings(Sts: TStrings);
var i : Integer;
begin
  Sts.Clear;
  for i := 0 to 2*QT - 2 do
    Sts.Add(stspaces(IntToStr(Cl[i].a),3) + ' ' +
            stspaces(IntToStr(Cl[i].b),3) + ' ' +
            stspaces(IntToStr(Cl[i].m),3) + ' ' +
            stspaces(FloatToStr(Cl[i].v),5));
end;

{ TBZ }

procedure TBZ.Conclusion;
var
  i,j : Integer;
  S,K : Real;
  dm  : Integer;
begin
  for i := 0 to BD.Hyp.Count - 1 do begin
    S := 0;
    for j := 0 to BD.Evd.Count - 1 do begin
      dm := BD.Mark[i,j] - InM[j];
      S := S + dm*dm;
    end;
    S := Sqrt(S / BD.Evd.Count);
    K := 200/(S + 1.75) - 20;
    if (K < 0)   then K := 0;
    if (K > 100) then K := 100;
    OutK[i] := Round(K);
  end;
end;

constructor TBZ.Create(ABD: TBD);
begin
  inherited Create;
  BD := ABD;
  CEvd := TClusters.Create(BD.Evd.Count);
  CEvd.CalcTHEvd(BD);
  CEvd.Clusterization;
  CHyp := TClusters.Create(BD.Hyp.Count);
  CHyp.CalcTHHyp(BD);
  CHyp.Clusterization;
  SetLength(InM,BD.Evd.Count);
  SetLength(OutK,BD.Hyp.Count);
end;

procedure TBZ.OutResConc(SHyp, SK: TStrings);
var
  SA    : array of Integer;
  i,j,t : Integer;
  Count : Integer;
begin
  Count := BD.Hyp.Count;
  SetLength(SA,Count);
  for i := 0 to Count - 1 do SA[i] := i;
  for i := 0 to Count - 2 do
    for j := i + 1 to Count - 1 do
      if OutK[SA[i]] < OutK[SA[j]] then begin
        t := SA[i];
        SA[i] := SA[j];
        SA[j] := t;
      end;
  SHyp.Clear;
  for i := 0 to Count - 1 do
    SHyp.Add(BD.Hyp[SA[i]].Name);
  SK.Clear;
  for i := 0 to Count - 1 do
    SK.Add(IntToStr(OutK[SA[i]]));
end;

procedure TBZ.Save(SL: TStringList);
var
  T  : TStringList;
begin
  T  := TStringList.Create;

  SL.Add('');
  SL.Add(bdSect[nsCEvd]);
  CEvd.Strings(T);
  SL.AddStrings(T);
  CEvd.DStrings(T);
  SL.AddStrings(T);

  SL.Add('');
  SL.Add(bdSect[nsCHyp]);
  CHyp.Strings(T);
  SL.AddStrings(T);
  CHyp.DStrings(T);
  SL.AddStrings(T);

  T.Free;
end;

end.
