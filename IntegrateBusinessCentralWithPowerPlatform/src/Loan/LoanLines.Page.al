page 50104 "BCT Loan Lines"
{
    PageType = ListPart;
    SourceTable = "BCT Loan Line";
    Caption = 'Lines';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the vehicle being loaned.';
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the make and model of the loaned vehicle.';
                }
                field("Start Mileage"; Rec."Start Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage of the vehicle in km when the loan starts.';
                }
                field("End Mileage"; Rec."End Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage of the vehicle in km when it is returned.';
                }
            }
        }
    }
}