program deck_st;
uses CRT;

const decksize=10;

type TDeck = array[1..Decksize] of byte;

function getelem:byte;
var s:byte;
begin
	write('������ �᫮ : ');
	readln(s);
	getelem:=s;
end;

procedure pushbegin (var Deck:TDeck; var root,tail:integer;info:byte);
begin
	if (tail=root) and (root<>0) then (* �᫨ 㪠��⥫� ���� � 墮�� ᮢ������ � ��� �� ����, � *)
		writeln('��� ��९�����') (* ��� ��९�����, ᮮ���� *)
	else  (* ���� *)
		begin
			if (tail=0) then  (* �᫨ ��� ���� *)
				begin
					root:=decksize;  (* ������� ���� ��� *)
					tail:=decksize;
				end;
			dec(root);			(* �������� 㪠��⥫� ���� �� 1 ����� *)
			if (root<1) then  (* �᫨ 㪠��⥫� ��襫 �� ��砫� ���ᨢ�, *)
				root:=decksize;  (* ����⠢��� ��� � ����� *)
			deck[root]:=info;  (* ������� ����� � ��� *)
		end;
end;

procedure pushend (var Deck:TDeck;var root,tail:integer;info:byte);
begin
	if ((tail=root) and (tail<>0)) then (* �᫨ 㪠��⥫� ���� � 墮�� ᮢ������ � ��� �� ����, � *)
		writeln('��� ��९�����') (* ��� ��९�����, ᮮ���� *)
	else (* ���� *)
		begin
			if (tail=0) then  (* �᫨ ��� ���� *)
				begin
					root:=1;    (* ������� ���� ��� *)
					tail:=1;
				end;
			deck[tail]:=info;  (* ������� ����� � ��� *)
			inc(tail);	(* �������� 㪠��⥫� 墮�� �� 1 ��ࠢ� *)
			if (tail>decksize) then  (* �᫨ 㪠��⥫� ��襫 �� ����� ���ᨢ� *)
				tail:=1;   (* ����⠢��� ��� � ��砫� ���ᨢ� *)
		end;
end;

procedure popbegin(var Deck:TDeck;var root,tail:integer);
begin
	if (tail=0) then	(* �᫨ ��� ����, *)
		writeln('��� ����') (* ������� �� �⮬ *)
	else (* ���� *)
		begin
			writeln('������񭭮� �᫮ : ',Deck[root]);  (* ������� �᫮ �� ���� *)
			inc(root); 	(* �������� �� 1 ��ࠢ� 㪠��⥫� ���� *)
			if (root>DeckSize) then (* �᫨ 㪠��⥫� ���� ��襫 �� ����� ���ᨢ� *)
				root:=1; (* ����⠢��� ��� � ��砫� *)
			if (root=tail) then  (* �᫨ �� ���� ������� ��᫥���� ����� *)
				begin
					root:=0; 	(* "����⮦���" ��� *)
					tail:=0;
				end;
		end;
end;

procedure popend(var Deck:TDeck;var root,tail:integer);
begin
	if (tail=0) then   (* �᫨ ��� ����, � *)
		writeln('��� ����') (* ������� �� �⮬ *)
	else	(* ���� *)
		begin
			dec(tail); (* �������� 㪠��⥫� 墮�� �� 1 ����� *)
			if (tail<1) then	(* �᫨ 㪠��⥫� ��襫 �� ��砫� ����, *)
				tail:=DeckSize;	 (* ����⠢��� ��� � ����� *)
			writeln('������񭭮� �᫮ : ',Deck[tail]); (* ������� �� ���� �᫮ *)
			if (root=tail) then (* �᫨ �� ���� ������� ��᫥���� ����� *)
				begin
					root:=0;   (* "����⮦���" ��� *)
					tail:=0;
				end;
		end;
end;

procedure showmenu;
begin
	Writeln(' 1) Push � ��砫�');
	Writeln(' 2) Pop �� ��砫�');
	Writeln(' 3) Push � �����');
	Writeln(' 4) Pop �� ����');
	Writeln(' 5) ��室');
	Write(' -> ');
end;

var root,tail:integer;
	Deck:TDeck;
	selection:integer;

begin
	root:=0;
	tail:=0;
	Writeln('���. ����᪠� ॠ������.');
	repeat			
		showmenu;			(* �������� ���� *)
		readln(selection);		(* ����� � ���������� �㭪� ���� *)
		case selection of		(* �믮����� ����⢨�, ���ॡ������� ���짮��⥫�� *)
			1: pushbegin(Deck,root,tail,getelem); 
			2: popbegin(Deck,root,tail);
			3: pushend(Deck,root,tail,getelem); 
			4: popend(Deck,root,tail);
			5: clrscr;
		end;
	until selection=5;		(* �᫨ ���짮��⥫� ��ࠫ �� ��室, ������� *)
end.
