//---------------------------------------------------------------------------

#ifndef Unit2H
#define Unit2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TfmParserBriefHelp : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
private:	// User declarations
public:		// User declarations
	__fastcall TfmParserBriefHelp(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmParserBriefHelp *fmParserBriefHelp;
//---------------------------------------------------------------------------
#endif
