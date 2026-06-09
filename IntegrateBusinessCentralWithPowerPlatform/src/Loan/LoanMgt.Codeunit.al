codeunit 50100 "BCT Loan Mgt."
{
    internal procedure Loan(LoanHeader: Record "BCT Loan Header")
    var
        LoanLine: Record "BCT Loan Line";
        LoanEvents: Codeunit "BCT Loan Events";
    begin
        if LoanHeader.Status <> LoanHeader.Status::Open then
            exit;

        LoanHeader.TestField("Contact No.");
        LoanHeader.TestField("Start Date");
        LoanHeader.TestField("End Date");

        LoanLine.SetRange("Document No.", LoanHeader."No.");
        LoanLine.FindSet();

        repeat
            ChangeVehicleStatusToLoan(LoanLine."Vehicle No.");
            LoanEvents.OnAfterLoanVehicle(LoanLine);
        until LoanLine.Next() = 0;

        LoanHeader.Status := LoanHeader.Status::Loaned;
        LoanHeader.Modify();
    end;

    internal procedure Reopen(LoanHeader: Record "BCT Loan Header")
    var
        LoanLine: Record "BCT Loan Line";
    begin
        LoanHeader.Status := LoanHeader.Status::Open;
        LoanHeader.Modify();

        LoanLine.SetRange("Document No.", LoanHeader."No.");
        LoanLine.FindSet();

        repeat
            ChangeVehicleStatusToFree(LoanLine."Vehicle No.");
        until LoanLine.Next() = 0;
    end;

    internal procedure ChangeVehicleStatusToLoan(VehicleCode: Code[20])
    var
        Vehicle: Record "BCT Vehicle";
        LoanedVehicleErr: Label 'Vehicle %1 is already loaned.';
    begin
        Vehicle.Get(VehicleCode);

        if Vehicle.Loaned then
            Error(LoanedVehicleErr, Vehicle."No.");

        Vehicle.Loaned := true;
        Vehicle.Modify();
    end;

    internal procedure ChangeVehicleStatusToFree(VehicleCode: Code[20])
    var
        Vehicle: Record "BCT Vehicle";
    begin
        Vehicle.Get(VehicleCode);

        Vehicle.Loaned := false;
        Vehicle.Modify();
    end;

    internal procedure GetNewLineNo(DocumentNo: Code[20]) LineNo: Integer
    var
        LoanLine: Record "BCT Loan Line";
    begin
        LineNo := 10000;

        LoanLine.SetRange("Document No.", DocumentNo);
        if LoanLine.FindLast() then
            LineNo += LoanLine."Line No.";

        exit(LineNo);
    end;
}