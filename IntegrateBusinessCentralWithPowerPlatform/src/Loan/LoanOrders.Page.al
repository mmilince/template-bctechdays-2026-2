page 50102 "BCT Loan Orders"
{
    PageType = List;
    Caption = 'Loan Orders';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BCT Loan Header";
    CardPageId = "BCT Loan Order";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the loan order.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the contact the vehicles are loaned to.';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the contact the vehicles are loaned to.';
                }
                field("Contact E-Mail"; Rec."Contact E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address of the contact the vehicles are loaned to.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the loan.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the loan starts.';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the loan ends.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Loan)
            {
                Caption = 'Loan';
                Image = ReleaseDoc;
                ToolTip = 'Loans the vehicles on this order and sets the status to Loaned.';

                trigger OnAction()
                var
                    LoanMgt: Codeunit "BCT Loan Mgt.";
                begin
                    LoanMgt.Loan(Rec);
                end;

            }

            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                ToolTip = 'Reopens the loan order and frees the vehicles.';
                Enabled = Rec.Status <> Rec.Status::Open;

                trigger OnAction()
                var
                    LoanMgt: Codeunit "BCT Loan Mgt.";
                begin
                    LoanMgt.Reopen(Rec);
                end;
            }

            action(Return)
            {
                Caption = 'Return';
                Image = Post;
                ToolTip = 'Returns the loaned vehicles and archives the loan.';
                Enabled = Rec.Status = Rec.Status::Loaned;

                trigger OnAction()
                var
                    LoanReturn: Codeunit "BCT Loan Return";
                begin
                    LoanReturn.Return(Rec);
                end;

            }
        }
    }
}