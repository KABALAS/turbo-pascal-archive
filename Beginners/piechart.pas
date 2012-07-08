program PieChart;

{ ��������� ������ ���������, ��������� �� ����������� ����������� 25% + 60% + 15% }

uses Graph;

const
     Radius = 80;

     p1 = 0.25; { ����������: �������� � ����� ������ ������ 1.0 (100%) }
     p2 = 0.6;
     p3 = 0.15;

var
   x, y,
   _From,
   _To : integer;
   Gd, Gm: Integer;

procedure DrawPie (percent: single); { ������ ������ - ������� �� ����� }
begin
 SetFillStyle(XHatchFill, 1 + Random (14));
{ 1-� �������� ������������� ��� ��������, � ������ - ��������� ���� � ��������� �� 1 �� 14 }

 _To := _From + Round (percent * 360.0); { percent * 360.0  -��� ������� �� ����� (360 ��������) }
 PieSlice(x, y, _From, _To, Radius);
 _From := _To; { ��� ������ ���������� 1 ������, ���������� �������� ���� ����������� � ������ ���������� }
end;

begin
 Randomize;
 Gd := Detect;
 InitGraph(Gd, Gm, '..\bgi');
 if GraphResult <> grOk then
   Halt(1);
 x := GetMaxX div 2;
 y := GetMaxY div 2;

 _From := 0; { ��������� ���� ������� ����� ���� }
 DrawPie (p1);
 DrawPie (p2);
 DrawPie (p3);

 Readln;
 CloseGraph;
end.