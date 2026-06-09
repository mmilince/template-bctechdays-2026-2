codeunit 50104 "BCT Event Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCT Loan Events", 'OnAfterReturnedLoanLineCreated', '', false, false)]
    local procedure OnAfterReturnVehicle(LoanLine: Record "BCT Loan Line")
    var
        LoansBusinessEvents: Codeunit "BCT Loans Business Events";
        LoanHeader: Record "BCT Loan Header";
    begin
        LoanHeader.Get(LoanLine."Document No.");

        LoansBusinessEvents.VehicleReturned(LoanHeader."No.",
                                            LoanHeader."Contact No.",
                                            LoanHeader."Contact Name",
                                            LoanHeader."Contact E-Mail",
                                            LoanLine."Vehicle No.",
                                            LoanLine."Vehicle Name",
                                            LoanLine.DocumentId);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCT Loan Events", 'OnAfterLoanVehicle', '', false, false)]
    local procedure OnAfterLoanVehicle(LoanLine: Record "BCT Loan Line")
    var
        LoansBusinessEvents: Codeunit "BCT Loans Business Events";
        LoanHeader: Record "BCT Loan Header";
    begin
        LoanHeader.Get(LoanLine."Document No.");

        LoansBusinessEvents.VehicleLoaned(LoanHeader."No.",
                                          LoanHeader."Contact No.",
                                          LoanHeader."Contact Name",
                                          LoanHeader."Contact E-Mail",
                                          LoanLine."Vehicle No.",
                                          LoanLine."Vehicle Name",
                                          LoanLine.DocumentId);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnBeforeValidateIBAN', '', false, false)]
    local procedure OnBeforeValidateIBAN(var VendorBankAccount: Record "Vendor Bank Account"; var xVendorBankAccount: Record "Vendor Bank Account"; var IsHandled: Boolean)
    var
        LoansBusinessEvents: Codeunit "BCT Loans Business Events";
    begin
        if xVendorBankAccount.IBAN = '' then
            exit;

        if VendorBankAccount.IBAN = xVendorBankAccount.IBAN then
            exit;

        LoansBusinessEvents.VendorIBANChanged(VendorBankAccount.IBAN, xVendorBankAccount.IBAN, VendorBankAccount."Vendor No.", UserSecurityId());
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