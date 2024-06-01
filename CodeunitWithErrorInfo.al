codeunit 50110 CodeunitWithErrorInfo
{
    trigger OnRun()
    begin
        DoCollectibleErrMethod();
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure DoCollectibleErrMethod()
    begin
        Error(ErrorInfo.Create('Error 1', true));
        Error(ErrorInfo.Create('Error 2', true));
    end;

    var
        myInt: Integer;
}