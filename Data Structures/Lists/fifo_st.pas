program fifo_st;
uses CRT;

const FIFOsize=10;

type TFIFO = array[1..FIFOsize] of byte;

function getelem:byte;
var s:byte;
begin
	write('������ �᫮ : ');
	readln(s);
	getelem:=s;
end;

procedure push (var FIFO:TFifo;var root,tail:integer;info:byte);
begin
	if ((tail=root) and (root<>0)) then	(* �᫨ ��।� ��९������ *)
		writeln('��।� ��९������')	(* ������� �� �⮬ *)
	else	(* ���� *)
		begin	
			if (root=0) then	(* �᫨ ��।� ���� *)
				begin
					root:=1;  (* ������� ����� ��।� *)
					tail:=1; 
				end;
			fifo[tail]:=info; (* ������ ����� � ��।� *)
			inc(tail); (* ��।������ 㪠��⥫� 墮�� ��।� �� 1 ��ࠢ� *)
			if (tail>FIFOSize) then	(* �᫨ 㪠��⥫� ��襫 �� ����� ���ᨢ� *)
				tail:=1;	(* ��७��� ��� � ��砫� ���ᨢ� *)
		end;
end;

procedure pop(var FIFO:TFifo;var root,tail:integer);
begin
	if (tail=0) then		(* �᫨ ��।� ���� *)
		writeln('��।� ����') 	(* ������� �� �⮬ *)
	else	(* ���� *)	
		begin
			writeln('������񭭮� �᫮ : ',FIFO[root]); (* ������� �᫮ �� ��।� *)
			inc(root);			(* �������� 㪠��⥫� ���� ��।� �� 1 ��ࠢ� *)
			if (root>FIFOSize) then	(* �᫨ ��७� ��襫 �� �।��� ���ᨢ� *)
				root:=1;		(* ������ ��� � ��砫� *)
			if (root=tail) then	 (* �᫨ �� ��।� ������� ��᫥���� ����� *)
				begin
					root:=0;		(* ������� ������ ��।� *)
					tail:=0;
				end;
		end;
end;

procedure showmenu;
begin
	Writeln(' 1) Push');
	Writeln(' 2) Pop');
	Writeln(' 3) ��室');
	Write(' -> ');
end;

var root,tail:integer;
	FIFO:TFIFO;
	selection:integer;

begin
	root:=0;
	tail:=0;
	Writeln('��।�. ����᪠� ॠ������.');
	repeat			
		showmenu;			(* �������� ���� *)
		readln(selection);		(* ����� � ���������� �㭪� ���� *)
		case selection of		(* �믮����� ����⢨�, ���ॡ������� ���짮��⥫�� *)
			1: push(FIFO,root,tail,getelem); 
			2: pop(FIFO,root,tail);
			3: clrscr;
		end;
	until selection=3;		(* �᫨ ���짮��⥫� ��ࠫ �� ��室, ������� *)
end.
