  {$M 65520,0,0}
  Program LibrarySystem;

    Uses
       Crt,Dos,Overlay,Append,Delete{,Edit},List,Recall;

    (*{$O Append}
    {$O Delete}
    {$O List}
    {$O Recall}*)

    Var
       CH:Char;
       Menu,SubMenu:Byte;
       MFlag:Boolean;
       Switch:Word;

    Procedure Pointer(Cursor:Byte);
       Begin
          Case Cursor Of
             0:
              Begin
                 Asm
                    Mov ah,001h
                    Mov ch,00Eh
                    Mov cl,00Fh
                    Int 10h
                 End;
              End;
             1:
              Begin
                 Asm
                    Mov ah,001h
                    Mov ch,001h
                    Mov cl,000h
                    Int 10h
                 End;
              End;
          End;
       End;

    Procedure Fresh;

       Begin
          HighVideo;
          Window(1,1,80,25);
          TextColor(0);
          TextBackGround(4);
          ClrScr;
          GoToXY(28,1);
          Write(' Ù˛ü§Ûê ˆıü§Ûê ˘ÛÛê Ù®ì ');
          GoToXY(32,25);
          Write(' ˘˜ë°ìëóÓ Ùó®˛® ');
{          Write(#7);}
          Menu:=1;
          SubMenu:=1;
       End;

    Procedure TimeDisplay;

       Var
          H,M,S,HUND:Word;

       Function LeadingZero(W:Word):String;

          Var
             S:String;
                Begin
                   STR(W:0,S);
                   If Length(S)=1 Then S:='0'+S;
                   LeadingZero:=S;
                End;

          Begin
          While KeyPressed=False Do
          Begin
             TextBackGround(7);
             Window(4,2,15,2);
             GetTime(h,m,s,hund);
             TextColor(4);
             Write(LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),'.',LeadingZero(hund));
             TextColor(7);
          end;
          End;

    Procedure ReFresh;

       Procedure MakeMenu(A,B,C,D,E:String;Row1,Column1,Row2,Column2:Byte);

          Var
             Item:String;
             Counter,UL,DR:Byte;

          Procedure MakeSubMenu(Items:Byte;S1,S2,S3,S4,S5,S6,S7:String;Column1,Row1,Column2,Row2:Byte);

          Procedure MakeSub(S,SS:String;C1,R1,C2,R2:Byte);

             Var
                Counter,Row:Byte;
                X:String;

             Begin
                TextColor(1);
                TextBackground(7);
                Window(C1,R1,C2,R2);
                ClrScr;
                X:='ƒ';
                For Counter:=C1+2 To C2-3 Do
                   x:=x+'ƒ';
                Write(' ⁄',X,'ø ');
                Write(' ≥',X,'≥ ');
                Write(' ≥',X,'≥ ');
                Write(' ¿',X,'Ÿ');
                Case MFlag Of
                   False:
                        Begin
                           Window(C1+2,R1+2,C2-1,R1+2);
                           Write(SS);
                           TextColor(10);
                           TextBackground(6);
                           Window(C1+2,R1+1,C2-1,R1+1);
                           Write(S);
                        End;
                   True:
                       Begin
                           Window(C1+2,R1+1,C2-1,R1+1);
                           Write(S);
                           TextColor(10);
                           TextBackground(6);
                           Window(C1+2,R1+2,C2-1,R1+2);
                           Write(SS);
                       End;
                End;
             End;

          Var
             Counter,Row:Byte;
             x:String;
             Sub,SMItem:Array[1..7] Of String;

             Begin
                SMItem[1]:=S1;
                SMItem[2]:=S2;
                SMItem[3]:=S3;
                SMItem[4]:=S4;
                SMItem[5]:=S5;
                SMItem[6]:=S6;
                SMItem[7]:=S7;
                If SubMenu=0 Then SubMenu:=Items;
                If SubMenu>Items Then SubMenu:=1;
                For Counter:=1 To Items Do
                   Begin
                      Sub[Counter]:=Copy(SMItem[Counter],1,1);
                      If (SMItem[Counter]='ƒ') And (SubMenu=Counter) Then
                         Case CH Of
                            #72:
                               Begin
                                  Counter:=Counter-1;
                                  SubMenu:=SubMenu-1;
                               End;
                            #80:SubMenu:=SubMenu+1;
                         End;
                      If (Sub[Counter]='') AND (SubMenu=Counter) Then
                         Case Menu Of
                            1:
                             Begin
                                Case SubMenu Of
                                   3:MakeSub(' ¸óÏ¯ı ','  ¸„ØÏ ',51,5,61,8);
                                   6:MakeSub(' ¸˛•õ ','  ¸ÛÓ ',52,8,61,11);
                                End;
                             End;
                            2:
                             Begin
                                Case SubMenu Of
                                   3:MakeSub(' ¸óÏ¯ı ','  ¸„ØÏ ',44,5,54,8);
                                   6:MakeSub(' ¸˛•õ ','  ¸ÛÓ ',45,8,54,11);
                                End;
                             End;
                            5:MakeSub(' Ù§ ',' ¢§® ',13,6,21,9);
                         End;
                   End;
                TextColor(1);
                TextBackground(7);
                Window(Column1,Row1,Column2,Row2);
                ClrScr;
                X:='ƒ';
                For Counter:=Column1+2 To Column2-3 Do
                   x:=x+'ƒ';
                Write(' ⁄',X,'ø ');
                For Counter:=Row1+1 To Row2-1 Do
                   Write(' ≥',X,'≥ ');
                   Write(' ¿',X,'Ÿ');
                For Counter:=1 To Items Do
                   Begin
                      Case Counter Of
                         1:Row:=Row1+1;
                         2:Row:=Row+1;
                         3:Row:=Row+1;
                         4:Row:=Row+1;
                         5:Row:=Row+1;
                         6:Row:=Row+1;
                         7:Row:=Row+1;
                      End;
                      If SMItem[Counter]<>'ƒ' Then
                         Begin
                            If SubMenu<>Counter Then
                               Begin
                                  TextColor(1);
                                  TextBackground(7);
                               End
                            Else
                               Begin
                                  TextColor(10);
                                  TextBackground(6);
                               End;
                            Window(Column1+2,Row,Column2-1,Row);
                            Write(SMItem[Counter]);
                            If Sub[Counter]='' Then
                               Begin
                                  GoToXY(1,1);
                                  TextColor(1);
                                  TextBackground(7);
                                  Write('');
                               End;
                         End
                      Else
                         Begin
                            TextColor(1);
                            TextBackground(7);
                            Window(Column1,Row,Column2,Row);
                            Write(' √',X,'¥');
                         End;
                   End;
             End;

          Begin
             TextBackGround(7);
             Window(3,2,78,2);
             ClrScr;
             Window(3,24,78,24);
             ClrScr;
             Case Menu Of
                0:Menu:=5;
                6:Menu:=1;
             End;
             For Counter:=5 DownTo 1 Do
                Begin
                   Case Counter Of
                      5:
                       Begin
                         Item:=E;
                         UL:=Column1;
                         DR:=UL+Length(E);
                       End;
                      4:
                       Begin
                         Item:=D;
                         UL:=DR;
                         DR:=UL+Length(D);
                       End;
                      3:
                       Begin
                         Item:=C;
                         UL:=DR;
                         DR:=UL+Length(C);
                       End;
                      2:
                       Begin
                         Item:=B;
                         UL:=DR;
                         DR:=UL+Length(B);
                       End;
                      1:
                       Begin
                         Item:=A;
                         UL:=DR;
                         DR:=UL+Length(A);
                       End;
                   End;
                   If Menu<>Counter Then
                      Begin
                         TextColor(1);
                         TextBackground(7);
                      End
                   Else
                   Begin
                      TextColor(10);
                      TextBackground(6);
                   End;
                   Window(UL,Row1,DR,Row2);
                   Write(Item);
                End;
             Case Menu Of
                1:MakeSubMenu(7,'    Ìê§ó™ê ','    ©˛ê§˛¯ ','      È£ü ','   ¸ìë˛•ëì ','ƒ','     ñ®˛Û ',' ˆë¢™ È£ü ',61,3,
                  75,11);
                2:MakeSubMenu(7,'      ¢˛¢õ ','    ©˛ê§˛¯ ','      È£ü ','   ¸ìë˛•ëì ','ƒ','     ñ®˛Û ',' ˆë¢™ È£ü ',54,3,
                  68,11);
                3:MakeSubMenu(6,'   ¸•ë® ¸ô˜° ','ƒ','     ñê§˛˛Áó ','ƒ',' Dos Version ','        Ì®˛¢ ','',46,3,62,10);
                4:MakeSubMenu(2,' ¸ÓıÓ ñë‰ÚØê ','  ... ˘§ëì§¢ ','','','','','',39,3,55,6);
                5:MakeSubMenu(5,' Tab               DOS ',' Shift+Tab       Shell ','ƒ','              ReStart ',
                  '             Shut Down ','','',21,3,47,9);
             End;
          End;

       Begin
          Pointer(1);
          Window(3,3,78,24);
          TextBackGround(2);
          ClrScr;
          MakeMenu(' Ì§ó™ı ',' íëóÓ ',' Ùó®˛® ',' ëı˜˚ê§ ',' ö¯§° ',2,42,2,75);
       End;

    Procedure Shell;

       Begin
          TextColor(7);
          TextBackGround(0);
          Window(1,1,80,25);
          NormVideo;
          ClrScr;
          Pointer(0);
          WriteLN('...¢˛˜Ó î˛ëó ê§ ~eXit~ ñ™•ëì ¸ê§ì');
          SwapVectors;
          Exec(GetEnv('COMSPEC'), '/C ' + '%COMSPEC%');
          SwapVectors;
          If DosError <> 0 Then
             Begin
                CLRSCR;
                Write(#7);
                Write('.˘¢ê¢ †§ ¸ÛÓ™ı COMMAND.COM ¸ıó®˛® Ò˛ëÍ ¸ê§õê §¢');
                ch:=readkey
             End;
          Fresh;
       End;

    Procedure XT;

       Begin
          TextBackGround(0);
          TextColor(7);
          Window(1,1,80,25);
          NormVideo;
          ClrScr;
          Halt
       End;

    Procedure About;

       Const
          SCROOLL=16;
          NUM=32;
          CAPS=64;

       Var
          BiosTSByte:Byte absolute $0040:$0017;
          Regs:Registers;

       Procedure SetFlag(Flag : byte);

          Begin
             BiosTSByte:=BiosTSByte or Flag;
             Regs.AH := 1;
             Intr($16, Regs);
          End;

       Procedure ClrFlag(Flag : byte);

          Begin
             BiosTSByte:=BiosTSByte and ( not Flag );
             Regs.AH := 1;
             Intr($16, Regs);
          End;

       Begin
          Window(1,1,80,25);
          TextBackGround(0);
          CLRSCR;
          Window(1,1,1,80);
          TextBackGround(0);
          CLRSCR;
          While KeyPressed<>True Do
             Begin
                SetFlag(CAPS or SCROOLL or NUM);
                TextColor(4);
                GoToXY(34,13);
                Writeln('¸éëìëì Î¢ë¨ ¢ıüı');
                Delay( 300 );
                ClrFlag(CAPS or SCROOLL or NUM);
                TextColor(8);
                GoToXY(34,13);
                Writeln('¸éëìëì Î¢ë¨ ¢ıüı');
                Delay( 300 );
             End;
          Readln;
          Fresh
       End;

    Procedure Key;

       Var
          RecFlag:Boolean;
          DelFlag:Boolean;
          TypeFlag:Boolean;
          RCFlag:Boolean;

       Begin
          TimeDisplay;
          CH:=ReadKey;
          Case CH Of
             #9:XT;
             #13:
                Begin
                   Pointer(0);
                   Case Menu Of
                      1:
                       Case SubMenu Of
                          1:APPND(True);
                          2:;
                          3:If MFlag=False Then DLT(True,False) Else DLT(True,True);
                          4:RCLL(True);
                          6:If MFlag=False Then LST(True,False) Else LST(True,True);
                       End;
                      2:
                       Case SubMenu Of
                          1:APPND(False);
                          2:;
                          3:If MFlag=False Then DLT(False,False) Else DLT(False,True);
                          4:RCLL(False);
                          6:If MFlag=False Then LST(False,False) Else LST(False,True);
                       End;
                      3:
                       Case SubMenu Of
                          1:;
                          2:;
                          3:;
                          4:;
                       End;
                      4:
                       Case SubMenu Of
                          1:;
                          2:About;
                       End;
                      5:
                       Case SubMenu Of
                          1:XT;
                          2:Shell;
                          4:
                           Case MFlag Of
                              False:
                                   Begin
                                      TextColor(7);
                                      TextBackGround(0);
                                      Window(1,1,80,25);
                                      NormVideo;
                                      ClrScr;
                                      Pointer(0);
                                      ASM
                                         Int 19h
                                      End;
                                   End;
                              True:
                                  ASM
                                     MOV AX,64
                                     PUSH AX
                                     POP DS
                                     MOV WORD PTR [00114],04660
                                     MOV AX,65535
                                     PUSH AX
                                     MOV AX,00000
                                     PUSH AX
                                     RETF
                                  End;
                           End;
                          5:
                           Begin
                              SwapVectors;
                              Exec(GetEnv('COMSPEC'), '/C ' + '%WINDIR%\RunDLL.exe %WINDIR%\User.exe,ExitWindows');
                              SwapVectors;
                              XT;
                           End;
                       End;
                   End;
                End;
             #15:Shell;
             #59:;
             #60:;
             #61:;
             #62:;
             #63:;
             #64:;
             #65:;
             #66:;
             #67:;
             #68:;
             #71:If MFlag=True Then MFlag:=False;
             #72:
                 Begin
                    MFlag:=False;
                    SubMenu:=SubMenu-1
                 End;
             #75:
                 Begin
                    Menu:=Menu+1;
                    SubMenu:=1
                  End;
             #77:
                Begin
                   Menu:=Menu-1;
                   SubMenu:=1
                End;
             #79:If MFlag=False Then MFlag:=True;
             #80:
                Begin
                   MFlag:=False;
                   SubMenu:=SubMenu+1
                End;
          Else Key;
          End;
          ReFresh;
          Key;
       End;

    Begin
       OvrInit('MASTER.OVR');
       OvrInitEMS;
       OvrSetBuf(OvrGetBuf);
{       For Switch:=1 To ParamCount Do
          Begin
             If ParamSTR(Switch)='/?' Then
                Begin
                   Readln;
                End;
             If ParamSTR(Switch)=''
          End;}
       Fresh;
       ReFresh;
       Key
    End.