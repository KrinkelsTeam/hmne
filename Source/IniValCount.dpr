program IniValCount;
uses
  Windows, SysUtils, Classes;

var
  C, I, X: Integer;
  S: String;
begin
  try
    with TStringList.Create do
    try
      X := 0;
      LoadFromFile(ParamStr(1));
      for C := 0 to Count - 1 do
      begin
        S := Strings[C];
        if (S <> '') and not (S[1] in ['[', ';']) then
        begin
          Inc(X);
          I := AnsiPos('=', S);
          if I > 0 then System.Delete(S, 1, I);
          Strings[C] := IntToStr(X) + '=' + S;
        end;
      end;
      SaveToFile(ParamStr(2));
    finally
      Free;
    end;
  except
    on E: Exception do
    begin
      if not (E is EAbort) then
        MessageBox(0, PChar(E.Message), nil, MB_ICONERROR or MB_OK);
    end;
  end;
end.