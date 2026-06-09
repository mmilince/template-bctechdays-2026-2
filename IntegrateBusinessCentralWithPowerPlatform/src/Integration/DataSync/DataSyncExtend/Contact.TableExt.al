tableextension 50101 Contact extends Contact
{
    fields
    {
        field(50100; "BCT Membership ID"; Code[20])
        {
            Caption = 'Membership ID';
            ToolTip = 'Specifies the value of the Membership ID field if the contact is part of the loyalty program.';
        }
    }
}