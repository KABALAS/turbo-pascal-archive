program deck_dyn;
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

procedure pushbegin(var root,tail:pt;info:byte);
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

procedure popbegin(var root,tail:pt);
var temp:pt;
begin
	if (root<>NIL) then			(* �᫨ ��।� �� ���� *)
		begin						
			temp:=root;				(* ���࠭��� ���� ��ࢮ�� ����� *)
			root:=root^.next;		(* ��१��� ���� ����� �� ��।� *)
			if (root=NIL) then		
				tail:=NIL		
			else
				root^.prev:=NIL;
			writeln('������񭭮� ���祭�� : ',temp^.info); (* �뢥�� �� �࠭ ���祭�� ��᫥����� ����� *)
			dispose(temp);			(* ����� ���� ����� �� ����� *)
		end
	else						(* ����, �᫨ ��।� ���� *)
		Writeln('��� ����');
end;

procedure pushend(var root,tail:pt;info:byte);
var newelem:pt;
begin
	new(newelem);          (* ������� � ����� ���� ����� *)
	newelem^.info:=info;
	newelem^.next:=NIL;   (* ��ᮥ������ ��� ����� � ��।� *)
	newelem^.prev:=tail;
	if (tail<>NIL) then			(* �᫨ ��।� �� ���� *)
		tail^.next:=newelem			(* ��ᮥ������ ��� ����� � ��砫� ��।� *)
	else						(* ���� *)
		root:=newelem;				(* ������� ����� ��।� *)
	tail:=newelem;
end;

procedure popend(var root,tail:pt);
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
		Writeln('��� ����');
end;

procedure showmenu;
begin
	Writeln (' 1) Push � ��砫�');
	Writeln (' 2) Pop �� ��砫�');
	Writeln (' 3) Push � �����');
	Writeln (' 4) Pop �� ����');
	Writeln (' 5) ��室 ');
	Write(' -> ');
end;

var root,tail: pt;
	selection : byte;

begin
	Writeln ('���. �������᪠� ॠ������ ');
	root:=NIL;
	repeat				
		showmenu;
		readln(selection);	
		case selection of
			1: pushbegin(root,tail,getelem);
			2: popbegin(root,tail);
			3: pushend(root,tail,getelem);
			4: popend(root,tail);
			5: clrscr;
		end;
	until selection=5;	
end.
