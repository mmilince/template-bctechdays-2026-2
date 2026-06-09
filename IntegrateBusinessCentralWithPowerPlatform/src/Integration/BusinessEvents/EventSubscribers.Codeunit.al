codeunit 50104 "Event Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCT Loan Events", 'OnAfterReturnedLoanLineCreated', '', false, false)]
    local procedure OnAfterReturnVehicle(LoanLine: Record "BCT Loan Line")
    var
        LoanHeader: Record "BCT Loan Header";
    begin
        LoanHeader.Get(LoanLine."Document No.");

        //Vehicle returned business event here
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCT Loan Events", 'OnAfterLoanVehicle', '', false, false)]
    local procedure OnAfterLoanVehicle(LoanLine: Record "BCT Loan Line")
    var
        LoanHeader: Record "BCT Loan Header";
    begin
        LoanHeader.Get(LoanLine."Document No.");

        //Vehicle loaned business event here
    end;
}