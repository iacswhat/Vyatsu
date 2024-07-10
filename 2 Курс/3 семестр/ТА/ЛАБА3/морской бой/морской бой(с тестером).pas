
type
    TMapRow = array of integer;
    TMap = array of TMapRow;
    
    
    
    TCoordinates = array of integer;
     TCoord= record
     i: integer;
     j: integer;
     end;
const
    // Коды результатов выстрела:
    SHOT_RESULT_EMPTY: integer = 0; // Промах
    SHOT_RESULT_DAMAGE: integer = 2; // Корабль соперника ранен (подбит)
    SHOT_RESULT_KILL: integer = 3; // Корабль соперника убит (подбиты все палубы)

var
    setnumber: integer;
    hodnumber: integer=1;
     ii,jj: integer;
    nom: integer=1;
    dophod: array [1..1000] of TCoord ;
    hemap: array[0..9,0..9] of byte;
     hodi: integer;
     hodj: integer; 
     flag,f: boolean;
     
     
     fll: boolean;
     sh:  TCoord;
     res: integer;
     i,j,kan,ori,orj: integer;
     
     
     
     hmap: array[0..9,0..9] of integer;
         
      
     
procedure deletehod(i: integer;j:integer);
begin                          //заполнение массива ходов(куда нельзя стрелять)
       i:=i-1; j:=j-1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1;
        j:=j+1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
        j:=j+1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
         i:=i+1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
          i:=i+1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
            j:=j-1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
             j:=j-1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1; 
             i:=i-1;
       if (i>=0)and(i<=9)and(j>=0)and(j<=9)and(hemap[i,j]<>2) then
       hemap[i,j]:=1;    
end;     
     
     
procedure setParameters(setCount: integer);
begin
end;

procedure onGameStart();
begin
end;

procedure onSetStart();
begin
 f:=false;
 flag:=false;
    setnumber:=setnumber+1;
    
    if setnumber=6 then
      setnumber:=1;
    
    hemap[0,0]:=3;  hemap[0,1]:=8; hemap[0,2]:=3; hemap[0,3]:=7; hemap[0,4]:=3; hemap[0,5]:=5; hemap[0,6]:=3; hemap[0,7]:=7; hemap[0,8]:=3; hemap[0,9]:=3;
    hemap[1,0]:=5;  hemap[1,1]:=3; hemap[1,2]:=6; hemap[1,3]:=3; hemap[1,4]:=4; hemap[1,5]:=3; hemap[1,6]:=6; hemap[1,7]:=3; hemap[1,8]:=4; hemap[1,9]:=3;
    hemap[2,0]:=3;  hemap[2,1]:=6; hemap[2,2]:=3; hemap[2,3]:=4; hemap[2,4]:=3; hemap[2,5]:=6; hemap[2,6]:=3; hemap[2,7]:=4; hemap[2,8]:=3; hemap[2,9]:=7;
    hemap[3,0]:=7;  hemap[3,1]:=3; hemap[3,2]:=4; hemap[3,3]:=3; hemap[3,4]:=6; hemap[3,5]:=3; hemap[3,6]:=4; hemap[3,7]:=3; hemap[3,8]:=6; hemap[3,9]:=3;
    hemap[4,0]:=3;  hemap[4,1]:=4; hemap[4,2]:=3; hemap[4,3]:=6; hemap[4,4]:=3; hemap[4,5]:=4; hemap[4,6]:=3; hemap[4,7]:=6; hemap[4,8]:=3; hemap[4,9]:=5;
    hemap[5,0]:=8;  hemap[5,1]:=3; hemap[5,2]:=6; hemap[5,3]:=3; hemap[5,4]:=4; hemap[5,5]:=3; hemap[5,6]:=6; hemap[5,7]:=3; hemap[5,8]:=4; hemap[5,9]:=3;
    hemap[6,0]:=3;  hemap[6,1]:=6; hemap[6,2]:=3; hemap[6,3]:=4; hemap[6,4]:=3; hemap[6,5]:=6; hemap[6,6]:=3; hemap[6,7]:=4; hemap[6,8]:=3; hemap[6,9]:=7;
    hemap[7,0]:=7;  hemap[7,1]:=3; hemap[7,2]:=4; hemap[7,3]:=3; hemap[7,4]:=6; hemap[7,5]:=3; hemap[7,6]:=4; hemap[7,7]:=3; hemap[7,8]:=6; hemap[7,9]:=3;
    hemap[8,0]:=3;  hemap[8,1]:=4; hemap[8,2]:=3; hemap[8,3]:=6; hemap[8,4]:=3; hemap[8,5]:=4; hemap[8,6]:=3; hemap[8,7]:=6; hemap[8,8]:=3; hemap[8,9]:=5;
    hemap[9,0]:=4;  hemap[9,1]:=3; hemap[9,2]:=7; hemap[9,3]:=3; hemap[9,4]:=8; hemap[9,5]:=3; hemap[9,6]:=7; hemap[9,7]:=3; hemap[9,8]:=5; hemap[9,9]:=3;
    
