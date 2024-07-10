program RSP;

const
  k = 1;
  n = 2;
  b = 3;

var  // описание переменных
  Phod, Mhod: byte;
  mashod: array[1..100] of byte;
  mashod1: array[1..100]of byte; 
  resmas: array[1..100] of char;
  res: char;
  i: integer = 1;
  kkk: integer = 0;
  nnn: integer = 0;
  bbb: integer = 0;
  pk: real = 0;
  pn: real = 0;
  pb: real = 0;
  d: integer;
  m1, m2: real;

begin
  if i = 1 then Mhod := n  // фигура на 1 ходе
    else
  begin
    resmas[i] := res; // Запись результата
    mashod[i] := Phod; // запись хода противника
    if i mod 2 = 0 then begin // определение для четного хода
      kkk := 0;  // начало вычисления значений-предсказаний
      nnn := 0;
      bbb := 0;
      
      for d := 1 to i do
      begin
        if mashod[d] = k then inc(kkk);
        if mashod[d] = n then inc(nnn);
        if mashod[d] = b then inc(bbb);
      end;
      
      pk := kkk / i;
      pn := nnn / i;
      pb := bbb / i;  // конец вычисления значений-предсказаний
      
      m1 := min(pk, pn);  // выбор минимального значения
      m2 := min(m1, pb);
      
      if m2 = pk then mhod := b;  // определение следующего хода
      if m2 = pn then mhod := k;
      if m2 = pb then mhod := n;
      
      if (pk = pn) and (pk < pb) then mhod := k;
      if (pn = pb) and (pn < pk) then mhod := n;
      if (pk = pb) and (pk < pn) then mhod := b;
      if (pk = pb) and (pk = pn) then mhod := 2; 
    end
    else
    begin // для нечетного хода 
      if (resmas[i - 1] = 'P') or (resmas[i - 1] = 'V')  then begin
        if mashod1[i - 1] = k then mhod := n;
        if mashod1[i - 1] = n then mhod := b;
        if mashod1[i - 1] = b then mhod := k;
      end;
      if (resmas[i - 1] = 'N') then begin
        if mashod1[i - 1] = k then mhod := b;
        if mashod1[i - 1] = n then mhod := k;
        if mashod1[i - 1] = b then mhod := n;
      end;
    end;
    if (resmas[i - 1] = 'P') and (resmas[i - 2] = 'P') and (resmas[i - 3] = 'P') then begin  // проверка последних 3 ходов 
      if (mashod[i - 1] = mashod[i - 2]) and (mashod[i - 1] = mashod[i - 3]) then begin
        if mashod[i - 1] = k then mhod := b;
        if mashod[i - 1] = n then mhod := k;
        if mashod[i - 1] = b then mhod := n;
      end;
    end; 
  end;
end.




