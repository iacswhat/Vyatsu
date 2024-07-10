//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
#include <ComCtrls.hpp>
#include <ImgList.hpp>
#include <ExtCtrls.hpp>
#include "SHDocVw_OCX.h"
#include <OleCtrls.hpp>
#include <Graphics.hpp>

#include "Parser.h"

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TPageControl *PageControl1;
        TTabSheet *TabSheet1;
        TTabSheet *TabSheet2;
        TTabSheet *TabSheet3;
        TBevel *Bevel1;
        TBevel *Bevel2;
        TBevel *Bevel3;
        TCppWebBrowser *CppWebBrowser1;
        TStringGrid *GridMin;
        TButton *Button1;
        TStringGrid *GridMax;
        TStringGrid *GridText;
        TGroupBox *GroupBox1;
        TLabel *Label2;
        TUpDown *UpDown1;
        TLabel *Label1;
        TLabel *Label4;
        TGroupBox *GroupBox2;
        TRadioButton *RadioButton1;
        TLabel *Label3;
        TLabel *Label5;
        TRadioButton *RadioButton2;
        TLabel *Label6;
        TRadioButton *RadioButton3;
        TGroupBox *GroupBox3;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TRadioButton *RadioButton4;
        TRadioButton *RadioButton5;
        TRadioButton *RadioButton6;
        TRadioButton *RadioButton7;
        TLabel *Label10;
        TGroupBox *GroupBox4;
        TLabel *Label13;
        TLabel *Label14;
        TLabel *Label15;
        TRadioButton *RadioButton10;
        TRadioButton *RadioButton11;
        TRadioButton *RadioButton12;
        TGroupBox *GroupBox5;
        TLabel *Label16;
        TEdit *VerM;
        TUpDown *UpDown2;
        TLabel *Label20;
        TLabel *Label21;
        TEdit *VerC;
        TUpDown *UpDown3;
        TLabel *Label22;
        TGroupBox *GroupBox6;
        TEdit *GridPop;
        TUpDown *UpDown4;
        TSpeedButton *SpeedButton1;
        TEdit *GridKol;
        TSpeedButton *SpeedButton2;
        TStringGrid *ListPop;
        TPanel *Panel1;
        TGroupBox *GroupBox7;
        TLabel *Label25;
        TLabel *Label26;
        TRadioButton *RMax;
        TRadioButton *RMin;
        TTimer *Timer1;
        TSpeedButton *SpeedButton5;
        TStringGrid *ListPopNew;
        TStringGrid *NextListPop;
        TEdit *TimeEdit;
        TGroupBox *GroupBox8;
        TPanel *Panel2;
        TLabel *Label24;
        TLabel *Label12;
        TLabel *Label11;
        TLabel *Label23;
        TCheckBox *CheckBox1;
        TLabel *Label18;
        TLabel *Label27;
        TLabel *Label29;
        TLabel *TestLabel;
        TLabel *Label30;
        TLabel *NGen;
        TLabel *Label32;
        TSpeedButton *SpeedButton3;
        TPanel *Panel3;
        TEdit *Answ;
        TSpeedButton *SpeedButton4;
	TLabel *Label17;
	TComboBox *cbFunc;
	TButton *btnParserBriefHelp;
	TEdit *edVarNames;
	TLabel *Label19;
	TRadioButton *RadioButton8;
	TLabel *Label28;
        void __fastcall FormCreate(TObject *Sender);
        bool __fastcall TestValues();
        int __fastcall FindDeg(int ab);
        void __fastcall ParamsCreate();
        void __fastcall ClearAll();
        void __fastcall FillPop();
        void __fastcall AllocMem();
        int __fastcall OnePointCross();
        void __fastcall RollSelect();
        void __fastcall TourSelect();
        int __fastcall FindParent();
        bool __fastcall MyRandom(int b);
        void __fastcall ConstructPs();
        void __fastcall UniSelect();
        int __fastcall UniCross();
        void __fastcall SortPop(int cnt);
        int __fastcall TwoPointCross();
        void __fastcall ChangeParam();
        int __fastcall CycleCross();
        float __fastcall TestFunc(/*float x, float y, float z, float t*/);
        void __fastcall FillListPop(TStringGrid* grid);
        void __fastcall ExchangeMutation(int cnt);
        void __fastcall TransMutation(int cnt);
        void __fastcall Reproduction();
        void __fastcall SwitchEnable();
        float __fastcall FindNum(int i, int ab);
        int __fastcall BToD(int i, int ab, int a);
        AnsiString __fastcall MakeStr(int i, int ab);
        void __fastcall InversMutation(int cnt);
        void __fastcall GridCreate(TStringGrid *grid);
        void __fastcall GridMinKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall GridMaxKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall UpDown1Click(TObject *Sender, TUDBtnType Button);
        void __fastcall SpeedButton1Click(TObject *Sender);
        void __fastcall GridKolClick(TObject *Sender);
        void __fastcall GridKolKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall SpeedButton5Click(TObject *Sender);
        void __fastcall SpeedButton2Click(TObject *Sender);
        void __fastcall UpDown5Click(TObject *Sender, TUDBtnType Button);
        void __fastcall Edit1KeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall PageControl1Change(TObject *Sender);
        void __fastcall SpeedButton3Click(TObject *Sender);
        void __fastcall Panel3Click(TObject *Sender);
        void __fastcall SpeedButton4Click(TObject *Sender);
	void __fastcall btnParserBriefHelpClick(TObject *Sender);
	void __fastcall cbFuncChange(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall edVarNamesExit(TObject *Sender);
	void __fastcall GridMinClick(TObject *Sender);
	void __fastcall GridTextClick(TObject *Sender);
	void __fastcall GridMaxClick(TObject *Sender);
private:	// User declarations
        Parser *parser;
        map<string, double> vars;
        vector<string> names;
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
	unsigned __fastcall ParseVarNames();
	void __fastcall InsertMutation(int k);
        //AnsiString __fastcall DToB(int c);
        //AnsiString __fastcall BToG(AnsiString c);
        //AnsiString __fastcall CInverse(AnsiString c);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
