
type
	PListObject = ^TListObject;
	TListObject = object
		prev,next: PListObject;
          constructor Init;
		procedure PrintItem; virtual;
	end;

     TData = record
          n: integer;
          s: string;
     end;

	PRecList = ^TRecList;
	TRecList = object (TListObject)
		data: TData;
          constructor Init;
		procedure PrintItem; virtual;
		procedure AddItem (num: integer);
	end;


var
	top: PRecList;


constructor TListObject.Init;
begin
end;


procedure TListObject.PrintItem;
begin
end;


procedure TRecList.PrintItem;
begin
	write (data.n: 4);
end;


constructor TRecList.Init;
begin
     Inherited Init
end;

procedure TRecList.AddItem (num: integer);
var newelem: PRecList;
begin
	newelem := new(PRecList, Init);               (* ������� � ������ ����� ������� *)
	newelem^.data.n:=num;
	newelem^.next:=top;        (* ������������ � ����� �������� ������ *)
	top:=newelem;              (* ������� ���, ��� ������ ������ ������ *)
end;

function searchel (data: Tdata): PRecList;
var
     list:PRecList;
begin
     list := top;
     if (list<>NIL) then (* ���� ������ �� ���� *)
        begin
          while 
               ((list^.next<>NIL) and 
          (list^.data.n<>data.n)) do (* ���� ������� ������� �� ��������� � �� ������� *)
	        list:=list^.next; (* ���������� � ���������� �������� ������ *)
     	  if (list^.data.n<>data.n) then (* ���� ������� ������� �� ������*)
	     searchel:=NIL              (*������� ��������� �� ������ ������ *)
      	  else             (* ����� *)
	      searchel:=list;   (* ������� ��������� �� ���� ������� *)
        end
     else  (* ����� *)
        begin
          searchel:=NIL; (* ������� ��������� �� ������ ������ *)
        end;
end;


procedure PrintList (List: PListObject);
begin
	if (list=NIL) then      (* ���� ������ ���� *)
	   writeln ('������ ����!') (* �������� �� ���� *)
	else
	while (list<>NIL) do	(* ���� ������� ������� ������ �� ��������� *)
	begin
	        List^.PrintItem;
		list:=list^.next;	   (* ������� � ���������� �������� *)
	end;
end;

var
	RecList : PRecList;
begin
	top := nil;
	RecList := New (PRecList, Init);
	RecList^.AddItem (10);
	RecList^.AddItem (9);
	RecList^.AddItem (8);
	PrintList (top);
	Dispose (Reclist);
	readln;
end.
