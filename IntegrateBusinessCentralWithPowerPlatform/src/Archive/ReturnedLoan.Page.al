page 50106 "BCT Returned Loan"
{
    PageType = Card;
    Caption = 'Returned Loan';
    ApplicationArea = All;
    SourceTable = "BCT Returned Loan Header";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the returned loan.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the contact the vehicles were loaned to.';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the contact the vehicles were loaned to.';
                }
                field("Contact E-Mail"; Rec."Contact E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address of the contact the vehicles were loaned to.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the loan.';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the loan started.';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the loan ended.';
                }
            }
            part(ReturnedLoanLines; "BCT Returned Loan Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
}