table 50101 "BCT Loan Header"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Header';
    LookupPageId = "BCT Loan Orders";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                Contact.Get(Rec."Contact No.");

                Rec."Contact Name" := Contact.Name;
                Rec."Contact E-Mail" := Contact."E-Mail";
            end;
        }
        field(3; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            TableRelation = Contact.Name;
            Editable = false;
        }
        field(4; "Contact E-Mail"; Text[80])
        {
            Caption = 'Contact E-Mail';
            TableRelation = Contact."E-Mail";
            Editable = false;
        }
        field(5; "Status"; Enum "BCT Loan Status")
        {
            Caption = 'Loan Status';
            Editable = false;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Loan Start Date';

            trigger OnValidate()
            var
                IncorrectDateErr: Label 'End Date cannot be before Start Date.';
            begin
                if Rec."End Date" = 0D then
                    exit;

                if Rec."End Date" < Rec."Start Date" then
                    Error(IncorrectDateErr);
            end;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'Loan End Date';

            trigger OnValidate()
            var
                IncorrectDateErr: Label 'End Date cannot be before Start Date.';
            begin
                if Rec."End Date" < Rec."Start Date" then
                    Error(IncorrectDateErr);
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        LoanSetup: Record "BCT Loan Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." <> '' then
            exit;

        LoanSetup.GetRecordOnce();
        if LoanSetup."BCT Loan Nos." = '' then
            exit;

        Rec."No." := NoSeries.GetNextNo(LoanSetup."BCT Loan Nos.", WorkDate());
    end;

    trigger OnDelete()
    var
        LoanLine: Record "BCT Loan Line";
    begin
        LoanLine.SetRange("Document No.", Rec."No.");
        LoanLine.DeleteAll(true);
    end;
}