table 50120 "CDS crf83_Vehicle"
{
  ExternalName = 'crf83_vehicle';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1; crf83_VehicleId; GUID)
    {
      ExternalName = 'crf83_vehicleid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Vehicle';
    }
    field(2; CreatedOn; Datetime)
    {
      ExternalName = 'createdon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was created.';
      Caption = 'Created On';
    }
    field(3; CreatedBy; GUID)
    {
      ExternalName = 'createdby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the user who created the record.';
      Caption = 'Created By';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(4; ModifiedOn; Datetime)
    {
      ExternalName = 'modifiedon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was modified.';
      Caption = 'Modified On';
    }
    field(5; ModifiedBy; GUID)
    {
      ExternalName = 'modifiedby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the user who modified the record.';
      Caption = 'Modified By';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(6; CreatedOnBehalfBy; GUID)
    {
      ExternalName = 'createdonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the delegate user who created the record.';
      Caption = 'Created By (Delegate)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(7; ModifiedOnBehalfBy; GUID)
    {
      ExternalName = 'modifiedonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the delegate user who modified the record.';
      Caption = 'Modified By (Delegate)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(16; statecode; Option)
    {
      ExternalName = 'statecode';
      ExternalType = 'State';
      ExternalAccess = Modify;
      Description = 'Status of the Vehicle';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(18; statuscode; Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Vehicle';
      Caption = 'Status Reason';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 1, 2;
    }
    field(20; VersionNumber; BigInteger)
    {
      ExternalName = 'versionnumber';
      ExternalType = 'BigInt';
      ExternalAccess = Read;
      Description = 'Version Number';
      Caption = 'Version Number';
    }
    field(21; ImportSequenceNumber; Integer)
    {
      ExternalName = 'importsequencenumber';
      ExternalType = 'Integer';
      ExternalAccess = Insert;
      Description = 'Sequence number of the import that created this record.';
      Caption = 'Import Sequence Number';
    }
    field(22; OverriddenCreatedOn; Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Date and time that the record was migrated.';
      Caption = 'Record Created On';
    }
    field(23; TimeZoneRuleVersionNumber; Integer)
    {
      ExternalName = 'timezoneruleversionnumber';
      ExternalType = 'Integer';
      Description = 'For internal use only.';
      Caption = 'Time Zone Rule Version Number';
    }
    field(24; UTCConversionTimeZoneCode; Integer)
    {
      ExternalName = 'utcconversiontimezonecode';
      ExternalType = 'Integer';
      Description = 'Time zone code that was in use when the record was created.';
      Caption = 'UTC Conversion Time Zone Code';
    }
    field(25; crf83_Number; Text[850])
    {
      ExternalName = 'crf83_number';
      ExternalType = 'String';
      Description = '';
      Caption = 'Number';
    }
    field(26; OwnerId; GUID)
    {
      ExternalName = 'ownerid';
      ExternalType = 'Owner';
      Description = 'Owner Id';
      Caption = 'Owner';
    }
    field(31; OwningBusinessUnit; GUID)
    {
      ExternalName = 'owningbusinessunit';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the business unit that owns the record';
      Caption = 'Owning Business Unit';
      TableRelation = "CRM Businessunit".BusinessUnitId;
    }
    field(32; OwningUser; GUID)
    {
      ExternalName = 'owninguser';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the user that owns the record.';
      Caption = 'Owning User';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(33; OwningTeam; GUID)
    {
      ExternalName = 'owningteam';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the team that owns the record.';
      Caption = 'Owning Team';
      TableRelation = "CRM Team".TeamId;
    }
    field(35; crf83_Fuel; Option)
    {
      ExternalName = 'crf83_fuel';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Fuel';
      InitValue = " ";
      OptionMembers = " ", Gasoline, Diesel, Electric;
      OptionOrdinalValues = -1, 884020000, 884020001, 884020002;
    }
    field(37; crf83_LicensePlate; Text[100])
    {
      ExternalName = 'crf83_licenseplate';
      ExternalType = 'String';
      Description = '';
      Caption = 'License Plate';
    }
    field(38; crf83_Loaned; Boolean)
    {
      ExternalName = 'crf83_loaned';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Loaned';
    }
    field(40; crf83_Make; Text[100])
    {
      ExternalName = 'crf83_make';
      ExternalType = 'String';
      Description = '';
      Caption = 'Make';
    }
    field(41; crf83_Mileage; Decimal)
    {
      ExternalName = 'crf83_mileage';
      ExternalType = 'Decimal';
      Description = '';
      Caption = 'Mileage';
    }
    field(42; crf83_Model; Text[100])
    {
      ExternalName = 'crf83_model';
      ExternalType = 'String';
      Description = '';
      Caption = 'Model';
    }
    field(43; crf83_Type; Option)
    {
      ExternalName = 'crf83_type';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Type';
      InitValue = " ";
      OptionMembers = " ", Car, Motorcycle, Van;
      OptionOrdinalValues = -1, 884020000, 884020001, 884020002;
    }
    field(45; crf83_YearofManufacturing; Integer)
    {
      ExternalName = 'crf83_yearofmanufacturing';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'Year of Manufacturing';
    }
  }
  keys
  {
    key(PK; crf83_VehicleId)
    {
      Clustered = true;
    }
    key(Name; crf83_Number)
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown; crf83_Number)
    {
    }
  }
}