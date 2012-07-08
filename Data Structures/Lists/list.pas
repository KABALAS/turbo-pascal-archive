program list;
uses CRT;

type pt = ^elem;
     elem = record
	       info : byte;
           next : pt;
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

function getlastel (list:pt):pt;
begin
     if (list<>NIL) then (* �᫨ ᯨ᮪ �� ����, �: *)
        begin
          while (list^.next<>NIL) do      (* ���� ⥪�騩 ����� ᯨ᪠ �� ��᫥����*)
                list:=list^.next;          (*��३� � ᫥���饬� ������ *)
          getlastel:=list;               (* ������ ������� ����� *)
        end
     else       (* ���� *)
         getlastel:=NIL; (* ������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
end;

function searchel (list:pt;info:byte):pt;
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

function searchpreel (list:pt;info:byte):pt;
var nextel:pt;
begin
     if (list<>NIL) then        (* �᫨ ᯨ᮪ �� ���� *)
     begin
          nextel:=list;
	  repeat
	        list:=nextel; (* ���室��� � ᫥���饬� ������ ᯨ᪠ *)
		if (list^.next<>NIL) then
		   nextel:=list^.next;
	  until ((nextel^.next=NIL) or (nextel^.info=info)); (* ���� ᫥���騩 �� ⥪�騬 �����- �� ��᫥���� ��� �᪮�� *)
	  if (nextel^.info<>info) or (nextel=list) then (* �᫨ �㦭� ��� ����� �� ������ ��� � ᯨ᪥ 1 ����� *)
	     searchpreel:=NIL (* ������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
	  else         (* ���� *)
	      searchpreel:=list;  (* ������ 㪠��⥫� �� ������� ����� *)
     end
     else (* ����, �᫨ ᯨ᮪ ���� *)
         begin
	      searchpreel:=NIL; (* ������ 㪠��⥫� �� ���⮩ ᯨ᮪ *)
	 end;
end;

function getelem(elname:string):byte;
var ret:byte;
begin
	write('������ ',elname,' : ');
	readln(ret);
        getelem:=ret;
end;

procedure addtobegin (var list:pt;info:byte);
var newelem:pt;
begin
	new(newelem);               (* ������� � ����� ���� ����� *)
	newelem^.info:=info;
	newelem^.next:=list;        (* ��ᮥ������ � �⮬� ������ ᯨ᮪ *)
	list:=newelem;              (* ������ ���, ��� ��砫� ������ ᯨ᪠ *)
end;

procedure addafter (listel:pt;info:byte);
var newelem:pt;
begin
     if (listel<>NIL) then (* �᫨ ᯨ᮪ �� ���� *)
        begin
          new(newelem);         (* ������� � ����� ���� ����� *)
	  newelem^.info:=info;
	  newelem^.next:=listel^.next; (* ��⠢��� ����� ����� ������� ����⮬ � ᫥���騬 *)
	  listel^.next:=newelem;
        end;
end;

procedure addtoend (var list:pt;info:byte);
begin
	if (list=NIL) then				(* �᫨ ᯨ᮪ ���� *)
           addtobegin(list,info)			(* �������� ����� � ��砫�, ᮧ��� ���� ᯨ᮪ *)
	else							(* ���� *)
	    addafter(getlastel(list),info);	(* �������� ����� ��᫥ ��᫥����� *)
end;

procedure addbefore (listel:pt;info:byte);
var newelem:pt;
begin
	if (listel<>NIL) then (* �᫨ ᯨ᮪ �� ���� *)
	   begin
	        new(newelem);   (* ������� � ����� ���� ����� *)
		newelem^.info:=listel^.info; (* �����஢��� � ���� ������� ����� ᯨ᪠ *)
		listel^.info:=info;   (* ������� � ������� ����� ᯨ᪠ ����� ��� ���������� *)
		newelem^.next:=listel^.next; (* ��⠢��� ������� ����� ᯨ᪠ ��᫥ ������������ *)
		listel^.next:=newelem;
	   end;
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

procedure delbefore(var list:pt;info:byte);
var temp:pt;
begin
	if (list<>NIL) then     (* �᫨ ᯨ᮪ �� ���� *)
	begin
		temp:=searchpreel(list,info); (* ���� �����, �।�����騩 �᪮���� *)
		delel(list,temp);  (* � 㤠���� ��� *)
	end;
end;

procedure delafter(var list:pt;info:byte);
var temp:pt;
begin
     if (list<>NIL) then        (* �᫨ ᯨ᮪, �� ���� *)
     begin
          temp:=searchel(list,info);  (* ���� �᪮�� ����� *)
	  temp:=temp^.next;             (* � 㤠���� ᫥���騩 �� ��� *)
          delel(list,temp)
     end;
end;

procedure printlist (list:pt);
begin
	clrscr;
	if (list=NIL) then      (* �᫨ ᯨ᮪ ���� *)
	   writeln('���᮪ ����!') (* ������� �� �⮬ *)
	else
	    while (list<>NIL) do	(* ���� ⥪�騩 ����� ᯨ᪠ �� ��᫥���� *)
	          begin
		       write(list^.info);     (* ��ᯥ���� ��� *)
		       list:=list^.next;	   (* ��३� � ᫥���饬� ������ *)
		       if (list<>NIL) then
		          write(',')
		       else
		           write('.');
		       end;
	readkey;
end;

procedure checkel(list:pt;info:byte);
begin
	if (searchel(list,info)<>NIL) then
		writeln('������� ',info,' �������.')
	else
		writeln('������� ',info,' �� �������.');
	readkey;
end;

procedure showmenu;
begin
	clrscr;
	Writeln('1) �������� ����� � ��砫� ᯨ᪠');
	Writeln('2) �������� ����� � ����� ᯨ᪠');
	Writeln('3) ��ᯥ���� ᯨ᮪');
	Writeln('4) ������� ���� ����� �� ᯨ᪠');
	Writeln('5) ������� ��᫥���� ����� �� ᯨ᪠');
	Writeln('6) ����, ������� �� 㪠����� ����� � ᯨ᪥');
	Writeln('7) ������� 㪠����� ����� �� ᯨ᪠');
	Writeln('8) �������� ����� ��᫥ 㪠�������');
	Writeln('9) �������� ����� ��। 㪠�����');
	Writeln('10) ������� ��᫥ 㪠�������');
	Writeln('11) ������� ��। 㪠�����');
	Writeln('12) ��室 �� �ணࠬ��');
	Writeln;
	Write(' ��� �롮� : ');
end;

var root: pt;
	selection : byte;

begin
	root:=NIL;	(* ������� ���⮩ ᯨ᮪ *)
	repeat
		showmenu;				(* �������� ���� *)
		readln(selection);		(* ����� � ���������� �㭪� ���� *)
		writeln;
		case selection of		(* �믮����� ����⢨�, ���ॡ������� ���짮��⥫�� *)
			1: addtobegin(root,getelem('���祭�� �����'));
			2: addtoend(root,getelem('���祭�� �����'));
			3: printlist(root);
			4: delfirstel(root);
			5: dellastel(root);
			6: checkel(root,getelem('���祭�� �᪮���� �����'));
			7: delel(root,searchel(root,getelem('���祭�� ����� ��� 㤠�����')));
			8: addafter(searchel(root,getelem('���祭�� �᪮���� �����')),getelem('���祭�� ����� ��� ����������'));
			9: addbefore(searchel(root,getelem('���祭�� �᪮���� �����')),getelem('���祭�� ����� ��� ����������'));
			10: delafter(root,getelem('���祭�� �᪮���� �����'));
			11: delbefore(root,getelem('���祭�� �᪮���� �����'));
			12: clrscr;
		end;
	until selection=12;		(* �᫨ ���짮��⥫� ��ࠫ �� ��室, ������� *)
end.
