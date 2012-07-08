PROGRAM binary_tree_sort;
USES dos,CRT;

CONST TWordLength = 10;
  
TYPE TWord = STRING [TWordLength];
  
TYPE PTree = ^TTree;
  TTree = RECORD
            info : TWord;
            num : INTEGER;
            Left, Right : PTree;
          END;
  
TYPE tinfile = text;

PROCEDURE readword (VAR infile : tinfile; VAR s : TWord);
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

PROCEDURE addelem (VAR root : PTree; info : TWord);
VAR elem : PTree;
BEGIN
  IF (root = NIL) THEN (* �᫨ ��ॢ� ���⮥, � *)
     BEGIN
     NEW (elem);	(* ������� ���� ���� *)
     elem^.Left := NIL;
     elem^.Right := NIL;
     elem^.num := 1;
     elem^.info := info; (* ������� � ���� �㦭� ����� *)
     root := elem;	(* �������� ��� ����� ���⮣� ��ॢ� *)
     END
  ELSE
     IF (root^.info = info) THEN (* �᫨ ⥪�騩 㧥� ࠢ�� ������塞��� ������ *)
        INC (root^.num) (* �������� �᫮ ������ ������� ����� *)
     ELSE (* ���� *)
        BEGIN
        IF (info < root^.info) THEN (* �᫨ ������塞� ����� ����� ⥪.㧫�, � *)
           addelem (root^.Left, info)	(* �������� ����� � ����� �����ॢ� *)
        ELSE	(* ���� *)
           addelem (root^.Right, info); (* �������� ����� � �ࠢ�� �����ॢ� *)
        END;
END;

PROCEDURE readfile (VAR infile : tinfile; VAR tree : PTree);
VAR s : TWord;
BEGIN
  WHILE (NOT (EOF (infile) ) ) DO	(* ���� 䠩� �� �����稫�� *)
        BEGIN
        readword (infile, s); (* ����� �� ���� ᫮�� *)
        IF (s <> '') THEN (* �᫨ ᫮�� �� ���⮥ *)
           addelem (tree, s);	(* �������� ��� � ��ॢ� *)
        END;

END;

PROCEDURE writefile (VAR outfile : TEXT; VAR root : PTree);
BEGIN
  IF (root <> NIL) THEN (* �᫨ ��ॢ� �� ���⮥, � *)
     BEGIN
     writefile (outfile, root^.Left); (* ������� � 䠩� ��� ����� ���� *)
     WRITELN (outfile, root^.info, '-', root^.num); (* ������� � 䠩� ��� ��७� *)
     writefile (outfile, root^.Right); (* ������� � 䠩� ��� �ࠢ�� ���� *)
     END;
END;

VAR tree : PTree;
  infname, outfname : STRING;
  infile : tinfile;
  outfile : TEXT;
  IOR : INTEGER;
  h1,m1,s1,decs1 : word;
  h2,m2,s2,decs2 : word;
  wtime:longint;

BEGIN
  tree := NIL;
  WRITELN ('����஢�� 䠩�� ������ ��ॢ��.');
  REPEAT
    WRITE ('������ ��� �室���� 䠩�� : ');
    READLN (infname); (* ����� � ���������� ��� �室���� 䠩�� *)
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
    READLN (outfname); (* ����� � ���������� ��� ��室���� 䠩�� *)
    ASSIGN (outfile, outfname);
    {$I-}
    REWRITE (outfile); (* ������ ��室��� 䠩� *)
    {$I+}
    IOR := IORESULT;
    IF (IOR <> 0) THEN
       WRITELN ('�� ���� ������ ��室��� 䠩�!');
  UNTIL (IOR = 0);

  gettime(h1,m1,s1,decs1);
  readfile (infile, tree); (* ����� �室��� 䠩� � ��ॢ� *)
  writefile (outfile, tree); (* ������� ��ॢ� � ���� ��� � ��室��� 䠩� *)
  gettime(h2,m2,s2,decs2);
  wtime:=(decs2+s2*100+m2*6000+h2*360000)-(decs1+s1*100+m1*6000+h1*360000);
  writeln('�६� ࠡ��� : ',(wtime/100):2:2);

  CLOSE (outfile); (* ������� ��室��� 䠩� *)
  CLOSE (infile); (* ������� �室��� 䠩� *)
END.
