page 50103 "BCT Loan Order"
{
    PageType = Card;
    Caption = 'Loan Order';
    ApplicationArea = All;
    SourceTable = "BCT Loan Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the loan order.';

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit() then
                            CurrPage.Update();
                    end;
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
                    Editable = false;
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
            part(LoanLines; "BCT Loan Lines")
            {
                SubPageLink = "Document No." = field("No.");
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

    local procedure AssistEdit(): Boolean
    var
        LoanSetup: Record "BCT Loan Setup";
        NoSeries: Codeunit "No. Series";
        NewNoSeriesCode: Code[20];
    begin
        LoanSetup.GetRecordOnce();
        if NoSeries.LookupRelatedNoSeries(LoanSetup."BCT Loan Nos.", LoanSetup."BCT Loan Nos.", NewNoSeriesCode) then begin
            Rec."No." := NoSeries.GetNextNo(NewNoSeriesCode, WorkDate());
            exit(true);
        end;
    end;
}