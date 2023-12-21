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
