table 50107 "BCT Loan Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "BCT Loan Nos."; Code[20])
        {
            Caption = 'Loan Nos.';
            TableRelation = "No. Series";
        }
        field(3; "BCT Vehicle Nos."; Code[20])
        {
            Caption = 'Vehicle Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetRecordOnce()
    begin
        if Rec.Get() then
            exit;

        InitSetup();
    end;

    local procedure InitSetup()
    begin
        Rec.Init();
        Rec."Primary Key" := '';
        if not Rec.Insert() then
            Rec.Get();
    end;
}
