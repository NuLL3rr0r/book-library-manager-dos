{$F+,O+}
 Unit Recall;

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

       Procedure RCLL(RCFlag:Boolean);

    Implementation

       Procedure RCLL(RCFlag:Boolean);

          Var
             Sharer_File:File Of SharerRec;
             Book_File:File Of BookRec;
             SHRR:SharerRec;
             BK:BookRec;
             STemp:String[4];
             BTemp:String[5];
             Position:0..99999;
             Attr:Word;

          Begin
             TextColor(0);
             TextBackGround(7);
             Window(3,3,78,24);
             ClrScr;
             Case RCFlag Of
                True:
                    Begin
                       Assign(Sharer_File,'Sharer.ˇ~ˇ');
                       GetFAttr(Sharer_File,Attr);
                       If DosError=2 Then ReWrite(Sharer_File) Else ReSet(Sharer_File);
                       Write('Ìê§ó™ê ˘§ëı™  :   ');
                       Readln(STemp);
                       Position:=0;
                       With SHRR Do
                          Begin
                             While Not Eof(Sharer_File) Do
                                Begin
                                   Read(Sharer_File,SHRR);
                                   Position:=Position+1;
                                   If STemp=Code Then
                                      Begin
                                         If Deleted=True Then
                                            Begin
                                               Deleted:=False;
                                               Seek(Sharer_File,Position-1);
                                               Write(Sharer_File,SHRR);
                                               Exit
                                            End;
                                         Write('Was Not Deleted');
                                         Exit
                                      End
                                End;
                             Write('Not Found')
                          End;
                    End;
                False:
                     Begin
                        Assign(Book_File,'Book.ˇ~ˇ');
                       GetFAttr(Book_File,Attr);
                       If DosError=2 Then ReWrite(Book_File) Else ReSet(Book_File);
                        Write('íëóÓ ¢Ó  :   ');
                        Readln(BTemp);
                        Position:=0;
                        With BK Do
                           Begin
                              While Not Eof(Book_File) Do
                                 Begin
                                    Read(Book_File,BK);
                                    Position:=Position+1;
                                    If BTemp=ID Then
                                       Begin
                                          If Deleted=True Then
                                             Begin
                                                Deleted:=False;
                                                Seek(Book_File,Position-1);
                                                Write(Book_File,BK);
                                                Exit
                                             End;
                                          Write('Was Not Deleted');
                                          Exit
                                       End
                                 End;
                              Write('Not Found')
                           End;
                     End;
             End;
          If RCFlag=True Then Close(Sharer_File) Else Close(Book_File);
          Readln
          End;
    End.