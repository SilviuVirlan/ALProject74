pageextension 50112 ErrMsgExt extends "Error Messages"
{
    layout
    {
        addafter(Description)
        {
            field("Error Call Stack"; ErrorCallStack)
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ErrorCallStack := Rec.GetErrorCallStack();
    end;

    var
        ErrorCallStack: Text;
}