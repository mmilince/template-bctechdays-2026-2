codeunit 50101 "BCT Loan Events"
{
    [IntegrationEvent(false, false)]
    internal procedure OnAfterLoanVehicle(LoanLine: Record "BCT Loan Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    internal procedure OnAfterReturnedLoanLineCreated(LoanLine: Record "BCT Loan Line");
    begin
    end;
}