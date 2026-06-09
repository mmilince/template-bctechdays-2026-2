page 50119 "BCT APIV2 - Vehicle"
{
    APIGroup = 'community';
    APIPublisher = 'bctechdays';
    APIVersion = 'v2.0';
    EntityCaption = 'Vehicle';
    EntitySetCaption = 'Vehicles';
    DelayedInsert = true;
    EntityName = 'vehicle';
    EntitySetName = 'vehicles';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "BCT Vehicle";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No';
                    Editable = false;
                }
                field(make; Rec.Make)
                {
                    Caption = 'Make';
                }
                field(model; Rec.Model)
                {
                    Caption = 'Model';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(manufacturingYear; Rec."Manufacturing Year")
                {
                    Caption = 'Manufacturing Year';
                }
                field(fuelType; Rec."Fuel Type")
                {
                    Caption = 'Fuel Type';
                }
                field(mileage; Rec.Mileage)
                {
                    Caption = 'Mileage';
                }
                field(loaned; Rec.Loaned)
                {
                    Caption = 'Loaned';
                }
                field(licensePlate; Rec."License Plate")
                {
                    Caption = 'License Plate';
                }
            }
        }
    }
}