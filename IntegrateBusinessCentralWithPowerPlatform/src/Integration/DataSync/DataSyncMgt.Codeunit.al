codeunit 50105 "Data Sync Mgt"
{
    //coupling
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var Handled: Boolean)
    begin
        if BCTableNo = Database::"BCT Vehicle" then begin
            //CDSTableNo := integration table number here;
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        // Check if the CRM table is the one we are interested in and add the logic accordingly (using the LookupVehicle procedure as an example)
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
        CRMSetupDefaults.AddEntityTableMapping('vehicle_entity_name', Database::"BCT Vehicle", TempNameValueBuffer);
        //AddEntityTableMapping for integration table
    end;

    procedure HandleOnBeforeResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        Vehicle: Record "BCT Vehicle";
    begin
        // insert integration table mapping

        //insert integration field mappings
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