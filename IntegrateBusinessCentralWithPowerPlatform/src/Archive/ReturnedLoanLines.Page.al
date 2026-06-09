page 50107 "BCT Returned Loan Lines"
{
    PageType = ListPart;
    SourceTable = "BCT Returned Loan Line";
    Caption = 'Lines';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the vehicle that was loaned.';
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the make and model of the loaned vehicle.';
                }
                field("Start Mileage"; Rec."Start Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage of the vehicle in km when the loan started.';
                }
                field("End Mileage"; Rec."End Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage of the vehicle in km when it was returned.';
                }
            }
        }
    }
}