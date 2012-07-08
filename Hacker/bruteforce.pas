
type
  Tcharset = set of char;

const
  psw : string[30] = 'topsecret';
  abc_ : string[30] = 'abcdefghijklmnopqrstuvwxyz';
  abc : string[30] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  digits : string[10] = '0123456789';
  special : string[30] = ' _@.';
  special_plus : string[30] = ',-[]<>!?#*=~$%^&';

var
  SDict: string;  { ᫮����, ����騩 �� ��ॡ�ࠥ��� ᨬ�����}
 
  procedure BruteForce(S: string; n: integer); {��楤��, ����� �㤥� ��⠢���� ��஫�}
  var
   i: integer;
  begin
   for i := 1 to Length (SDict) do
   begin
     s[n] := SDict[i];
     if n = 1 then
     begin
      if s = psw then
       writeln ('Found! psw: ', s)
     end
     else
       BruteForce(s, n - 1);
   end;
  end;

var
     SBase: string;
begin
     SBase := 'aaaaaaaaaaa';    {������� ����� ��஫�}
     SDict := abc_ + special;  {����� ᨬ�����(�� 祣� ��ॡ�� ������ �㤥�)}
     BruteForce (SBase, Length(SBase)); {�맮� ��楤���, ��⮠� ��⠢��� �����}
end.
