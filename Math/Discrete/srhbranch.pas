{ ���� ��� ��������� ������⮢ ����� ���� �窠�� ��� }
program all_road;
const
     N=7;{ ���-�� ���設 ���}
var
     map:array[1..N,1..N] of integer;{ ����: map[i,j] �� 0,
                                       �᫨ �窨 i � j ᮥ������ }
     road:array[1..N] of integer;{ ������� - ����� �祪 ����� }
     incl:array[1..N] of boolean;{ incl[i]=TRUE, �᫨ �窠 }
                                { � ����஬ i ����祭� � road }

     start,finish:integer;{ ��砫쭠� � ����筠� �窨 }

     i,j:integer;

procedure step(s,f,p:integer);{ s - �窠, �� ���ன �������� 蠣}
                              { f - ����筠� �窠 �������}
                              { p - ����� �᪮��� �窨 �������}
var
     c:integer;{ ����� �窨, � ������ �������� ��।��� 蠣 }
begin
     if s=f then begin
          {��窨 s � f ᮢ����!}
          write('����: ');
          for i:=1 to p-1 do write(road[i],' ');
          writeln;
     end
     else begin
               { �롨ࠥ� ��।��� ��� }
               for c:=1 to N do begin { �஢��塞 �� ���設� }
                    if(map[s,c]<>0)and(NOT incl[c])
                    { ��窠 ᮥ������ � ⥪�饩 � �� ����祭� }
                    { � �������}
                    then begin
                         road[p]:=c;{ ������� ���設� � ���� }
                         incl[c]:=TRUE;{ ����⨬ ���設� }
                                       { ��� ����祭��� }
                         step(c,f,p+1);
                         incl[c]:=FALSE;
                         road[p]:=0;
                    end;
               end;
     end;
end;{ ����� ��楤��� step }

{ �᭮���� �ணࠬ�� }
begin
     { ���樠������ ���ᨢ�� }
     for i:=1 to N do road[i]:=0;
     for i:=1 to N do incl[i]:=FALSE;
     for i:=1 to N do for j:=1 to N do map[i,j]:=0;
     { ���� ���祭�� ����⮢ ����� }
     map[1,2]:=1; map[2,1]:=1;
     map[1,3]:=1; map[3,1]:=1;
     map[1,4]:=1; map[4,1]:=1;
     map[3,4]:=1; map[4,3]:=1;
     map[3,7]:=1; map[7,3]:=1;
     map[4,6]:=1; map[6,4]:=1;
     map[5,6]:=1; map[6,5]:=1;
     map[5,7]:=1; map[7,5]:=1;
     map[6,7]:=1; map[7,6]:=1;
     write('������ �१ �஡�� ����� ��砫쭮� � ����筮� �祪 -> ');
     readln(start,finish);
     road[1]:=start;{ ���ᥬ ��� � ������� }
     incl[start]:=TRUE;{ ����⨬ �� ��� ����祭��� }

     step(start,finish,2);{�饬 ����� ��� ������� }

     writeln('��� �����襭�� ������ <Enter>');
     readln;
end.