end;

{function getMap(): TMap;
begin
  
  
  if setnumber=1 then begin
    result := TMap.Create(
        TMapRow.Create(1, 0, 1, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(1, 0, 0, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
        TMapRow.Create(1, 0, 1, 0, 0, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(1, 0, 0, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    );
    end;
end;}




{function shoot(): TCoordinates;
var i,j: integer;
begin
  if hodnumber=1 then
  begin
  hodi:=0;
  hodj:=0;
    end
    else
    begin
   f11:=false;
    repeat
     i:=i+1;
     if hemap[hodi,hodj]= 0 then
       fll:=true
       else begin
       if i<=9 then
       i:=i+1
       else
       begin
       i:=0;
       j:=j+1;
       end;
       end;
     until(fll=true) 
   
   
    end;
 if hemap[hodi,hodj]=0 then  begin 
hodnumber:=hodnumber+1; 
result :=TCoordinates.Create(hodi,hodj); 
end;
end;}


function shoot(): TCoord;
var i,j,maxi,maxj: integer; 
begin
  if hodnumber=1 then
  begin
  hodi:=0;
  hodj:=0;
    end
    else
    begin
      maxi:=0;
      maxj:=0;
      fll:=false;
      for i:=0 to 9 do begin
          for j:=0 to 9 do begin
            
             if hemap[i,j]>hemap[maxi,maxj] then begin
              maxi:=i;
              maxj:=j;
              end;
     
     
          end;
          end;
          
          hodi:=maxi;
          hodj:=maxj;
          
          
    end;
   hodnumber:=hodnumber+1; 
result.i:=hodi;
result.j:=hodj;
end;

procedure shotResult(resultCode: integer);
var k: integer;
i,j: integer;

begin

 if resultcode=0 then 
  begin  
   ii:=hodi;
   jj:=hodj;
   hemap[ii,jj]:=1;   
  end;

    if resultcode=2 then
    begin
     
    if f=true then
    nom:=nom+1;
    ii:=hodi;
    jj:=hodj;
    dophod[nom].i:=hodi;
    dophod[nom].j:=hodj;
    hemap[hodi,hodj]:=2;
    if nom=1 then begin
        ori:=hodi;
      orj:=hodj;
      jj:=jj-1;
      if (ii>=0)and(ii<=9)and(jj>=0)and(jj<=9)and(hemap[ii,jj]<>1) then
      hemap[ii,jj]:=9;
       jj:=jj+1;
       ii:=ii-1;
      if (ii>=0)and(ii<=9)and(jj>=0)and(jj<=9)and(hemap[ii,jj]<>1) then
      hemap[ii,jj]:=9;
           jj:=jj+1;
           ii:=ii+1;
      if (ii>=0)and(ii<=9)and(jj>=0)and(jj<=9)and(hemap[ii,jj]<>1) then
      hemap[ii,jj]:=9;
           jj:=jj-1;
           ii:=ii+1;
      if (ii>=0)and(ii<=9)and(jj>=0)and(jj<=9)and(hemap[ii,jj]<>1) then
      hemap[ii,jj]:=9;
      end;
      if nom>1 then begin
        
      { if (hodi>ori)then begin   //выстрелы вниз
        for j:=0 to 9 do 
          for i:=0 to 9 do begin
            if (hemap[i,j]=9) then
            hemap[i,j]:=1;
            if ((i=hodi+1)and(j=orj))and(hemap[i,j]<>1)then
              hemap[i,j]:=9;
            if (i=ori-1)and(j=hodj)and(hemap[i,j]<>1)then
               hemap[i,j]:=9;
          end; 
       end; 
       
       if (hodi<ori)then begin   //выстреллы вверх
        for i:=0 to 9 do 
          for j:=0 to 9 do begin
            if (hemap[i,j]=9)then 
            hemap[i,j]:=1;
            if ((i=ori+1)and(j=hodj))and(hemap[i,j]<>1)then
              hemap[i,j]:=9;
            if(i=hodi-1)and(j=hodj)and(hemap[i,j]<>1)then
              hemap[i,j]:=9; 
          end; 
       end; }
       
       
       
        if (hodi>ori)then begin   //выстрелы вниз
        for j:=0 to 9 do 
          for i:=0 to 9 do begin
            if (i<>ori-1)and(j<>hodj)and(hemap[i,j]=9) then
            hemap[i,j]:=1;
            if ((i=hodi+1)and(j=orj))and(hemap[i,j]<>1)then
              hemap[i,j]:=9;
          end; 
       end; 
       
       if (hodi<ori)then begin   //выстреллы вверх
        for i:=0 to 9 do 
          for j:=0 to 9 do begin
            if ((i<>ori+1)and(j<>orj)and(hemap[i,j]=9))then 
            hemap[i,j]:=1;
            if(i=hodi-1)and(j=hodj)and(hemap[i,j]<>1)then
              hemap[i,j]:=9; 
          end; 
       end; 
       
       
       
       
       
        if (hodj<orj)then begin  //выстрелы влево
        for i:=0 to 9 do 
          for j:=0 to 9 do begin
            if ((i<>hodi)and(j<>orj+1)and(hemap[i,j]=9))then
            hemap[i,j]:=1;
            if ((i=hodi)and(j=hodj-1))and(hemap[i,j]<>1)then
               hemap[i,j]:=9;
          end; 
       end; 
       
       
       if (hodj>orj)then begin
        for i:=0 to 9 do 
          for j:=0 to 9 do begin
            if ((i<>hodi)and(j<>orj-1)and(hemap[i,j]=9))then
            hemap[i,j]:=1;
            if ((i=hodi)and(j=hodj+1))and(hemap[i,j]<>1)then
               hemap[i,j]:=9;
          end; 
       end; 
       
       
       
      end;
    f:=true;
   
    end;


    if resultcode=3 then
    begin
     ii:=hodi;
     jj:=hodj;
    hemap[ii,jj]:=2;   
    deletehod(ii,jj);
  
      if (f=true) then begin
    for k:=1 to nom do begin
     ii:=dophod[k].i;
     jj:=dophod[k].j;
     hemap[ii,jj]:=2;   
    deletehod(ii,jj);
  end;
  nom:=1;
    f:=false;
  end;

end;
end;

procedure onOpponentShot(cell: TCoordinates);
begin
end;

procedure onSetEnd();
begin
end;

procedure onGameEnd();
begin
end;

begin
  
    hmap[0,0]:=0;  hmap[0,1]:=0; hmap[0,2]:=0; hmap[0,3]:=0; hmap[0,4]:=1; hmap[0,5]:=0; hmap[0,6]:=0; hmap[0,7]:=0; hmap[0,8]:=0; hmap[0,9]:=0;
    hmap[1,0]:=0;  hmap[1,1]:=0; hmap[1,2]:=0; hmap[1,3]:=0; hmap[1,4]:=1; hmap[1,5]:=0; hmap[1,6]:=0; hmap[1,7]:=0; hmap[1,8]:=0; hmap[1,9]:=1;
    hmap[2,0]:=0;  hmap[2,1]:=1; hmap[2,2]:=0; hmap[2,3]:=0; hmap[2,4]:=1; hmap[2,5]:=0; hmap[2,6]:=1; hmap[2,7]:=0; hmap[2,8]:=0; hmap[2,9]:=1;
    hmap[3,0]:=0;  hmap[3,1]:=0; hmap[3,2]:=0; hmap[3,3]:=0; hmap[3,4]:=0; hmap[3,5]:=0; hmap[3,6]:=0; hmap[3,7]:=0; hmap[3,8]:=0; hmap[3,9]:=1;
    hmap[4,0]:=1;  hmap[4,1]:=0; hmap[4,2]:=1; hmap[4,3]:=0; hmap[4,4]:=0; hmap[4,5]:=0; hmap[4,6]:=0; hmap[4,7]:=0; hmap[4,8]:=0; hmap[4,9]:=1;
    hmap[5,0]:=0;  hmap[5,1]:=0; hmap[5,2]:=1; hmap[5,3]:=0; hmap[5,4]:=0; hmap[5,5]:=0; hmap[5,6]:=1; hmap[5,7]:=1; hmap[5,8]:=0; hmap[5,9]:=0;
    hmap[6,0]:=0;  hmap[6,1]:=0; hmap[6,2]:=0; hmap[6,3]:=0; hmap[6,4]:=0; hmap[6,5]:=0; hmap[6,6]:=0; hmap[6,7]:=0; hmap[6,8]:=0; hmap[6,9]:=0;
    hmap[7,0]:=0;  hmap[7,1]:=0; hmap[7,2]:=0; hmap[7,3]:=0; hmap[7,4]:=0; hmap[7,5]:=0; hmap[7,6]:=0; hmap[7,7]:=0; hmap[7,8]:=0; hmap[7,9]:=0;
    hmap[8,0]:=0;  hmap[8,1]:=0; hmap[8,2]:=0; hmap[8,3]:=0; hmap[8,4]:=0; hmap[8,5]:=0; hmap[8,6]:=0; hmap[8,7]:=0; hmap[8,8]:=0; hmap[8,9]:=0;
    hmap[9,0]:=1;  hmap[9,1]:=1; hmap[9,2]:=1; hmap[9,3]:=0; hmap[9,4]:=1; hmap[9,5]:=0; hmap[9,6]:=0; hmap[9,7]:=0; hmap[9,8]:=1; hmap[9,9]:=1;
    
  
  
  
  onSetStart();
  
  
  
  
  
  
  
  repeat
sh:=shoot;
writeln('Мой выстрел:'+inttostr(hodi)+','+inttostr(hodj));
//writeln('0-промах,2-ранил,3-убил');

if (hmap[hodi,hodj]=2)or(hmap[hodi,hodj]=2) then begin
writeln;
writeln;
writeln;
writeln('ОШИБКА');
writeln;
writeln;
writeln;
end;
res:=8;


if (hmap[hodi,hodj]=0) then begin
hmap[hodi,hodj]:=5;
res:=0;
end;
if (hmap[hodi,hodj]=1) then begin
hmap[hodi,hodj]:=2;
res:=2;
//writeln('res есть')
end;



if (hmap[9,4]=2)and(hodi=9)and(hodj=4) then   //однопалубные
res:=3;   

if (hmap[4,0]=2)and(hodi=4)and(hodj=0) then
res:=3; 


if (hmap[2,1]=2)and(hodi=2)and(hodj=1) then
res:=3;

if (hmap[2,6]=2)and(hodi=2)and(hodj=6) then
res:=3; 


if (hmap[9,8]=2) and (hmap[9,9]=2)and((hodi=9)and(hodj=8)or((hodi=9)and(hodj=9))) then  //двухпалубные
res:=3; 

if  ((hmap[4,2]=2)and(hmap[5,2]=2))and((hodi=4)and(hodj=2)or((hodi=5)and(hodj=2))) then
res:=3;

if ((hmap[5,6]=2)and (hmap[5,7]=2))and((hodi=5)and(hodj=6)or((hodi=5)and(hodj=7))) then
res:=3;



if ((hmap[0,4]=2) and (hmap[1,4]=2) and (hmap[2,4]=2))and((hodi=0)and(hodj=4)or((hodi=1)and(hodj=4))or((hodi=2)and(hodj=4))) then //3 палуб
  res:=3;
if ((hmap[9,0]=2)and(hmap[9,1]=2)and(hmap[9,2]=2))and((hodi=9)and(hodj=0)or((hodi=9)and(hodj=1))or((hodi=9)and(hodj=2))) then
res:=3;  


if ((hmap[1,9]=2) and (hmap[2,9]=2) and (hmap[3,9]=2)and (hmap[4,9]=2))   and((hodi=1)and(hodj=9)or((hodi=2)and(hodj=9))or((hodi=3)and(hodj=9))or((hodi=4)and(hodj=9))) then   //4 пал
  res:=3;



writeln('res='+inttostr(res )); 
writeln('hodi='+inttostr(hodi));
writeln('hodj='+inttostr(hodj));
writeln('ori='+inttostr(ori));
writeln('orj='+inttostr(orj));

shotResult(res);
writeln('nom='+inttostr(nom));

for i:=0 to 9 do begin
  for j:=0 to 9 do begin
    write(hemap[i,j]);
    end;
  writeln;
  end;
  readln();
  until(kan=1)




end.