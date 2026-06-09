page 50110 "BCT Vehicles"
{
    PageType = List;
    Caption = 'Dataverse Vehicles';
    ApplicationArea = All;
    UsageCategory = Lists;
    // integration table source here

    layout
    {
        area(content)
        {
            // fields from integration table here

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
                ToolTip = 'Generate the table from the coupled Microsoft Dataverse worker.';

                trigger OnAction()
                var
                    // integration table here as var
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    // CurrPage.SetSelectionFilter(//integration table);
                    // CRMIntegrationManagement.CreateNewRecordsFromCRM(//integration table);
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
                    begin
                        // Initialize the connection setup for Vehicles integration
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