PROGRAM simple_selection_sort;
USES CRT,dos;

CONST TWordLength = 10;

TYPE TWord = STRING [TWordLength];

TYPE PList = ^TList;
  TList = RECORD
            info : TWord;
            num : INTEGER;
            next : PList;
          END;

PROCEDURE readword (VAR infile : text;VAR s : TWord);
VAR letter : string[1];
BEGIN
  REPEAT
    if eoln(infile) then
       readln(infile)
    else
        READ (infile, letter);
  UNTIL ( (letter > ' ') OR (EOF (infile) ) );

  IF (NOT (EOF (infile) ) ) THEN
     BEGIN
     s := letter;
     WHILE ( (letter > ' ') AND (NOT EOF (infile) ) AND (LENGTH (s) < TWordLength) and (not eoln(infile))) DO
           BEGIN
           READ (infile, letter);
           IF (letter > ' ') THEN
              s := s + letter;
           END;
     END
  ELSE
     s := '';
END;

procedure addword (list : PList;s:TWord);
var elem:PList;
begin
     while (list^.next<>NIL) and (list^.info<>s) do
           list:=list^.next;

     if (list^.info=s) then
        begin
             inc(list^.num)
        end
     else
         begin
              new(elem);
              elem^.next:=list^.next;
              elem^.info:=s;
              elem^.num:=1;
              list^.next:=elem;
         end;
end;

PROCEDURE readfile (VAR infile : text;VAR list : PList);
VAR temp,elem : PList;
  s : TWord;
BEGIN
  readword(infile,s);
  new(list);
  list^.next:=NIL;
  list^.info:=s;
  list^.num:=1;
  WHILE (NOT (EOF (infile) ) ) DO (* ���� �� ����� 䠩�� *)
        BEGIN
        readword (infile, s); (* ����� �� ���� ᫮�� *)
        IF (s <> '') THEN	(* �᫨ ᫮�� - �� ���⮥ *)
           BEGIN
                addword(list,s);
           END;
        END;
END;

FUNCTION getminel (list : PList) : PList;
VAR minel : PList;
BEGIN
  IF (list <> NIL) THEN
     BEGIN
     minel := list; (* �⫮���� ���� ����� ᯨ᪠ *)
     list := list^.next;
     WHILE (list <> NIL) DO	(* ���� ᯨ᮪ �� ���稫�� *)
           BEGIN
           IF (list^.info < minel^.info) THEN (* �᫨ ⥪�騩 ����� ����� �⫮������� *)
              minel := list;	(* �⫮���� ⥪�騩 ����� *)
           list := list^.next;	(* ��३� � ᫥���饬� ������ *)
           END;
     getminel := minel; (* �⫮����� ����� - ��������� *)
     END
  ELSE
     getminel := NIL;
END;

PROCEDURE change (Var w1, w2 : TList);
VAR temp : TList;
BEGIN
  temp.info := w1.info;
  w1.info := w2.info;
  w2.info := temp.info;

  temp.num := w1.num;
  w1.num := w2.num;
  w2.num := temp.num;
END;

PROCEDURE sort (list : PList);
VAR minel : PList;
BEGIN
  WHILE (list <> NIL) DO	(* ���� ᯨ᮪ �� ���稫�� *)
        BEGIN
        minel := getminel (list);	(* ���� ��������� ����� � ���⪥ ᯨ᪠ *)
        change (minel^, list^);	(* �������� ⥪�騩 ����� � ��������� *)
        list := list^.next;	(* ��३�� � ᫥���饬� ������ *)
        END;

END;


PROCEDURE writefile (VAR outfile : TEXT; VAR list : PList);
VAR temp : PList;
BEGIN
  REPEAT
    WRITELN (outfile, list^.info, '-', list^.num);
    temp := list;
    list := list^.next;
    DISPOSE (temp);
  UNTIL (list = NIL);
END;

VAR list : PList;
  infname, outfname : STRING;
  infile : text;
  outfile : TEXT;
  IOR : INTEGER;
  h1,m1,s1,decs1 : word;
  h2,m2,s2,decs2 : word;
  wtime:longint;

BEGIN
  list := NIL;	(* ������� ���⮩ ᯨ᮪ *)
  WRITELN ('����஢�� 䠩�� ����� �롮஬.');
  REPEAT

    WRITE ('������ ��� �室���� 䠩�� : ');
    READLN (infname); (* ����� ��� �室���� 䠩�� *)
    ASSIGN (infile, infname);
    {$I-}
    RESET (infile); (* ������ �室��� 䠩� *)
    {$I+}

    IOR := IORESULT;
    IF (IOR <> 0) THEN
       WRITELN ('�� ���� ������ �室��� 䠩�!');
  UNTIL (IOR = 0);
  REPEAT

    WRITE ('������ ��� ��室���� 䠩�� : ');
    READLN (outfname); (* ����� ��� ��室���� 䠩�� *)
    ASSIGN (outfile, outfname);
    {$I-}
    REWRITE (outfile); (* ������ ��室��� 䠩� *)
    {$I+}
    IOR := IORESULT;
    IF (IOR <> 0) THEN
       WRITELN ('�� ���� ������ ��室��� 䠩�!');
  UNTIL (IOR = 0);

  gettime(h1,m1,s1,decs1);
  readfile (infile, list); (* ����� �室��� 䠩� � ������ *)
  sort (list);	(* �����஢��� ��� ����� �롮஬ *)
  writefile (outfile, list);	(* ������� ��室��� 䠩� *)
  gettime(h2,m2,s2,decs2);
  wtime:=(decs2+s2*100+m2*6000+h2*360000)-(decs1+s1*100+m1*6000+h1*360000);
  writeln('�६� ࠡ��� : ',(wtime/100):2:2);

  CLOSE (outfile); (* ������� ��室��� 䠩� *)
  CLOSE (infile); (* ������� �室��� 䠩� *)
END.
