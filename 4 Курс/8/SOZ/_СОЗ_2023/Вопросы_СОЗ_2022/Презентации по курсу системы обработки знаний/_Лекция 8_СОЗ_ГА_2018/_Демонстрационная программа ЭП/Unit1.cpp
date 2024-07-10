//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#include <vfw.h>
#include <stdlib.h>
#include <dos.h>
#include <stdio.h>
#pragma hdrstop
#define BorderUp 4
#define BorderDown 2
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define max(a, b)  (((a) > (b)) ? (a) : (b))

#include "Unit1.h"
#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "SHDocVw_OCX"
#pragma resource "*.dfm"
TForm1 *Form1;
bool **masx1;  // переменая 1
bool **masx2;  // переменая 1
bool **masx3;  // переменая 1
bool **masx4;  // переменая 1
//vector<vector<vector<unsigned char> > > masx;
vector<float> masy;  // tmp
vector<float> masPs;  // вероятности отбора
vector<float> masFunc[2];  // вероятности отбора
vector<int> masNG;  // следующее поколение
int Kol = 2;  // количество переменых
int T = 15, tT, NG = 0; // таймер
AnsiString buttonCapt[2] = {"Запуск", "Стоп"};
AnsiString CurDir = GetCurrentDir();
int Pop, Ps, Pm;  // популяция, вероятность скрещивания, вероятность мутации
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
        GridKol->Text = Kol;
        Pop = StrToInt(GridPop->Text);
        Ps = StrToInt(VerC->Text);
        Pm = StrToInt(VerM->Text);
        ParamsCreate();
        Label1->Caption = "Количество переменных ("+IntToStr(BorderDown)+"-"+IntToStr(BorderUp)+"):";
        GridKol->Left = Label1->Left+Label1->Width+3;
        SpeedButton1->Left = GridKol->Left+GridKol->Width+1;
        wchar_t* URL=StringToOleStr(CurDir+"\\Examples\\Index.html");
        CppWebBrowser1->Navigate(URL,NULL,NULL,NULL,NULL);

        parser = new Parser();
}
//---------------------------------------------------------------------------
bool __fastcall TForm1::TestValues()
{       // Ok
        try // проверка вероятности скрещивания
        {
          Ps = StrToInt(VerC->Text);
          if (Ps > 100 || Ps < 40)
          {
            //VerC->Text = UpDown3->Position;
            TestLabel->Caption = "Некорректно задана вероятность скрещивания!!!";
            return 1;
          }
        }
        catch(...)
        {
          //VerC->Text = UpDown3->Position;
          TestLabel->Caption = "Некорректно задана вероятность скрещивания!!!";
          return 1;
        }
        try // проверка вероятности мутации
        {
          Pm = StrToInt(VerM->Text);
          if (Pm > 40 || Pm < 1)
          {
            //VerM->Text = UpDown2->Position;
            TestLabel->Caption = "Некорректно задана вероятность мутации!!!";
            return 1;
          }
        }
        catch(...)
        {
          //VerM->Text = UpDown2->Position;
          TestLabel->Caption = "Некорректно задана вероятность мутации!!!";
          return 1;
        }
        try // проверка численности популяции
        {
          Pop = StrToInt(GridPop->Text);
          if (Pop > 100 || Pop < 20 || Pop%2 == 1)
          {
            //if (UpDown4->Position%2 == 1) UpDown4->Position ++;
            //GridPop->Text = UpDown4->Position;
            TestLabel->Caption = "Некорректно задана численность популяции!!!";
            return 1;
          }
        }
        catch(...)
        {
          //if (UpDown4->Position%2 == 1) UpDown4->Position ++;
          //GridPop->Text = UpDown4->Position;
          TestLabel->Caption = "Некорректно задана численность популяции!!!";
          return 1;
        }

        float tmp;
        int i;
        for (i = 0; i < Kol; i++)
        {
          try
          {
            tmp = StrToFloat(GridMin->Cells[0][i]);
            if (max(tmp, StrToFloat(GridMax->Cells[0][i])) == tmp)
            {
              GridMin->Cells[0][i] = "";
              GridMax->Cells[0][i] = "";
              TestLabel->Caption = "Некорректно заданы параметры переменных!!!";
              return 1;
            }  
          }
          catch(...)
          {
            GridMin->Cells[0][i] = "";
            GridMax->Cells[0][i] = "";
            TestLabel->Caption = "Некорректно заданы параметры переменных!!!";
            return 1;
          }
        }
        try
        {
          T = StrToInt(TimeEdit->Text);
          if (T < 1)
          {
            //TimeEdit->Text = "";
            TestLabel->Caption = "Некорректно задан параметр останова";
            return 1;
          }
        }
        catch(...)
        {
          //TimeEdit->Text = "";
          TestLabel->Caption = "Некорректно задан параметр останова";
          return 1;
        }
        TestLabel->Caption = "";
        return 0;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AllocMem()
{
        int i, k;
        masx1 = new bool *[Pop];
        k = FindDeg(1)*2;
        for (i = 0; i < Pop; i++)
          masx1[i] = new bool [k];
        masx2 = new bool *[Pop];
        k = FindDeg(2)*2;
        for (i = 0; i < Pop; i++)
          masx2[i] = new bool [k];
        if (Kol > 2)
        {
          masx3 = new bool *[Pop];
          k = FindDeg(3)*2;
          for (i = 0; i < Pop; i++)
            masx3[i] = new bool [k];
        }
        if (Kol > 3)
        {
          masx4 = new bool *[Pop];
          k = FindDeg(4)*2;
          for (i = 0; i < Pop; i++)
            masx4[i] = new bool [k];
        }
        //masx.clear();
        masy.clear();
        //masx.resize(Kol);
        masy.resize(Kol);
        /*for (int i = 0; i < Kol; ++i)
        {
        	masx[i].resize(Pop);
                int k = FindDeg(i+1)*2;
                for (int j = 0; j < Pop; ++j)
                	masx[i][j].resize(k);
        }*/

        /*masPs = new float[Pop];
        masFunc[0] = new float[Pop];
        masFunc[1] = new float[Pop];
        masNG = new int[Pop];*/
        masPs.resize(Pop);
        masFunc[0].resize(Pop);
        masFunc[1].resize(Pop);
        masNG.resize(Pop);
}
//---------------------------------------------------------------------------
int __fastcall TForm1::FindDeg(int ab)
{       // Ok
        ab--;
        return ceil(log(pow(10,UpDown1->Position)*(StrToFloat(GridMax->Cells[0][ab])-StrToFloat(GridMin->Cells[0][ab]))+1)/log(2));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::GridCreate(TStringGrid *grid)
{       // Ok
        grid->RowCount = Kol;
        grid->Height = (grid->DefaultRowHeight+1)*Kol+1;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ParamsCreate()
{       // Ok
        GridCreate(GridMin);
        GridCreate(GridText);
        GridCreate(GridMax);
        byte i;
        for (i = 0; i < Kol; i++)
          GridText->Cells[0][i] = "<= x"+IntToStr(i+1)+" <=";
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ClearAll()
{       // очистка параметров
        GridMin->Cols[0]->Clear();
        GridMax->Cols[0]->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::GridMinKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{       // проверка на ввод левого конца отрезка
        if (Key == VK_RETURN)
        {
          float tmp;
          try
          {
            tmp = StrToFloat(GridMin->Cells[0][GridMin->Row]);
            if (GridMax->Cells[0][GridMin->Row] != "")
              if (tmp > StrToFloat(GridMax->Cells[0][GridMin->Row]))
              {
                GridMin->Cells[0][GridMin->Row] = "";
                GridMax->Cells[0][GridMin->Row] = "";
              }
          }
          catch(...)
          {
            GridMin->Cells[0][GridMin->Row] = "";
            GridMax->Cells[0][GridMin->Row] = "";
          }
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::GridMaxKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{       // проверка на ввод правого конца отрезка
        if (Key == VK_RETURN)
        {
          float tmp;
          try
          {
            tmp = StrToFloat(GridMax->Cells[0][GridMax->Row]);
            if (GridMin->Cells[0][GridMax->Row] != "")
              if (tmp < StrToFloat(GridMin->Cells[0][GridMax->Row]))
              {
                GridMax->Cells[0][GridMax->Row] = "";
                GridMin->Cells[0][GridMax->Row] = "";
              }
          }
          catch(...)
          {
            GridMax->Cells[0][GridMax->Row] = "";
            GridMin->Cells[0][GridMax->Row] = "";
          }
        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::UpDown1Click(TObject *Sender, TUDBtnType Button)
{       // правка формата переменных
        byte i;
        AnsiString str = "*";
        if (UpDown1->Position != 0) str = str + ",";
        for (i = 0; i < UpDown1->Position; i++)
          str = str + "*";
        Label2->Caption = str;
        Label2->Left = (GroupBox1->Width+54-Label2->Width)/2;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SpeedButton1Click(TObject *Sender)
{       // проверка на ввод количества переменных
        int tmp;
        try
        {
          tmp = StrToInt(GridKol->Text);
          if (tmp > BorderUp || tmp < BorderDown)
            GridKol->Text = Kol;
          else Kol = tmp;
        }
        catch(...)
        {
          GridKol->Text = Kol;
        }
        ParamsCreate();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::GridKolClick(TObject *Sender)
{       // Ok
        GridKol->SelectAll();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::GridKolKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{       // Ok
        if (Key == VK_RETURN) SpeedButton1Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
        if (TestValues()) return;
        ListPop->Cols[0]->Clear();
        ListPop->Cols[1]->Clear();
        ListPopNew->Cols[0]->Clear();
        ListPopNew->Cols[1]->Clear();
        NextListPop->Cols[0]->Clear();
        NextListPop->Cols[1]->Clear();
        NGen->Caption = "";
        Answ->Text = "";
        AllocMem();
        NG = 0;
        FillPop();
        PageControl1->ActivePage = TabSheet2;
        SwitchEnable();
        //Edit1->Enabled = false;
        //UpDown5->Enabled = false;
        SpeedButton3->Enabled = true;
        SpeedButton4->Enabled = true;
        cbFunc->Enabled = false;
        edVarNames->Enabled = false;

        vars.clear();
        AnsiString func = cbFunc->Text;

        if (RMin->Checked)
        {
        	func.Insert("-(", 0);
                func += ")";
        }

        parser->SetExpression(func.c_str());
        Kol = ParseVarNames();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FillPop()
{
        Randomize();
        int i, j;
       // for (int l = 0; l < Kol; ++l)
       // {
               //	for (int j = 0; j < FindDeg(l+1); ++j)
               // {
                        for (i = 0; i < Pop; i++)
                        {
                               //	masx[l][i][j] = random(2);
                          for (j = 0; j < FindDeg(1); j++)
                            masx1[i][j] = random(2);
                          for (j = 0; j < FindDeg(2); j++)
                            masx2[i][j] = random(2);
                          if (Kol > 2)
                            for (j = 0; j < FindDeg(3); j++)
                              masx3[i][j] = random(2);
                          if (Kol > 3)
                            for (j = 0; j < FindDeg(4); j++)
                              masx4[i][j] = random(2);
                        }
                //}
        //}
}
//---------------------------------------------------------------------------
float __fastcall TForm1::TestFunc(/*float x, float y, float z, float t*/)
{
        /*int tmp = UpDown5->Position;
        if  (RMax->Checked)
        {
          switch(tmp)
          {
          case 1: return -x*exp(-x*x-y*y)-0.3;
          case 2: return -x*x*exp(1-x*x-20*(x-y)*(x-y));
          case 3: return(0.5*y-x*x)+(1-1.5*x)*(1-1.5*x)+(1-2*y)*(1-2*y);
          case 4: return (x-2)*(x-2)+(y-5)*(y-5)+(z+2)*(z+2)-16-x+y-z;
          case 5: return -20-x*x-y*y+10*cos(x)+10*sin(y);
          case 6: return x*x+y*y+40*sin(x)*sin(y);
          case 7: return exp(x+y)/exp(x*x+y*y);
          case 8: return (y+1)*(y+1)-x*x+y*y+(z-1)*(z-1)+z*z-(x+1)*(x+1);
          case 9: return (x-1)*(x-1)+(y+2)*(y+2)+(z-2)*(z-2)+(t+1)*(t+1)+x-y+z-t;
          }
        }
        else
        {
          switch(UpDown5->Position)
          {
          case 1: return -1*(-x*exp(-x*x-y*y)-0.3);
          case 2: return -1*(-x*x*exp(1-x*x-20*(x-y)*(x-y)));
          case 3: return -1*((0.5*y-x*x)+(1-1.5*x)*(1-1.5*x)+(1-2*y)*(1-2*y));
          case 4: return -1*((x-2)*(x-2)+(y-5)*(y-5)+(z+2)*(z+2)-16-x+y-z);
          case 5: return -1*(-20-x*x-y*y+10*cos(x)+10*sin(y));
          case 6: return -1*(x*x+y*y+40*sin(x)*sin(y));
          case 7: return -1*(exp(x+y)/exp(x*x+y*y));
          case 8: return -1*((y+1)*(y+1)-x*x+y*y+(z-1)*(z-1)+z*z-(x+1)*(x+1));
          case 9: return -1*((x-1)*(x-1)+(y+2)*(y+2)+(z-2)*(z-2)+(t+1)*(t+1)+x-y+z-t);
          }
        }
        return 0;    */

        return (float)parser->Parse(vars);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FillListPop(TStringGrid* grid)
{
        grid->RowCount = Pop;
        int i, j;
        AnsiString str;
        for (i = 0; i < Pop; i++)
        {
          str = "Func(";
          masy[0] = StrToFloat(FloatToStrF(FindNum(i, 1),ffFixed,7,UpDown1->Position));
          str = str+FloatToStrF(masy[0],ffFixed,7,UpDown1->Position);
          vars[names[0]] = masy[0];

          if (Kol > 1)
          {
          	masy[1] = StrToFloat(FloatToStrF(FindNum(i, 2),ffFixed,7,UpDown1->Position));
	        str = str+"; "+FloatToStrF(masy[1],ffFixed,7,UpDown1->Position);
                vars[names[1]] = masy[1];
          }
          if (Kol > 2)
          {
            masy[2] = StrToFloat(FloatToStrF(FindNum(i, 3),ffFixed,7,UpDown1->Position));
            str = str+"; "+FloatToStrF(masy[2],ffFixed,7,UpDown1->Position);
            vars[names[2]] = masy[2];
          }
          if (Kol > 3)
          {
            masy[3] = StrToFloat(FloatToStrF(FindNum(i, 4),ffFixed,7,UpDown1->Position));
            str = str+"; "+FloatToStrF(masy[3],ffFixed,7,UpDown1->Position);
            vars[names[3]] = masy[3];
          }
          masPs[i] = StrToFloat(FloatToStrF(TestFunc(/*masy[0], masy[1], masy[2], masy[3]*/),ffFixed,7,UpDown1->Position));
          masFunc[0][i] = i;
          masFunc[1][i] = masPs[i];
          if (RMax->Checked) str = str+") = "+FloatToStrF(masPs[i],ffFixed,7,UpDown1->Position);
          else str = str+") = "+FloatToStrF(-masPs[i],ffFixed,7,UpDown1->Position);
          grid->Cells[0][i] = IntToStr(i+1)+".";
          grid->Cells[1][i] = str;
        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SortPop(int cnt)
{
        float temp;
        int i, j, k;
        for (i = 0; i < Pop; i++)
        {
          temp = masFunc[1][i];
          k = i;
          for (j = i-1; j >= 0 && masFunc[1][j] > temp; j--)
          {
            masFunc[1][j+1] = masFunc[1][j];
            masFunc[0][j+1] = masFunc[0][j];
          }
          masFunc[1][j+1] = temp;
          masFunc[0][j+1] = k;
        }
        k = cnt;

        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
       // for (int l = 0; l < Kol; ++l)
        //{
            //	a = FindDeg(l+1);
                for (i = Pop-1; i >= cnt; i--)
                {
                       //	for (j = a; j < 2*a; ++j)
                        //	masx[l][k][j] = masx[l][(int)masFunc[0][i]][j-a];
                  for (j = a; j < 2*a; j++)
                    masx1[k][j] = masx1[(int)masFunc[0][i]][j-a];
                  for (j = b; j < 2*b; j++)
                    masx2[k][j] = masx2[(int)masFunc[0][i]][j-b];
                  if (Kol > 2)
                  {
                    for (j = c; j < 2*c; j++)
                      masx3[k][j] = masx3[(int)masFunc[0][i]][j-c];
                  }
                  if (Kol > 3)
                  {
                    for (j = d; j < 2*d; j++)
                      masx4[k][j] = masx4[(int)masFunc[0][i]][j-d];
                  }
                  k++;
                }

                for (i = 0; i < Pop; i++)
                {
                  for (j = 0; j < a; j++)
                  {
                       //	masx[l][i][j] = masx[l][i][j+a];
                    masx1[i][j] = masx1[i][j+a];
                    masx2[i][j] = masx2[i][j+b];
                    if (Kol > 2) masx3[i][j] = masx3[i][j+c];
                    if (Kol > 3) masx4[i][j] = masx4[i][j+d];
                  }
                }
      //  }
}
//---------------------------------------------------------------------------
float __fastcall TForm1::FindNum(int i, int ab)
{
        int a;
        if (ab <= 4) a = 0;
        else
        {
          ab -= 4;
          a = FindDeg(ab);
        }
        float r = pow(10,UpDown1->Position)*(StrToFloat(GridMax->Cells[0][ab-1])-StrToFloat(GridMin->Cells[0][ab-1]))/(pow(2,FindDeg(ab))-1);
        r *= BToD(i, ab, a);
        r /= pow(10,UpDown1->Position);
        r += StrToFloat(GridMin->Cells[0][ab-1]);
        return r;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::BToD(int i, int ab, int a)
{
        int j, k = FindDeg(ab)+a, z, b;
        long c = 0;
        if (!CheckBox1->Checked)
        {
          for (j = k-1; j > -1+a; j--)
          {
            switch (ab)
            {
              case 1: c += masx1[i][j]*pow(2,k-1-j); break;
              case 2: c += masx2[i][j]*pow(2,k-1-j); break;
              case 3: c += masx3[i][j]*pow(2,k-1-j); break;
              case 4: c += masx4[i][j]*pow(2,k-1-j); break;
            }
            //c += masx[ab][i][j]*pow(2,k-1-j);
          }
        }
        else
        {
          for (j = a; j < k ; j++)
          {
            b = 0;
            for (z = a; z <= j; z++)
		//b = abs(b-masx[ab][i][z]);
              switch (ab)
              {
                case 1: b = abs(b-masx1[i][z]); break;
                case 2: b = abs(b-masx2[i][z]); break;
                case 3: b = abs(b-masx3[i][z]); break;
                case 4: b = abs(b-masx4[i][z]); break;
            }

            //c += b*pow(2,k-1-j);
            switch (ab)
            {
              case 1: c += b*pow(2,k-1-j); break;
              case 2: c += b*pow(2,k-1-j); break;
              case 3: c += b*pow(2,k-1-j); break;
              case 4: c += b*pow(2,k-1-j); break;
            }
          }
        }
        return c;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::OnePointCross()
{
        ListPopNew->Cols[0]->Clear();
        ListPopNew->Cols[1]->Clear();
        ListPopNew->RowCount = 1;
        ListPopNew->Cells[1][0] = "Скрещивание:";
        Randomize();
        int i, j, k = 0;
        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);

      //  for (int l = 0; l < Kol; ++l)
     //   {
     //		a = FindDeg(l+1);

                for (i = 0; i < Pop; i+=2)
                {
                  if (MyRandom(Ps))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i], 1);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i+1], 1);

                    /*masy[l] = random(a);
                    for (j = a; j <= (int)masy[l]+a; j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                    }

                    for (j; j < 2*a; j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i+1]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i]][j-a];
                    }*/
                    masy[0] = random(a);
                    for (j = a; j <= (int)masy[0]+a; j++)
                    {
                      masx1[k][j] = masx1[masNG[i]][j-a];
                      masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                    }
                    for (j; j < 2*a; j++)
                    {
                      masx1[k][j] = masx1[masNG[i+1]][j-a];
                      masx1[k+1][j] = masx1[masNG[i]][j-a];
                    }

                    masy[1] = random(b);
                    for (j = b; j <= (int)masy[1]+b; j++)
                    {
                      masx2[k][j] = masx2[masNG[i]][j-b];
                      masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                    }
                    for (j; j < 2*b; j++)
                    {
                      masx2[k][j] = masx2[masNG[i+1]][j-b];
                      masx2[k+1][j] = masx2[masNG[i]][j-b];
                    }

                    if (Kol > 2)
                    {
                      masy[2] = random(c);
                      for (j = c; j <= (int)masy[2]+c; j++)
                      {
                        masx3[k][j] = masx3[masNG[i]][j-c];
                        masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                      }
                      for (j; j < 2*c; j++)
                      {
                        masx3[k][j] = masx3[masNG[i+1]][j-c];
                        masx3[k+1][j] = masx3[masNG[i]][j-c];
                      }
                    }

                    if (Kol > 3)
                    {
                      masy[3] = random(d);
                      for (j = d; j <= (int)masy[2]+d; j++)
                      {
                        masx4[k][j] = masx4[masNG[i]][j-d];
                        masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                      }
                      for (j; j < 2*d; j++)
                      {
                        masx4[k][j] = masx4[masNG[i+1]][j-d];
                        masx4[k+1][j] = masx4[masNG[i]][j-d];
                      }
                    }

                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+1)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k, 5);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+2)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k+1, 5);
                    k += 2;
                  }
                }
       // }
        return k;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::TwoPointCross()
{
        ListPopNew->Cols[0]->Clear();
        ListPopNew->Cols[1]->Clear();
        ListPopNew->RowCount = 1;
        ListPopNew->Cells[1][0] = "Скрещивание:";
        Randomize();
        int i, j, k = 0;
        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
       // for (int l = 0; l < Kol; ++l)
       // {
      //  	a = FindDeg(l+1);

                for (i = 0; i < Pop; i+=2)
                {
                  if (MyRandom(Ps))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i], 1);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i+1], 1);

                    /*masy[0] = random(a);
                    masy[1] = random(a);
                    for (j = a; j <= min((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                    }
                    for (j; j <= max((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i+1]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i]][j-a];
                    }
                    for (j; j < 2*a; j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                    }*/

                    masy[0] = random(a);
                    masy[1] = random(a);
                    for (j = a; j <= min((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx1[k][j] = masx1[masNG[i]][j-a];
                      masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                    }
                    for (j; j <= max((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx1[k][j] = masx1[masNG[i+1]][j-a];
                      masx1[k+1][j] = masx1[masNG[i]][j-a];
                    }
                    for (j; j < 2*a; j++)
                    {
                      masx1[k][j] = masx1[masNG[i]][j-a];
                      masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                    }

                    masy[0] = random(b);
                    masy[1] = random(b);
                    for (j = b; j <= min((int)masy[0]+b, (int)masy[1]+b); j++)
                    {
                      masx2[k][j] = masx2[masNG[i]][j-b];
                      masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                    }
                    for (j; j <= max((int)masy[0]+b, (int)masy[1]+b); j++)
                    {
                      masx2[k][j] = masx2[masNG[i+1]][j-b];
                      masx2[k+1][j] = masx2[masNG[i]][j-b];
                    }
                    for (j; j < 2*b; j++)
                    {
                      masx2[k][j] = masx2[masNG[i]][j-b];
                      masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                    }

                    if (Kol > 2)
                    {
                      masy[0] = random(c);
                      masy[1] = random(c);
                      for (j = c; j <= min((int)masy[0]+c, (int)masy[1]+c); j++)
                      {
                        masx3[k][j] = masx3[masNG[i]][j-c];
                        masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                      }
                      for (j; j <= max((int)masy[0]+c, (int)masy[1]+c); j++)
                      {
                        masx3[k][j] = masx3[masNG[i+1]][j-c];
                        masx3[k+1][j] = masx3[masNG[i]][j-c];
                      }
                      for (j; j < 2*c; j++)
                      {
                        masx3[k][j] = masx3[masNG[i]][j-c];
                        masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                      }
                    }

                    if (Kol > 3)
                    {
                      masy[0] = random(d);
                      masy[1] = random(d);
                      for (j = d; j <= min((int)masy[0]+d, (int)masy[1]+d); j++)
                      {
                        masx4[k][j] = masx4[masNG[i]][j-d];
                        masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                      }
                      for (j; j <= max((int)masy[0]+d, (int)masy[1]+d); j++)
                      {
                        masx4[k][j] = masx4[masNG[i+1]][j-d];
                        masx4[k+1][j] = masx4[masNG[i]][j-d];
                      }
                      for (j; j < 2*d; j++)
                      {
                        masx4[k][j] = masx4[masNG[i]][j-d];
                        masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                      }
                    }

                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+1)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k, 5);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+2)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k+1, 5);
                    k += 2;
                  }
                }
        //}
        return k;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::UniCross()
{
        ListPopNew->Cols[0]->Clear();
        ListPopNew->Cols[1]->Clear();
        ListPopNew->RowCount = 1;
        ListPopNew->Cells[1][0] = "Скрещивание:";
        Randomize();
        int i, j, k = 0;
        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
        //for (int l = 0; l < Kol; ++l)
       // {
      //  	a = FindDeg(l+1);
                
                for (i = 0; i < Pop; i+=2)
                {
                  if (MyRandom(Ps))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i], 1);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i+1], 1);

               /*     for (j = a; j < 2*a; j++)
                    {
                      if (MyRandom(50))
                      {
                        masx[l][k][j] = masx[l][masNG[i]][j-a];
                        masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                      }
                      else
                      {
                        masx[l][k][j] = masx[l][masNG[i+1]][j-a];
                        masx[l][k+1][j] = masx[l][masNG[i]][j-a];
                      }
                    }   */

                    for (j = a; j < 2*a; j++)
                    {
                      if (MyRandom(50))
                      {
                        masx1[k][j] = masx1[masNG[i]][j-a];
                        masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                      }
                      else
                      {
                        masx1[k][j] = masx1[masNG[i+1]][j-a];
                        masx1[k+1][j] = masx1[masNG[i]][j-a];
                      }
                    }

                    for (j = b; j < 2*b; j++)
                    {
                      if (MyRandom(50))
                      {
                        masx2[k][j] = masx2[masNG[i]][j-b];
                        masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                      }
                      else
                      {
                        masx2[k][j] = masx2[masNG[i+1]][j-b];
                        masx2[k+1][j] = masx2[masNG[i]][j-b];
                      }
                    }

                    if (Kol > 2)
                    {
                      for (j = c; j < 2*c; j++)
                      {
                        if (MyRandom(50))
                        {
                          masx3[k][j] = masx3[masNG[i]][j-c];
                          masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                        }
                        else
                        {
                          masx3[k][j] = masx3[masNG[i+1]][j-c];
                          masx3[k+1][j] = masx3[masNG[i]][j-c];
                        }
                      }
                    }

                    if (Kol > 3)
                    {
                      for (j = d; j < 2*d; j++)
                      {
                        if (MyRandom(50))
                        {
                          masx4[k][j] = masx4[masNG[i]][j-d];
                          masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                        }
                        else
                        {
                          masx4[k][j] = masx4[masNG[i+1]][j-d];
                          masx4[k+1][j] = masx4[masNG[i]][j-d];
                        }
                      }
                    }

                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+1)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k, 5);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+2)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k+1, 5);
                    k += 2;
                  }
                }
        //}
        return k;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::CycleCross()
{
        ListPopNew->Cols[0]->Clear();
        ListPopNew->Cols[1]->Clear();
        ListPopNew->RowCount = 1;
        ListPopNew->Cells[1][0] = "Скрещивание:";
        Randomize();
        int i, j, k = 0;
        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
        //for (int l = 0; l < Kol; ++l)
       /// {
      //  	a = FindDeg(l+1);

                for (i = 0; i < Pop; i+=2)
                {
                  if (MyRandom(Ps))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i], 1);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Род. = "+MakeStr(masNG[i+1], 1);

                  /*  masy[0] = random(a);
                    masy[1] = masy[0]+a/2;
                    if ((int)masy[1] >= a) masy[1] -= a;
                    for (j = a; j <= min((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                    }
                    for (j; j <= max((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i+1]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i]][j-a];
                    }
                    for (j; j < 2*a; j++)
                    {
                      masx[l][k][j] = masx[l][masNG[i]][j-a];
                      masx[l][k+1][j] = masx[l][masNG[i+1]][j-a];
                    } */

                    masy[0] = random(a);
                    masy[1] = masy[0]+a/2;
                    if ((int)masy[1] >= a) masy[1] -= a;
                    for (j = a; j <= min((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx1[k][j] = masx1[masNG[i]][j-a];
                      masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                    }
                    for (j; j <= max((int)masy[0]+a, (int)masy[1]+a); j++)
                    {
                      masx1[k][j] = masx1[masNG[i+1]][j-a];
                      masx1[k+1][j] = masx1[masNG[i]][j-a];
                    }
                    for (j; j < 2*a; j++)
                    {
                      masx1[k][j] = masx1[masNG[i]][j-a];
                      masx1[k+1][j] = masx1[masNG[i+1]][j-a];
                    }

                    masy[0] = random(b);
                    masy[1] = masy[0]+b/2;
                    if ((int)masy[1] >= b) masy[1] -= b;
                    for (j = b; j <= min((int)masy[0]+b, (int)masy[1]+b); j++)
                    {
                      masx2[k][j] = masx2[masNG[i]][j-b];
                      masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                    }
                    for (j; j <= max((int)masy[0]+b, (int)masy[1]+b); j++)
                    {
                      masx2[k][j] = masx2[masNG[i+1]][j-b];
                      masx2[k+1][j] = masx2[masNG[i]][j-b];
                    }
                    for (j; j < 2*b; j++)
                    {
                      masx2[k][j] = masx2[masNG[i]][j-b];
                      masx2[k+1][j] = masx2[masNG[i+1]][j-b];
                    }

                    if (Kol > 2)
                    {
                      masy[0] = random(c);
                      masy[1] = masy[0]+c/2;
                      if ((int)masy[1] >= c) masy[1] -= c;
                      for (j = c; j <= min((int)masy[0]+c, (int)masy[1]+c); j++)
                      {
                        masx3[k][j] = masx3[masNG[i]][j-c];
                        masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                      }
                      for (j; j <= max((int)masy[0]+c, (int)masy[1]+c); j++)
                      {
                        masx3[k][j] = masx3[masNG[i+1]][j-c];
                        masx3[k+1][j] = masx3[masNG[i]][j-c];
                      }
                      for (j; j < 2*c; j++)
                      {
                        masx3[k][j] = masx3[masNG[i]][j-c];
                        masx3[k+1][j] = masx3[masNG[i+1]][j-c];
                      }
                    }

                    if (Kol > 3)
                    {
                      masy[0] = random(d);
                      masy[1] = masy[0]+d/2;
                      if ((int)masy[1] >= d) masy[1] -= d;
                      for (j = d; j <= min((int)masy[0]+d, (int)masy[1]+d); j++)
                      {
                        masx4[k][j] = masx4[masNG[i]][j-d];
                        masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                      }
                      for (j; j <= max((int)masy[0]+d, (int)masy[1]+d); j++)
                      {
                        masx4[k][j] = masx4[masNG[i+1]][j-d];
                        masx4[k+1][j] = masx4[masNG[i]][j-d];
                      }
                      for (j; j < 2*d; j++)
                      {
                        masx4[k][j] = masx4[masNG[i]][j-d];
                        masx4[k+1][j] = masx4[masNG[i+1]][j-d];
                      }
                    }

                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+1)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k, 5);
                    ListPopNew->RowCount +=1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(k+2)+".";
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Пот. = "+MakeStr(k+1, 5);
                    k += 2;
                  }
                }
       // }
        return k;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Reproduction()
{
        NG++;
        NGen->Caption = NG;
        int k;
        FillListPop(ListPop);

        if (RadioButton1->Checked) RollSelect();
        else if (RadioButton2->Checked) TourSelect();
        else if (RadioButton3->Checked) UniSelect();

        if (RadioButton4->Checked) k = OnePointCross();
        else if (RadioButton5->Checked) k = TwoPointCross();
        else if (RadioButton6->Checked) k = CycleCross();
        else if (RadioButton7->Checked) k = UniCross();

        if (RadioButton10->Checked) InversMutation(k);
        else if (RadioButton11->Checked) ExchangeMutation(k);
        else if (RadioButton12->Checked) TransMutation(k);
        else if (RadioButton8->Checked) InsertMutation(k);

        SortPop(k);

        FillListPop(NextListPop);

        AnsiString str = NextListPop->Cells[1][NextListPop->RowCount-1];
        int i = 1;
        while (1)
        {
          k = str.SubString(i, str.Length()).Pos("-");
          if (k != 0)
          {
            str = str.SubString(1, k+i-2)+"–"+str.SubString(k+i, str.Length());
            i += k;
          }
          else break;
        }
        Answ->Text = str;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::InversMutation(int cnt)
{       // инверсия
        ListPopNew->RowCount += 1;
        ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Мутация:";
        Randomize();
        int i;
        int a, b, c, d;
        a = FindDeg(1);
        b = FindDeg(2);
        AnsiString str;
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
       // for (int l = 0; l < Kol; ++l)
       // {
        //	a = FindDeg(l+1);

                for (i = 0; i < cnt; i++)
                {
                  if (MyRandom(Pm))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(i+1)+".";
                    str = MakeStr(i, 5)+" => ";

                   /* masy[l] = random(a);
                    masx[l][i][(int)masy[0]+a] = !masx[l][i][(int)masy[0]+a]; */

                    masy[0] = random(a);
                    masx1[i][(int)masy[0]+a] = !masx1[i][(int)masy[0]+a];

                    masy[1] = random(b);
                    masx2[i][(int)masy[1]+b] = !masx2[i][(int)masy[1]+b];

                    if (Kol > 2)
                    {
                      masy[2] = random(c);
                      masx3[i][(int)masy[2]+c] = !masx3[i][(int)masy[2]+c];
                    }

                    if (Kol > 3)
                    {
                      masy[3] = random(d);
                      masx4[i][(int)masy[3]+d] = !masx4[i][(int)masy[3]+d];
                    }

                    str = str+MakeStr(i, 5);
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = str;
                  }
                }
       // }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ExchangeMutation(int cnt)
{       // перестановка
        ListPopNew->RowCount += 1;
        ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Мутация:";
        Randomize();
        int i;
        int a, b, c, d;
        bool tmp;
        a = FindDeg(1);
        b = FindDeg(2);
        AnsiString str;
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
        //for (int l = 0; l < Kol; ++l)
       // {
       // 	a = FindDeg(l+1);

                for (i = 0; i < cnt; i++)
                {
                  if (MyRandom(Pm))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(i+1)+".";
                    str = MakeStr(i, 5)+" => ";

                   /* masy[0] = random(a);
                    masy[1] = random(a);
                    tmp = masx[l][i][(int)masy[0]+a];
                    masx[l][i][(int)masy[0]+a] = masx[l][i][(int)masy[1]+a];
                    masx[l][i][(int)masy[1]+a] = tmp;   */

                    masy[0] = random(a);
                    masy[1] = random(a);
                    tmp = masx1[i][(int)masy[0]+a];
                    masx1[i][(int)masy[0]+a] = masx1[i][(int)masy[1]+a];
                    masx1[i][(int)masy[1]+a] = tmp;

                    masy[0] = random(b);
                    masy[1] = random(b);
                    tmp = masx2[i][(int)masy[0]+b];
                    masx2[i][(int)masy[0]+b] = masx2[i][(int)masy[1]+b];
                    masx2[i][(int)masy[1]+b] = tmp;

                    if (Kol > 2)
                    {
                      masy[0] = random(c);
                      masy[1] = random(c);
                      tmp = masx3[i][(int)masy[0]+c];
                      masx3[i][(int)masy[0]+c] = masx3[i][(int)masy[1]+c];
                      masx3[i][(int)masy[1]+c] = tmp;
                    }

                    if (Kol > 3)
                    {
                      masy[0] = random(d);
                      masy[1] = random(d);
                      tmp = masx4[i][(int)masy[0]+d];
                      masx4[i][(int)masy[0]+d] = masx4[i][(int)masy[1]+d];
                      masx4[i][(int)masy[1]+d] = tmp;
                    }

                    str = str+MakeStr(i, 5);
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = str;
                  }
                }
        //}
}
//---------------------------------------------------------------------------
void __fastcall TForm1::TransMutation(int cnt)
{       // транслокация
        ListPopNew->RowCount += 1;
        ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Мутация:";
        Randomize();
        int i, j;
        int a, b, c, d;
        bool tmp;
        a = FindDeg(1);
        b = FindDeg(2);
        AnsiString str;
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
        //for (int l = 0; l < Kol; ++l)
        //{
           //	a = FindDeg(l+1);
                for (i = 0; i < cnt; i++)
                {
                  if (MyRandom(Pm))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(i+1)+".";
                    str = MakeStr(i, 5)+" => ";

                  /*  masy[0] = random(a);
                    masy[1] = random(a);
                    if (masy[0] <= masy[1])
                    {
                      j = a+(int)masy[0];
                      tmp = masx[l][i][j];
                      for (j; j< a+(int)masy[1]; j++ )
                        masx[l][i][j] = masx[l][i][j+1];
                      masx[l][i][j] = tmp;
                    }
                    else
                    {
                      j = a+(int)masy[1];
                      tmp = masx[l][i][j];
                      for (j; j> a+(int)masy[0]; j-- )
                        masx[l][i][j] = masx[l][i][j-1];
                      masx[l][i][j] = tmp;
                    }  */

                    masy[0] = random(a);
                    masy[1] = random(a);
                    if (masy[0] <= masy[1])
                    {
                      j = a+(int)masy[0];
                      tmp = masx1[i][j];
                      for (j; j< a+(int)masy[1]; j++ )
                        masx1[i][j] = masx1[i][j+1];
                      masx1[i][j] = tmp;
                    }
                    else
                    {
                      j = a+(int)masy[1];
                      tmp = masx1[i][j];
                      for (j; j> a+(int)masy[0]; j-- )
                        masx1[i][j] = masx1[i][j-1];
                      masx1[i][j] = tmp;
                    }


                    masy[0] = random(b);
                    masy[1] = random(b);
                    if (masy[0] <= masy[1])
                    {
                      j = b+(int)masy[0];
                      tmp = masx2[i][j];
                      for (j; j< b+(int)masy[1]; j++ )
                        masx2[i][j] = masx2[i][j+1];
                      masx2[i][j] = tmp;
                    }
                    else
                    {
                      j = b+(int)masy[1];
                      tmp = masx2[i][j];
                      for (j; j> b+(int)masy[0]; j-- )
                        masx2[i][j] = masx2[i][j-1];
                      masx2[i][j] = tmp;
                    }

                    if (Kol > 2)
                    {
                      masy[0] = random(c);
                      masy[1] = random(c);
                      if (masy[0] <= masy[1])
                      {
                        j = c+(int)masy[0];
                        tmp = masx3[i][j];
                        for (j; j< c+(int)masy[1]; j++ )
                          masx3[i][j] = masx3[i][j+1];
                        masx3[i][j] = tmp;
                      }
                      else
                      {
                        j = c+(int)masy[1];
                        tmp = masx3[i][j];
                        for (j; j> c+(int)masy[0]; j-- )
                          masx3[i][j] = masx3[i][j-1];
                        masx3[i][j] = tmp;
                      }
                    }

                    if (Kol > 3)
                    {
                      masy[0] = random(d);
                      masy[1] = random(d);
                      if (masy[0] <= masy[1])
                      {
                        j = d+(int)masy[0];
                        tmp = masx4[i][j];
                        for (j; j< d+(int)masy[1]; j++ )
                          masx4[i][j] = masx4[i][j+1];
                        masx4[i][j] = tmp;
                      }
                      else
                      {
                        j = d+(int)masy[1];
                        tmp = masx4[i][j];
                        for (j; j> d+(int)masy[0]; j-- )
                          masx4[i][j] = masx4[i][j-1];
                        masx4[i][j] = tmp;
                      }
                    }

                    str = str+MakeStr(i, 5);
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = str;
                  }
                }
       // }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TForm1::MakeStr(int i, int ab)
{
        AnsiString str = FloatToStrF(FindNum(i, ab),ffFixed,7,UpDown1->Position);
        int j;
        for (j = 1; j < Kol; j++)
        {
          str = str+"; ";
          str = str+FloatToStrF(FindNum(i, ab+j),ffFixed,7,UpDown1->Position);
        }
        return str;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::RollSelect()
{       // 1 Ok
        int i;
        ConstructPs();
        for (i = 0; i < Pop; i++)
          masNG[i] = FindParent();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::UniSelect()
{       // 3 Ok
        int i;
        for (i = 0; i < Pop; i++)
        {
          ConstructPs();
          masNG[i] = FindParent();
          masPs[masNG[i]] -= (int)masPs[masNG[i]];
        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::TourSelect()
{       // 2 Ok
        Randomize();
        int i, a, b, c, k;
        float max;
        for (i = 0; i < Pop; i++)
        {
          a = random(Pop);
          b = random(Pop);
          c = random(Pop);
          k = a;
          max = masPs[a];
          if (masPs[b] > max)
          {
            max = masPs[b];
            k = b;
          }
          if (masPs[c] > max)
          {
            max = masPs[c];
            k = c;
          }
          masNG[i] = k;
        }
}
//---------------------------------------------------------------------------
int __fastcall TForm1::FindParent()
{
        Randomize();
        int i, k = 0, x;
        double sum = 0;
        x = random(101);
        for (i = 0; i < Pop-1; i++)
        {
          sum += masPs[i];
          if (x > sum)
            k = i+1;
        }
        return k;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ConstructPs()
{
        int i;
        double sum = 0;
        for (i = 0; i < Pop; i++)
          //sum += masPs[i];
          sum += fabs(masPs[i]);

        if (sum < 1e-20)
        	masPs[rand() % Pop] = 100;
        else
        {
        for (i = 0; i < Pop; i++)
          masPs[i] *= (100/sum);
        }
}
//---------------------------------------------------------------------------
bool __fastcall TForm1::MyRandom(int b)
{
        Randomize();
        int a = random(101);
        if (a <= b) return 1;
        return 0;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
        if (tT < T)
        {
          Reproduction();
          tT++;
        }
        else
        {
          Timer1->Enabled = false;
          SpeedButton5->Caption = buttonCapt[Timer1->Enabled];
        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SpeedButton5Click(TObject *Sender)
{
        Timer1->Enabled = !Timer1->Enabled;
        SpeedButton5->Caption = buttonCapt[Timer1->Enabled];
        tT = 0;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SpeedButton2Click(TObject *Sender)
{
        Reproduction();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::UpDown5Click(TObject *Sender, TUDBtnType Button)
{
        /*AnsiString str = CurDir+"\\Examples\\Ex"+IntToStr(UpDown5->Position)+".bmp";
        Image7->Picture->LoadFromFile(str);
        int tmp = UpDown5->Position;
        switch(tmp)
          {
          case 1: Kol = 2;
                  ParamsCreate();
                  break;
          case 2: Kol = 2;
                  ParamsCreate();
                  break;
          case 3: Kol = 2;
                  ParamsCreate();
                  break;
          case 4: Kol = 3;
                  ParamsCreate();
                  break;
          case 5: Kol = 2;
                  ParamsCreate();
                  break;
          case 6: Kol = 2;
                  ParamsCreate();
                  break;
          case 7: Kol = 2;
                  ParamsCreate();
                  break;
          case 8: Kol = 3;
                  ParamsCreate();
                  break;
          case 9: Kol = 4;
                  ParamsCreate();
                  break;
          }  */
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Edit1KeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
        if (Key == VK_RETURN) UpDown5Click(Sender, btNext);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::PageControl1Change(TObject *Sender)
{
        if (PageControl1->ActivePage == TabSheet2)
        {
          if (Button1->Enabled)
          {
            PageControl1->ActivePage = TabSheet1;
            return;
          }
          if (TestValues())
            PageControl1->ActivePage = TabSheet1;
        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SwitchEnable()
{
        Button1->Enabled = !Button1->Enabled;
        UpDown1->Enabled = !UpDown1->Enabled;
        UpDown4->Enabled = !UpDown4->Enabled;
        //UpDown5->Enabled = !UpDown5->Enabled;
        CheckBox1->Enabled = !CheckBox1->Enabled;
        GridPop->Enabled = !GridPop->Enabled;
        //Edit1->Enabled = !Edit1->Enabled;
        GridMin->Enabled = !GridMin->Enabled;
        GridMax->Enabled = !GridMax->Enabled;
        cbFunc->Enabled ^= true;
        edVarNames->Enabled ^= true;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ChangeParam()
{
        Button1->Enabled = !Button1->Enabled;
        UpDown1->Enabled = !UpDown1->Enabled;
        UpDown4->Enabled = !UpDown4->Enabled;
        CheckBox1->Enabled = !CheckBox1->Enabled;
        GridPop->Enabled = !GridPop->Enabled;
        GridMin->Enabled = !GridMin->Enabled;
        GridMax->Enabled = !GridMax->Enabled;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SpeedButton3Click(TObject *Sender)
{
        if (GridMin->Enabled)
        {
          // Edit1->Enabled = true;
          // UpDown5->Enabled = true;
           cbFunc->Enabled = true;
           edVarNames->Enabled = false;
        }
        else SwitchEnable();
        SpeedButton4->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Panel3Click(TObject *Sender)
{
        ShellExecute(Handle, "open", (CurDir+"\\Examples\\Index.html").c_str(), NULL, NULL, SW_NORMAL);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SpeedButton4Click(TObject *Sender)
{
        ChangeParam();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnParserBriefHelpClick(TObject *Sender)
{
	fmParserBriefHelp->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::cbFuncChange(TObject *Sender)
{
	switch (cbFunc->ItemIndex)
        {
        case 0: case 1: case 2: case 3: case 5: case 6: case 7:
        	edVarNames->Text = "x;y";
        	break;
        case 4: case 8:
        	edVarNames->Text = "x;y;z";
        	break;
        case 9:
        	edVarNames->Text = "x;y;z;t";
        	break;
        }
}
//---------------------------------------------------------------------------


void __fastcall TForm1::FormDestroy(TObject *Sender)
{
	delete parser;
}
//---------------------------------------------------------------------------

unsigned __fastcall TForm1::ParseVarNames()
{
	AnsiString s = edVarNames->Text;
        unsigned count = 0;
        vars.clear();

        while (s != EmptyStr)
        {
        	int pos = s.Pos(";");
                AnsiString p = ((pos > 0) ? s.SubString(1, pos-1) : s).Trim();

                if (p == EmptyStr)
                	throw Exception("Ошибка в перечислении имен переменных.");

                vars[p.c_str()] = 0.0;
                names.push_back(p.c_str());
                s = (pos > 0) ? s.Delete(1, pos) : EmptyStr;
                ++count;
        }

        return count;
}
void __fastcall TForm1::edVarNamesExit(TObject *Sender)
{
	Kol = ParseVarNames();
        ParamsCreate();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::GridMinClick(TObject *Sender)
{
	Kol = ParseVarNames();
        ParamsCreate();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::GridTextClick(TObject *Sender)
{
	Kol = ParseVarNames();
        ParamsCreate();	
}
//---------------------------------------------------------------------------

void __fastcall TForm1::GridMaxClick(TObject *Sender)
{
	Kol = ParseVarNames();
        ParamsCreate();	
}
//---------------------------------------------------------------------------


void __fastcall TForm1::InsertMutation(int cnt)
{
        ListPopNew->RowCount += 1;
        ListPopNew->Cells[1][ListPopNew->RowCount-1] = "Мутация:";
        Randomize();
        int i;
        int a, b, c, d;
        bool tmp, to_insert;
        vector<bool> v;
        a = FindDeg(1);
        b = FindDeg(2);
        AnsiString str;
        if (Kol > 2) c = FindDeg(3);
        if (Kol > 3) d = FindDeg(4);
        //for (int l = 0; l < Kol; ++l)
       // {
       // 	a = FindDeg(l+1);

                for (i = 0; i < cnt; i++)
                {
                  if (MyRandom(Pm))
                  {
                    ListPopNew->RowCount += 1;
                    ListPopNew->Cells[0][ListPopNew->RowCount-1] = IntToStr(i+1)+".";
                    str = MakeStr(i, 5)+" => ";

                    v.resize(2*a);
                    masy[0] = random(a);  //здесь вставляется
                    masy[1] = random(a);  // здесь удаляется
                    for (int l = 0; l < v.size(); ++l)
                    	v[l] = masx1[i][l];
                    v.insert(v.begin() + (int)masy[0]+a, random(1));
                    v.erase(v.begin() + (int)masy[1]+a);
                    for (int l = 0; l < v.size(); ++l)
                    	masx1[i][l] = v[l];

                    v.resize(2*b);
                    masy[0] = random(b);  //здесь вставляется
                    masy[1] = random(b);  // здесь удаляется 
                    for (int l = 0; l < v.size(); ++l)
                    	v[l] = masx2[i][l];
                    v.insert(v.begin() + (int)masy[0]+b, random(1));
                    v.erase(v.begin() + (int)masy[1]+b);
                    for (int l = 0; l < v.size(); ++l)
                    	masx2[i][l] = v[l];

                    if (Kol > 2)
                    {
                            v.resize(2*c);
                            masy[0] = random(c);  //здесь вставляется
                            masy[1] = random(c);  // здесь удаляется
                            for (int l = 0; l < v.size(); ++l)
                                v[l] = masx3[i][l];
                            v.insert(v.begin() + (int)masy[0]+c, random(1));
                            v.erase(v.begin() + (int)masy[1]+c);
                            for (int l = 0; l < v.size(); ++l)
                                masx3[i][l] = v[l];
                    }

                    if (Kol > 3)
                    {
                            v.resize(2*d);
                            masy[0] = random(d);  //здесь вставляется
                            masy[1] = random(d);  // здесь удаляется
                            for (int l = 0; l < v.size(); ++l)
                                v[l] = masx4[i][l];
                            v.insert(v.begin() + (int)masy[0]+d, random(1));
                            v.erase(v.begin() + (int)masy[1]+d);
                            for (int l = 0; l < v.size(); ++l)
                                masx4[i][l] = v[l];
                    }

                    str = str+MakeStr(i, 5);
                    ListPopNew->Cells[1][ListPopNew->RowCount-1] = str;
                  }
                }
        //}
}
