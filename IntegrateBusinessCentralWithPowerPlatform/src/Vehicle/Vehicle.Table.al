table 50100 "BCT Vehicle"
{
    DataClassification = CustomerContent;
    DrillDownPageID = "BCT Vehicle List";
    LookupPageId = "BCT Vehicle Card";
    Caption = 'Vehicle';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Type"; Enum "BCT Vehicle Type")
        {
            Caption = 'Type';
        }
        field(3; "Make"; Text[100])
        {
            Caption = 'Make';
        }
        field(4; "Model"; Text[100])
        {
            Caption = 'Model';
        }
        field(5; "Manufacturing Year"; Integer)
        {
            Caption = 'Manufacturing Year';
            MinValue = 1990;

            trigger OnValidate()
            var
                FutureYearErr: Label 'Cannot set year in future.';
            begin
                if Date2DMY(Today, 3) < Rec."Manufacturing Year" then
                    Error(FutureYearErr);
            end;
        }
        field(6; "Fuel Type"; Enum "BCT Fuel Type")
        {
            Caption = 'Fuel Type';
        }
        field(7; "Mileage"; Integer)
        {
            Caption = 'Mileage in km';
        }
        field(8; "License Plate"; Code[20])
        {
            Caption = 'License Plate';
        }
        field(9; "Loaned"; Boolean)
        {
            Caption = 'Loaned';
            Editable = false;
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
        if LoanSetup."BCT Vehicle Nos." = '' then
            exit;

        Rec."No." := NoSeries.GetNextNo(LoanSetup."BCT Vehicle Nos.", WorkDate());
    end;
}