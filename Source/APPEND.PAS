{$F+,O+}
 Unit Append;

    InterFace

       Uses
          Crt,Dos;

       Type
          SharerRec=Record
	     Code:String[4];
             Name:String[15];
             Family:String[25];
             SH_SH:Longint;
             Father:String[15];
	     BirthYear:0..99;
	     BirthPlace:String[30];
             Deleted:Boolean
          End;
          BookRec=Record
	     ID:String[5];
             Book:String[20];
             Writer:String[40];
	     Printed:Byte;
	     PrintedYear:0..99;
	     NUM:Word;
	     NUMOfPrinted:Byte;
	     Publisher:String[30];
	     ISBN:String[17];
             Deleted:Boolean
          End;

       Procedure APPND(RecFlag:Boolean);

    Implementation

       Procedure APPND(RecFlag:Boolean);

          Var
             Sharer_File:File Of SharerRec;
             Book_File:File Of BookRec;
             SHRR:SharerRec;
             BK:BookRec;
             STemp:String[4];
             BTemp:String[5];
             Attr:Word;
             CH:Char;

          Begin
             TextColor(0);
             TextBackGround(7);
             Window(3,2,78,24);
             ClrScr;
             Case RecFlag Of
                True:
                    Begin
                       Assign(Sharer_File,'Sharer.ÿ~ÿ');
                       GetFAttr(Sharer_File,Attr);
                       If DosError=2 Then ReWrite(Sharer_File) Else ReSet(Sharer_File);
                       With SHRR Do
                          Begin
                             Write('í¤—ª ù¤‘õª    :   ');
                             Readln(Stemp);
                             Seek(Sharer_File,1);
                             While Not Eof(Sharer_File) Do
                                Begin
                                   Read(Sharer_File,SHRR);
                                   If Stemp=Code Then
                                      Begin
                                         Write('Already Exist');
                                         Readln;
                                         Exit
                                      End;
                                End;
                             Code:=STemp;
                             Write('ô‘÷             :   ');
                             Readln(Name);
                             Write('üğ¢ø÷‘¡ ô‘÷    :   ');
                             Readln(Family);
                             Write('ùõ‘÷¨‘÷ª ù¤‘õª  :   ');
                             Readln(SH_SH);
                             Write('¤¢• ô‘÷         :   ');
                             Readln(Father);
                             Write('¢óø— ñ‘¨        :   ');
                             Readln(BirthYear);
                             Write('¢óø— ñŸõ        :   ');
                             Readln(BirthPlace);
                             Deleted:=False;
                          End;
                          Write(Sharer_File,SHRR);
                          Close(Sharer_File);
                    End;
                False:
                     Begin
                        Assign(Book_File,'Book.ÿ~ÿ');
                        GetFAttr(Book_File,Attr);
                        If DosError=2 Then ReWrite(Book_File) Else ReSet(Book_File);
                        With BK Do
                           Begin
                              Write('’‘—î ¢î    :   ');
                              Readln(Btemp);
                              Seek(Book_File,1);
                              While Not Eof(Book_File) Do
                                 Begin
                                    Read(Book_File,BK);
                                    If Btemp=ID Then
                                       Begin
                                          Write('Already Exist');
                                          Readln;
                                          Exit
                                       End;
                                 End;
                              ID:=BTemp;
                              Write('’‘—î ô‘÷   :   ');
                              Readln(Book);
                              Write('ù¢÷¨şø÷    :   ');
                              Readln(Writer);
                              Write('”‘ –“ø÷   :   ');
                              Readln(Printed);
                              Write('”‘ ñ‘¨    :   ');
                              Readln(PrintedYear);
                              Write('¦¤ş—      :   ');
                              Readln(NUM);
                              Write('”‘ –‘ãê¢  :   ');
                              Readln(NUMOfPrinted);
                              Write('¤ª‘÷       :   ');
                              Readln(Publisher);
                              Write('í“‘ª       :   ');
                              Readln(ISBN);
                              Deleted:=False;
                           End;
                           Write(Book_File,BK);
                           Close(Book_File);
                     End;
             End;
             CH:=ReadKey;
             Case CH Of
                #32:APPND(RecFlag);
             End;
          End;
    End.