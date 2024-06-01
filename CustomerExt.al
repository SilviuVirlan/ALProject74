// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ALProject74;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.Period;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{

    trigger OnOpenPage()
    begin
        PlaySample();
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure PlaySample()
    var
        error: ErrorInfo;
        errors: Record "Error Message" temporary;
        OS: OutStream;
    begin
        if not Codeunit.Run(Codeunit::CodeunitWithErrorInfo) then begin
            errors.ID := errors.ID + 1;
            errors.Message := GetLastErrorText();
            errors.Insert();
        end;

        if HasCollectedErrors then
            foreach error in GetCollectedErrors() do begin
                errors.ID := errors.ID + 1;
                errors.Message := error.Message;
                errors.Validate("Record ID", error.RecordId);
                errors."Error Call Stack".CreateOutStream(OS);
                OS.WriteText(error.Callstack);
                errors.Insert();
            end;

        ClearCollectedErrors();

        page.RunModal(page::"Error Messages", errors);
    end;
}