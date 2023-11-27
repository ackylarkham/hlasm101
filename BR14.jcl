/ASMCLG JOB MSGCLASS=Q,CLASS=ASM
//*********************************************************************
//*アセンブル、連係編集、実行ジョブ
//*********************************************************************
//*アセンブル
//ASM      EXEC PGM=ASMA90
//SYSLIB   DD  DSN=SYS1.MACLIB,DISP=SHR
//SYSUT1   DD  DSN=&&SYSUT1,SPACE=(4096,(120,120),,,ROUND),
//             UNIT=SYSALLDA,DCB=BUFNO=1
//SYSPRINT DD  SYSOUT=*
//SYSLIN   DD  DSN=&&OBJ,SPACE=(3040,(40,40),,,ROUND),
//             UNIT=SYSALLDA,DISP=(MOD,PASS),
//             DCB=(BLKSIZE=3040,LRECL=80,RECFM=FB,BUFNO=1)
//*プログラムをここに直打ち
//SYSIN    DD *
********************************************************************
*プログラム名: BR14
*処理概要: 
*　呼び出し元にリターンコードをゼロに設定して戻る
********************************************************************
R14      EQU   14          :レジスター14
R15      EQU   15          :レジスター15

BR14     CSECT

         XR    R15,R15     :リターンコード(レジスター15)をクリア

         BR    R14         :呼び出し元へ戻る

         END
/*
//*アセンブルが正常終了したら連係編集を行う
// IF RC= 0 THEN
//LKED     EXEC PGM=IEWBLINK,REGION=0M
//SYSPRINT DD  SYSOUT=*
//SYSLIN   DD  DSNAME=&&OBJ,DISP=(OLD,DELETE)
//         DD  DDNAME=SYSIN
//SYSLMOD  DD DSN=&SYSUID..LOAD(BR14),DISP=SHR
//CEEDUMP  DD DUMMY
//SYSUDUMP DD DUMMY
// ELSE
// ENDIF
//*連係編集が正常終了したら実行する
// IF RC = 0 THEN
//RUN      EXEC PGM=BR14
//STEPLIB  DD DSN=&SYSUID..LOAD,DISP=SHR
//SYSOUT   DD SYSOUT=*,OUTLIM=15000
//CEEDUMP  DD DUMMY
//SYSUDUMP DD DUMMY
// ELSE
// ENDIF