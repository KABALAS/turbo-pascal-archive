program hash_dyn;

Const MaxWordLength = 10;

Type TWord = string[MaxWordLength];

Type Pt = ^TList;
     TList = record
	 		info:TWord;
			next:Pt;
		end;

Const HashSize = 73;

Type THash = array[1..HashSize] of Pt;

Procedure InitHash(var Hash:THash);
var i:integer;
begin
	for i:=1 to HashSize do
		Hash[i]:=NIL;
end;

function getelem(elname:string):TWord;
var s:TWord;
begin
	write('������ ',elname,' : ');
	readln(s);
        getelem:=s;
end;

Function FHash(s:TWord):integer;
var i:integer;
    t,mul:longint;

begin
     t:=0;
     mul:=1;
     for i:=length(s) downto 1 do
         begin
	      t:=t + (ord(s[i])*mul);
	      mul:=mul*3;
	 end;
     FHash:=t mod 73;
end;

procedure addtobegin (var list:pt;info:TWord);
var newelem:pt;
begin
	new(newelem);               (* ������� � ����� ���� ����� *)
	newelem^.info:=info;
	newelem^.next:=list;        (* ��ᮥ������ � �⮬� ������ ᯨ᮪ *)
	list:=newelem;              (* ������ ���, ��� ��砫� ������ ᯨ᪠ *)
end;


Procedure add2hash(var Hash:THash;s:TWord);
begin
	addtobegin(Hash[fhash(s)],s);
end;

function searchel (list:pt;info:TWord):pt;
begin
     if (list<>NIL) then (* �᫨ ᯨ᮪ �� ���� *)
        begin
          while ((list^.next<>NIL) and (list^.info<>info)) do (* ���� ⥪�騩 ����� �� ��᫥���� � �� �᪮�� *)
	        list:=list^.next; (* ���室��� � ᫥���饬� ������ ᯨ᪠ *)
     	  if (list^.info<>info) then (* �᫨ �᪮�� ����� �� ������*)
	     searchel:=NIL              (*������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
      	  else             (* ���� *)
	      searchel:=list;   (* ������ 㪠��⥫� �� ��� ����� *)
        end
     else  (* ���� *)
        begin
          searchel:=NIL; (* ������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
        end;
end;


procedure searchhashelem(var Hash:THash;s:TWord);
begin
        writeln;
	if (searchel(Hash[fhash(s)],s)=NIL) then
		writeln('����� �� �������')
	else
		writeln('����� �������');
end;

procedure delfirstel(var list:pt);
var temp:pt;
begin
	if (list<>NIL) then (* �᫨ ᯨ᮪ �� ���� *)
	begin
	     temp:=list; (* ���࠭��� � ����� ���� ��ࢮ�� ����� *)
	     list:=list^.next; (* ��१��� �� ᯨ᪠ ���� ����� *)
	     dispose(temp); (* ����� ���� ����� �� ����� *)
	end;
end;

function getprelastel (list:pt):pt;
var nextel:pt;
begin
     if (list<>NIL) then (* �᫨ ᯨ᮪ �� ���� *)
        begin
          nextel:=list;
          repeat
                list:=nextel;        (* ��३� � ᫥���饬� ������ ᯨ᪠ *)
	        if (list^.next<>NIL) then
	           nextel:=list^.next;
          until (nextel^.next=NIL);  (* ���� ᫥���騩 �� ����� ����� ᯨ᪠ �� �㤥� ��᫥���� *)
          getprelastel:=list; (* ������ ������� ����� *)
        end
     else       (* ����, �᫨ ᯨ᮪ ���� *)
         getprelastel:=NIL; (* ������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
end;


procedure dellastel(var list:pt);
var temp:pt;
begin
	if (list<>NIL) then         (* �᫨ ᯨ᮪ �� ����, � *)
	   if (list^.next=NIL) then    (* �᫨ � ᯨ᪥ ���� ����� *)
	      delfirstel(list)            (* ������� ��� *)
	   else                        (* ���� *)
	     begin
	       temp:=getprelastel(list);  (* ���� �।��᫥���� ����� ᯨ᪠ *)
	       dispose(temp^.next);       (* ������� ᫥���騩 �� ��� *)
	       temp^.next:=NIL;
	     end;
end;

procedure delel(var list:pt;el:pt);
var temp:pt;
begin
	if ((list<>NIL) and (el<>NIL)) then (* �᫨ ��� ����� ��� 㤠����� � ᯨ᮪ �� ���� *)
	   begin
	        if (el^.next=NIL) then  (* �᫨ �����, ����� �㦭� 㤠���� - ��᫥���� � ᯨ᪥ *)
		   if (list^.next=NIL) then    (* � �᫨ �� ��� � �����⢥��� *)
		      delfirstel(list)      (* ������� ���, � ���� ���� ����� *)
		   else                   (* ����, �᫨ �� �� �����⢥��� *)
		       dellastel(list)       (* ������� ���, � ���� ��᫥���� ���� *)
		else
		    begin
		         temp:=el^.next;          (* �����஢��� � ��� ����� ᫥���騩 �� ��� *)
			 el^.info:=temp^.info;
			 el^.next:=temp^.next;
			 dispose(temp);       (* ������� ᫥���騩 �� �⨬ �����  *)
		    end;
		end;
end;


procedure delelfromhash(var Hash:THash;s:TWord);
var f:integer;
begin
     f:=fhash(s);
     delel(Hash[f],searchel(Hash[f],s));
end;

Procedure Showmenu;
begin
	Writeln;
	Writeln('1) �������� ����� � ��');
	Writeln('2) ������� ����� �� ��');
	Writeln('3) ���� ����� � ��');
	Writeln('4) ��室');
	Writeln;
	Write(' ��� �롮� : ');
end;

Var Hash:THash;
    selection:integer;

begin
	Writeln('��� � �������᪨� ࠧ�襭��� ��������');
	InitHash(Hash); (* ������ �� *)
	repeat          (* �������� *)
	      showmenu;    (* �������� ���� *)
	      readln(selection); (* ����� � ���������� �㭪� ���� *)
	      writeln;
	      case selection of (* �믮����� �ॡ㥬� ����⢨� *)
	           1: add2hash(Hash,getelem('᫮�� ��� ����������'));
		   2: delelfromhash(Hash,getelem('᫮�� ��� 㤠�����'));
		   3: searchhashelem(Hash,getelem('᫮�� ��� ���᪠'));
	      end;
	until selection=4; (* ���� �� �롥��� "��室" *)
end.
