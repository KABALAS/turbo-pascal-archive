type
	PList = ^TList;
	TList = record
		a: integer;
		next : PList;
	end;

// ���������� ������������ ������
procedure sortList(head:PList);  
var p1, p2, pm, lpm, lp, p : PList;  
begin  
   p1 := head.next;  
   p2 := head;  
   while p1 <> nil do begin  
      // ����� ������������ ��������  
      pm := p1; lpm := nil; p := p1; lp := nil;  
      while p <> nil do begin  
         if p.a <= pm.a then begin  
            pm := p;  
            lpm := lp;  // ���������� ����������  
         end;  
         lp := p;  
         p := p.next;  
      end;  
      // ����������� ������� ������� �� ������  
      if lpm = nil  
      then p1 := pm.next  
      else lpm.next := pm.next;  
      // � �������� � ����� ������  
      p2.next := pm;  
      p2 := p2.next;  
      p2.next := nil;  
   end;  
end;

procedure PrintList (var head: PList);  
var p:PList;  
begin  
   p:=head^.next;  
   while p<>nil do begin  
     write(p^.a:6);  
     p:=p^.next;  
   end;  
   writeln;  
end;  