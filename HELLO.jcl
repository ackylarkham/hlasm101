//ASMLKGOA JOB MSGCLASS=Q,CLASS=A
//*********************************************************************
//*アセンブル、連係編集、実行ジョブ
//*********************************************************************
//*アセンブル
//ASM      EXEC PGM=ASMA90
//SYSLIB   DD  DSN=SYS1.MACLIB,DISP=SHR
//SYSUT1   DD  DSN=&&SYSUT1,SPACE=(CYL,(1,1)),
//             UNIT=SYSALLDA,DCB=BUFNO=1
//SYSPRINT DD  SYSOUT=*
//SYSLIN   DD  DSN=&&OBJ,SPACE=(CYL,(1,1)),
//             UNIT=SYSALLDA,DISP=(,PASS,DELETE),
//             DCB=(BLKSIZE=3040,LRECL=80,RECFM=FB,BUFNO=1)
//*プログラムをここに直打ち
//SYSIN    DD *
**********************************************************************
*プログラム名: HELLO
*処理概要: 
*　ジョブログにHELLO WORLDを出力する
**********************************************************************
R12      EQU   12
R13      EQU   13    
R14      EQU   14
R15      EQU   15

HELLO    CSECT
         
         STM   R14,R12,12(R13)  :呼び出し元のレジスターの内容を保管
         LR    R12,R15          :プログラムの先頭アドレスをR12にロード
         USING HELLO,R12        :ベースレジスターとしてR12を使用
         LR    R14,R13          :呼び出し元のR13を一時退避
         LA    R13,WKSAVE       :このプログラムの保管域のアドレスをロード
         ST    R14,4(R13)       :呼び出し元の保管域のアドレスを保管

         WTO '*** HELLO WORLD!!! ***'

         L     R13,4(R13)       :呼び出し元の保管域のアドレスを復元
         LM    R14,R12,12(R13)  :呼び出し元のレジスターを復元
         XR    R15,R15          :リターンコードにゼロをセット
         BR    R14              :呼び出し元に戻る

WKSAVE   DS    18F              :このプログラムのレジスター保管域

         END
/*
//*アセンブルが正常終了したら連係編集を行う
// IF RC = 0 THEN
//LKED     EXEC PGM=IEWBLINK,REGION=0M
//SYSPRINT DD   SYSOUT=*
//SYSLIN   DD   DSNAME=&&OBJ,DISP=(OLD,DELETE,DELETE)
//         DD   DDNAME=SYSIN
//SYSLMOD  DD   DSN=&&LOAD(BR14),DISP=(,PASS,DELETE),
//         SPACE=(CYL,(1,1,1)),
//         UNIT=SYSALLDA
//CEEDUMP  DD   DUMMY
//SYSUDUMP DD   DUMMY
//SYSIN    DD   *
/*
// ELSE
// ENDIF
//*連係編集が正常終了したら実行する
// IF RC = 0 THEN
//GO      EXEC PGM=BR14
//STEPLIB  DD DSN=&&LOAD,DISP=(OLD,DELETE,DELETE)
//SYSOUT   DD SYSOUT=*
//CEEDUMP  DD DUMMY
//SYSUDUMP DD DUMMY
// ELSE
// ENDIF