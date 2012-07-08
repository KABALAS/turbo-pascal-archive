Program Preem; { �������� ����� }

Const
    m =   100; {������������ ���-�� ������ �����}
    maxreal =   100.0; {������������ ��������� �����}

Type
    int =   1..m;
    sett =   set Of int; {��������� ������������ ������ �����}
    llisp =   ^node;
    node =   Record {��������� ���� �������}
        i, j:   int; {������� �����}
        cost:   real; {��������� �����}
        nextm:   llisp; {��������� �� ��������� ���� � �������� ������}
        next:   llisp; { ��������� �� ��������� ���� � ������ ��������� �������}
        pred:   llisp { ��������� �� ���������� ������� ������}
    End;
    arr =   array [int, int] Of real; {��� ������, ������� ������ ������ �}

Var i, j, k, n:   int;
    cos, cot:   real; {cot � �������� ����������� ��������� ��������� ������ �}
    t:   arr;
    head, head1:   llisp; {��������� �� ������ �������}
    first, last:   llisp; { ��������� �� ���������  �������� �������� ������}
    fir, las:   llisp; { ��������� �� ���������  �������� ������ ���������}
    p, q, qq:   llisp; {������� ���������}
    vused:   sett;

{������� �������� �������� ������. ��������� �������� ������, ���� ������������� ���������� �����-��������� �������� ��������}
Function tree(i, j: int):   boolean;

Var k:   int;
    fl:   boolean;
Begin
    fl := false;
    tree := fl;
    If (t[i, j] <> 0) Or (t[j, i] <> 0) Then tree := true
    Else
        If ((i In vused) And (j In vused)) Then tree := true
    Else
        If (Not(i In vused) And Not(j In vused)) Then tree := true
    Else
        If (i In vused) Then
        Begin
            k := 1;
            While (k <= n) And (k In vused) And Not(fl) Do
            Begin
                If (t[k, j] <> 0) Or (t[j, k] <> 0) Then
                Begin
                    fl := true;
                    tree := fl;
                End;
                k := k + 1
            End;
        End
    Else
        If (j In vused) Then
        Begin
            k := 1;
            While (k <= n) And (k In vused) And Not(fl) Do
            Begin
                If (t[k, i] <> 0) Or (t[i, k] <> 0) Then
                Begin
                    fl := true;
                    tree := fl;
                End;
                k := k + 1
            End;
        End;
End;
{��������� ������� ���� � ������������ �� ����������� ������ ���������,}
{ head � ��������� �� ������ ������, cost � ��������� ����� (i, j)}
Procedure inslisp(Var head: llisp; cost: real; i, j: int);

Var p, q:   llisp;
Begin
    new(q);
    q^.cost := cost;
    q^.i := i;
    q^.j := j;
    p := head;
    While (q^.cost > p^.cost) Do
        p := p^.next;
    p^.pred^.next := q;
    q^.next := p;
    q^.pred := p^.pred;
    p^.pred := q;
End;
{ ��������� ������� ���� � ������������ �� ����������� ������� ������ }

Procedure insmainlisp(Var head, head1: llisp);

Var p, q:   llisp;
Begin
    new(q);
    q^.cost := head1^.next^.cost;
    q^.i := head1^.next^.i;
    q^.j := head1^.next^.j;
    p := head;
    While (q^.cost > p^.cost) Do
        p := p^.nextm;
    p^.pred^.nextm := q;
    q^.nextm := p;
    q^.pred := p^.pred;
    p^.pred := q;
    q^.next := head1
End;

begin {������ �������� ��������}
    Writeln('Input number of vertices in graph');
    read(n); {n � �-�� ������ � �����}
    new(first);
    first^.cost := -1.0;
    head := first;
    new(last);
    first^.nextm := last;
    last^.cost := maxreal;
    last^.nextm := Nil;
    last^.pred := first;
    
    For i := 1 To n Do
    Begin
        writeln;
        new(fir);
        fir^.cost := -1.0;
        head1 := fir;
        new(las);
        fir^.next := las;
        las^.cost := maxreal;
        las^.next := Nil;
        las^.pred := fir;
        writeln('Vvedite ves dugi i vershynu smerznuu s vershynoj ',i);
        writeln('To finish input 100.0 and 0 ');
        read(cos, j);
        While cos <> maxreal Do
        Begin
            inslisp(head1, cos, i, j);
            read(cos, j)
        End;
        insmainlisp(head, head1);
    End;
    
    For i := 1 To n Do {��������� ����������  ��������������� ������ �}
        For j := 1 To n Do
            t[i, j] := 0;
    
    p := head^.nextm;
    vused := [ p^.i]; {����� ������ ���� ������ ������ �,}
    vused := vused + [p^.j]; {������� ������ � ����� ����������� ���������}
    t[p^.i, p^.j] := p^.cost;
    cot := p^.cost; {��������� �������� ���������  ��������� ������ �}

    head^.nextm := p^.nextm;
    {�������� ������������ ���� �� �������� ������ � ����� ���������� �����-������� ����� 
    ������, ������� � ���������� ��������}

    head1 := p^.next;
    q := head1^.next;
    qq := q^.next;
    If q^.cost <> maxreal Then
        Begin
            head1^.next := qq;
            If qq^.cost <> maxreal Then insmainlisp(head, head1);
    {��������� ������ ����� � ������� ������}
        End;

    For k := 1 To n - 2 Do {������� ���� ���������� ��������� ������}
    Begin
        p := head^.nextm; {��������� ��������� �� ��������� �����-��������}
        While (tree(p^.i, p^.j)) Do
            {���������� ������� �����-���������, ������� �� �������� �������� ������}
            p := p^.nextm;
        t[p^.i, p^.j] := p^.cost;
        If (p^.i In vused) Then
            vused := vused + [p^.j]
        Else
            vused := vused + [p^.i] ;
        cot := cot + p^.cost;
        p^.pred^.nextm := p^.nextm;
        head1 := p^.next;
        q := head1^.next;
        qq := q^.next;
        If q^.cost <> maxreal Then
            Begin
                head1^.next := qq;
                If qq^.cost <> maxreal Then insmainlisp(head, head1);
            End;
    End;
    
    writeln;
    
    For i := 1 To n Do {����� ����������}
    Begin
        For j := 1 To n Do
            write(t[i, j]: 2, ' ');
        writeln;
    End;
    
    writeln('Minimum value of spanning tree = ', cot);
End.
