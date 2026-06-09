codeunit 50105 "BCT Data Sync Mgt"
{
    //coupling
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var Handled: Boolean)
    begin
        if BCTableNo = Database::"BCT Vehicle" then begin
            CDSTableNo := Database::"CDS crf83_Vehicle";
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CDS crf83_Vehicle" then
            Handled := LookupVehicle(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupVehicle(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        Vehicle: Record "CDS crf83_Vehicle";
        OriginalVehicle: Record "CDS crf83_Vehicle";
        DataverseVehicles: Page "BCT Vehicles";
    begin
        if not IsNullGuid(CRMId) then begin
            if Vehicle.Get(CRMId) then
                DataverseVehicles.SetRecord(Vehicle);
            if not IsNullGuid(SavedCRMId) then
                if OriginalVehicle.Get(SavedCRMId) then
                    DataverseVehicles.SetCurrentlyCoupledDataverseVehicle(OriginalVehicle);
        end;

        Vehicle.SetView(IntTableFilter);
        DataverseVehicles.SetTableView(Vehicle);
        DataverseVehicles.LookupMode(true);
        if DataverseVehicles.RunModal = ACTION::LookupOK then begin
            DataverseVehicles.GetRecord(Vehicle);
            CRMId := Vehicle.crf83_VehicleId;
            exit(true);
        end;
        exit(false);
    end;

    //enabling deep linking between couple Vehicle record with a dataverse Vehicle records
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    var
        CRMSetupDefaults: Codeunit "CRM Setup Defaults";
    begin
        CRMSetupDefaults.AddEntityTableMapping('crf83_vehicle', Database::"BCT Vehicle", TempNameValueBuffer);
        CRMSetupDefaults.AddEntityTableMapping('crf83_vehicle', Database::"CDS crf83_Vehicle", TempNameValueBuffer);
    end;

    procedure HandleOnBeforeResetConfiguration()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        DataverseVehicle: Record "CDS crf83_Vehicle";
        Vehicle: Record "BCT Vehicle";
    begin
        InsertIntegrationTableMapping(
            IntegrationTableMapping, 'VEHICLE-VEHICLE',
            Database::"BCT Vehicle", Database::"CDS crf83_Vehicle",
            DataverseVehicle.FieldNo(crf83_VehicleId), DataverseVehicle.FieldNo(ModifiedOn),
            '', '', true);

        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo("No."), DataverseVehicle.FieldNo(crf83_Number), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo(Make), DataverseVehicle.FieldNo(crf83_Make), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo(Model), DataverseVehicle.FieldNo(crf83_Model), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo(Type), DataverseVehicle.FieldNo(crf83_Type), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo("Manufacturing Year"), DataverseVehicle.FieldNo(crf83_YearofManufacturing), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo(Mileage), DataverseVehicle.FieldNo(crf83_Mileage), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo("Fuel Type"), DataverseVehicle.FieldNo(crf83_Fuel), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('VEHICLE-VEHICLE', Vehicle.FieldNo("License Plate"), DataverseVehicle.FieldNo(crf83_LicensePlate), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'Dataverse');
    end;

    local procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;
}