
type
	PListObject = ^TListObject;
	TListObject = object
		prev,next: PListObject;
                constructor Init;
		procedure PrintItem; virtual;
	end;

	PIntList = ^TIntList;
	TIntList = object (TListObject)
		data: integer;
                constructor Init;
		procedure PrintItem; virtual;
		procedure AddItem (num: integer);
	end;


var
	top: PIntList;


constructor TListObject.Init;
begin
end;


procedure TListObject.PrintItem;
begin
end;


procedure TIntList.PrintItem;
begin
	write (data: 4);
end;


constructor TIntList.Init;
begin
     Inherited Init
end;

procedure TIntList.AddItem (num: integer);
var newelem: PIntList;
begin
	newelem := new(PIntList, Init);               (* ������� � ������ ����� ������� *)
	newelem^.data:=num;
	newelem^.next:=top;        (* ������������ � ����� �������� ������ *)
	top:=newelem;              (* ������� ���, ��� ������ ������ ������ *)
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
	IntList : PIntList;
begin
	top := nil;
	IntList := New (PIntList, Init);
	IntList^.AddItem (10);
	IntList^.AddItem (9);
	IntList^.AddItem (8);
	PrintList (top);
	Dispose (Intlist);
	readln;
end.