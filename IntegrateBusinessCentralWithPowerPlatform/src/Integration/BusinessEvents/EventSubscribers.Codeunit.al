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

    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnBeforeValidateIBAN', '', false, false)]
    local procedure OnBeforeValidateIBAN(var VendorBankAccount: Record "Vendor Bank Account"; var xVendorBankAccount: Record "Vendor Bank Account"; var IsHandled: Boolean)
    begin
        if xVendorBankAccount.IBAN = '' then
            exit;

        if VendorBankAccount.IBAN = xVendorBankAccount.IBAN then
            exit;

        //Vendor IBAN changed business event here
    end;
}