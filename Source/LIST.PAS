{$F+,O+}
 Unit List;

    InterFace

       Uses Crt,Dos;

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

       Procedure LST(LSTFlag,TypeFlag:Boolean);

    Implementation

       Procedure LST(LSTFlag,TypeFlag:Boolean);

          Var
             Sharer_File:File Of SharerRec;
             Book_File:File Of BookRec;
             SHRR:SharerRec;
             BK:BookRec;
             STemp:String[4];
             BTemp:String[5];
             CH:Char;
             Attr:Word;

          Begin
             TextColor(0);
             TextBackGround(7);
             Window(3,3,78,24);
             ClrScr;
             Case LSTFlag Of
                True:
                    Begin
                       Assign(Sharer_File,'Sharer.ÿ~ÿ');
                       GetFAttr(Sharer_File,Attr);
                       If DosError=2 Then ReWrite(Sharer_File) Else ReSet(Sharer_File);
                       Seek(Sharer_File,1);
                       With SHRR Do
                          Begin
                             Case TypeFlag Of
                                False:
                                     Begin
                                        While Not Eof(Sharer_File) Do
                                           Begin
                                              Read(Sharer_File,SHRR);
                                              If Deleted=False Then
                                                 Begin
                                                    Writeln('í¤—ª ù¤‘õª    :   ',Code);
                                                    Writeln('ô‘÷             :   ',Name);
                                                    Writeln('üğ¢ø÷‘¡ ô‘÷    :   ',Family);
                                                    Writeln('ùõ‘÷¨‘÷ª ù¤‘õª  :   ',SH_SH);
                                                    Writeln('¤¢• ô‘÷         :   ',Father);
                                                    Writeln('¢óø— ñ‘¨        :   ',BirthYear);
                                                    Writeln('¢óø— ñŸõ        :   ',BirthPlace);
                                                    Writeln('');
                                                    CH:=ReadKey;
                                                 End;
                                              If CH=#27 Then Exit
                                           End;
                                     End;
                                True:
                                    Begin
                                       Write('í¤—ª ù¤‘õª  :   ');
                                       Readln(STemp);
                                          While Not EOF(Sharer_File) Do
                                             Begin
                                                Read(Sharer_File,SHRR);
                                                If STemp=Code Then
                                                   Begin
                                                      ClrScr;
                                                      Writeln('í¤—ª ù¤‘õª  :   ',Code);
                                                      Writeln('ô‘÷  :   ',Name);
                                                      Writeln('üğ¢ø÷‘¡ ô‘÷  :   ',Family);
                                                      Writeln('ùõ‘÷¨‘÷ª ù¤‘õª  :   ',SH_SH);
                                                      Writeln('¤¢• ô‘÷  :   ',Father);
                                                      Writeln('¢óø— ñ‘¨  :   ',BirthYear);
                                                      Writeln('¢óø— ñŸõ  :   ',BirthPlace);
                                                      Readln;
                                                      Exit
                                                   End;
                                                Writeln('Not Found')
                                             End
                                    End
                             End
                          End
                    End;
                False:
                     Begin
                       Assign(Book_File,'Book.ÿ~ÿ');
                       GetFAttr(Book_File,Attr);
                       If DosError=2 Then ReWrite(Book_File) Else ReSet(Book_File);
                       Seek(Book_File,1);
                       With BK Do
                          Begin
                             Case TypeFlag Of
                                False:
                                     Begin
                                        While Not Eof(Book_File) Do
                                           Begin
                                              Read(Book_File,BK);
                                              If Deleted=False Then
                                                 Begin
                                                    Writeln('’‘—î ¢î  :   ',ID);
                                                    Writeln('’‘—î ô‘÷  :   ',Book);
                                                    Writeln('ù¢÷¨şø÷  :   ',Writer);
                                                    Writeln('”‘ –“ø÷  :   ',Printed);
                                                    Writeln('”‘ ñ‘¨  :   ',PrintedYear);
                                                    Writeln('¦¤ş—  :   ',NUM);
                                                    Writeln('”‘ –‘ãê¢  :   ',NUMOfPrinted);
                                                    Writeln('¤ª‘÷  :   ',Publisher);
                                                    Writeln('í“‘ª  :   ',ISBN);
                                                    Writeln('');
                                                    CH:=ReadKey;
                                                 End;
                                              If CH=#27 Then Exit
                                           End;
                                     End;
                                True:
                                    Begin
                                       Write('’‘—î ¢î  :   ');
                                       Readln(BTemp);
                                       While Not EOF(Book_File) Do
                                          Begin
                                             Read(Book_File,BK);
                                             If BTemp=ID Then
                                                Begin
                                                   ClrScr;
                                                   Writeln('’‘—î ¢î  :   ',ID);
                                                   Writeln('’‘—î ô‘÷  :   ',Book);
                                                   Writeln('ù¢÷¨şø÷  :   ',Writer);
                                                   Writeln('”‘ –“ø÷  :   ',Printed);
                                                   Writeln('”‘ ñ‘¨  :   ',PrintedYear);
                                                   Writeln('¦¤ş—  :   ',NUM);
                                                   Writeln('”‘ –‘ãê¢  :   ',NUMOfPrinted);
                                                   Writeln('¤ª‘÷  :   ',Publisher);
                                                   Writeln('í“‘ª  :   ',ISBN);
                                                   Readln;
                                                   Exit
                                                End
                                          End;
                                       Writeln('Not Found')
                                    End
                             End
                          End
                     End
             End;
          If LSTFlag=True Then Close(Sharer_File) Else Close(Book_File);
          Readln
          End;

    End.