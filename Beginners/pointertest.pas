type
   PInfo = ^TInfo;      { ��������� �� ��� TInfo}
   TInfo = record
     Size,
     Len: integer;
     ss:  string[20];
   end;

   Arr = array[1..10] of word;
   PArr     = ^Arr;     { ��������� �� ��� Arr}

   PInteger = ^Integer; { ��������� �� ��� Integer }

var
   i:     integer;
   PInt:  PInteger;
   PI:    PInfo;
   PA:    PArr;

begin

     writeln;

     PInt := New (PInteger); { ��������� ������ ��� ��������� �� ��� Integer }
      PInt^ := 123; { �������� �� ������ PInt ������� �������� }
      writeln ('Value = ', PInt^);
     Dispose (PInt); { ������������ ����������������� ������ }

     writeln;

     PA := New (PArr); { ��������� ������ ��� ��������� �� ��� Arr }
      for i := 1 to 10 do PA^[i] := i * 2 - 1; { ��������� ������� �� ������ PA ������� �������� }
      for i := 1 to 10 do write (PA^[i] : 4); { ������� �������� ������� �� ������ PA }
     Dispose (PA); { ������������ ����������������� ������ }

     writeln;
     writeln;

     PI := New (PInfo); { ��������� ������ ��� ��������� �� ��� TInfo}
      with PI^ do { ������� ������ � ������ �� ������ PI }
      begin
          writeln ('Enter some information');
          { ������ �������� ���������� � ������ }
          write ('Size: '); readln (Size);
          write ('Length: '); readln (Len);
          write ('String: '); readln (ss);

          writeln;
          { ������� �� �������� }
          writeln ('Size: ', Size : 20);
          writeln ('Length: ', Len : 18);
          writeln ('String: ', ss : 18);
      end;
     Dispose (PI); { ������������ ����������������� ������ ����� ������������� ������ }

end.