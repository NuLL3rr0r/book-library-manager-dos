{$F+,O+}
 Unit Delete;

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

       Procedure DLT(DelFlag,TypeFlag:Boolean);

    Implementation

       Procedure DLT(DelFlag,TypeFlag:Boolean);

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
             Case DelFlag Of
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
                                         Case TypeFlag Of
                                            False:
                                                 Begin
                                                    If Deleted=False Then
                                                       Begin
                                                          Deleted:=True;
                                                          Seek(Sharer_File,Position-1);
                                                          Write(Sharer_File,SHRR);
                                                          Exit
                                                       End;
                                                    Write('Already Deleted');
                                                    Readln;
                                                    Exit
                                                 End;
                                            True:
                                                Begin
                                                   Seek(Sharer_File,FileSize(Sharer_File)-1);
                                                   Read(Sharer_File,SHRR);
                                                   Seek(Sharer_File,Position-1);
                                                   Write(Sharer_File,SHRR);
                                                   Seek(Sharer_File,FileSize(Sharer_File)-1);
                                                   TRunCate(Sharer_File);
                                                   Exit
                                                End
                                         End
                                      End
                                End;
                             Write('Not Found');
                             Readln
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
                                          Case TypeFlag Of
                                             False:
                                                  Begin
                                                     If Deleted=False Then
                                                        Begin
                                                           Deleted:=True;
                                                           Seek(Book_File,Position-1);
                                                           Write(Book_File,BK);
                                                           Exit
                                                        End;
                                                    Write('Already Deleted');
                                                    Readln;
                                                    Exit
                                                 End;
                                             True:
                                                 Begin
                                                    Seek(Book_File,FileSize(Book_File)-1);
                                                    Read(Book_File,BK);
                                                    Seek(Book_File,Position-1);
                                                    Write(Book_File,BK);
                                                    Seek(Book_File,FileSize(Book_File)-1);
                                                    TRunCate(Book_File);
                                                    Exit
                                                 End
                                         End
                                      End
                                End;
                             Write('Not Found');
                             Readln
                          End;
                     End;
             End;
          If DelFlag=True Then Close(Sharer_File) Else Close(Book_File);
          End;
    End.