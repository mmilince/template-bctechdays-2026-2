page 50120 "BCT Loan Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BCT Loan Setup";
    Caption = 'Loan Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';

                field("BCT Loan Nos."; Rec."BCT Loan Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign numbers to loan headers.';
                }
                field("BCT Vehicle Nos."; Rec."BCT Vehicle Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign numbers to vehicles.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetRecordOnce();
    end;
}
