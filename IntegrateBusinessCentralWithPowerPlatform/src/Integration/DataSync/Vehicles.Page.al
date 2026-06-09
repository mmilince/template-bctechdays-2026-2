page 50110 "BCT Vehicles"
{
    PageType = List;
    Caption = 'Dataverse Vehicles';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CDS crf83_Vehicle";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(crf83_Make; Rec.crf83_Make)
                {
                    ToolTip = 'Specifies the make of the Dataverse vehicle.';
                }
                field(crf83_VehicleType; Rec.crf83_Type)
                {
                    ToolTip = 'Specifies the type of the Dataverse vehicle.';
                }
                field(crf83_Model; Rec.crf83_Model)
                {
                    ToolTip = 'Specifies the model of the Dataverse vehicle.';
                }
                field(crf83_ManufacturingYear; Rec.crf83_YearofManufacturing)
                {
                    ToolTip = 'Specifies the year the Dataverse vehicle was manufactured.';
                }
                field(crf83_FuelType; Rec.crf83_Fuel)
                {
                    ToolTip = 'Specifies the fuel type of the Dataverse vehicle.';
                }
                field(cr436_Mileage; Rec.crf83_Mileage)
                {
                    ToolTip = 'Specifies the mileage of the Dataverse vehicle in km.';
                }
                field(cr436_LicensePlate; Rec.crf83_LicensePlate)
                {
                    ToolTip = 'Specifies the license plate of the Dataverse vehicle.';
                }
                field(cr436_Loaned; Rec.crf83_Loaned)
                {
                    ToolTip = 'Specifies whether the Dataverse vehicle is currently loaned out.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateFromDataverse)
            {
                ApplicationArea = All;
                Caption = 'Create in Business Central';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate the table from the coupled Microsoft Dataverse vehicle.';

                trigger OnAction()
                var
                    Vehicle: Record "CDS crf83_Vehicle";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(Vehicle);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(Vehicle);
                end;
            }
            group(Init)
            {
                Caption = 'Initialize';

                action(InitConnectionSetup)
                {
                    ApplicationArea = All;
                    Caption = 'Initialize Connection Setup for Vehicles';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Initialize the Connection Setup for Vehicles integration.';

                    trigger OnAction()
                    var
                        DataSyncMgt: Codeunit "BCT Data Sync Mgt";
                    begin
                        DataSyncMgt.HandleOnBeforeResetConfiguration();
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledDataverseVehicle(Vehicle: Record "CDS crf83_Vehicle")
    begin
        CurrentlyCoupledVehicle := Vehicle;
    end;

    var
        CurrentlyCoupledVehicle: Record "CDS crf83_Vehicle";
}