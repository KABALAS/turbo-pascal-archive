program fifo_dyn;
uses CRT;

type pt = ^elem;
     elem = record
	       info : byte;
           next,prev : pt;
     end;

function getelem:byte;
var s:byte;
begin
	write('������ �᫮ : ');
	readln(s);
	getelem:=s;
end;

procedure push(var root,tail:pt;info:byte);
var newelem:pt;
begin
	new(newelem);          (* ������� � ����� ���� ����� *)       
	newelem^.info:=info;   
	newelem^.next:=root;   (* ��ᮥ������ ��।� � �⮬� ������ *)
	newelem^.prev:=NIL;
	if (root<>NIL) then			(* �᫨ ��।� �� ���� *)
		root^.prev:=newelem			(* ��ᮥ������ ��� ����� � ��砫� ��।� *)
	else						(* ���� *)
		tail:=newelem;				(* ������� ����� ��।� *)
	root:=newelem;          
end;

procedure pop(var root,tail:pt);
var temp:pt;
begin
	if (tail<>NIL) then			(* �᫨ ��।� �� ���� *)
		begin						
			temp:=tail;				(* ���࠭��� ���� ��᫥����� ����� *)
			tail:=tail^.prev;		(* ��१��� ��᫥���� ����� �� ��।� *)
			if (tail=NIL) then		
				root:=NIL		
			else
				tail^.next:=NIL;
			writeln('������񭭮� ���祭�� : ',temp^.info); (* �뢥�� �� �࠭ ���祭�� ��᫥����� ����� *)
			dispose(temp);			(* ����� ��᫥���� ����� �� ����� *)
		end
	else						(* ����, �᫨ ��।� ���� *)
		Writeln('��।� ����');
end;

procedure showmenu;
begin
	Writeln (' 1) Push ');
	Writeln (' 2) Pop ');
	Writeln (' 3) ��室 ');
	Write(' -> ');
end;

var root,tail: pt;
	selection : byte;

begin
	Writeln (' FIFO. �������᪠� ॠ������ ');
	root:=NIL;
	repeat				
		showmenu;
		readln(selection);	
		case selection of
			1: push(root,tail,getelem);
			2: pop(root,tail);
			3: clrscr;
		end;
	until selection=3;	
end.
