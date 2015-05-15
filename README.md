# ballin-octo-cyril

[![Join the chat at https://gitter.im/jigkoxsee/ballin-octo-cyril](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jigkoxsee/ballin-octo-cyril?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
Compiler construct - assignment 4

# ตัวอย่างไวยากรณ์ภาษา 

###ตัวแปร : 

มีให้ 52 ตัว มี $a ถึง $z และ $A ถึง $Z
###ตัวดำเนินการ:

```
 + - * / % ( )
```

###การกำหนดค่า : 
เลขฐานสิบ $a = 10 เลขฐานสิบหก $a = 0xA 

###คำสั่งแสดงค่า : 
เลขฐานสิบ show $a เลขฐานสิบหก showx $a

###คำสั่งตัดสินใจ : 
```
if $a == $b  
	//do something
endif
```

คำสั่งวนซ้ำ :
```
 	loop start:end 
	//do something
end
```

ตัวอย่าง : หาผลรวมจาก 1 - 50 

```
loop 1:50:1
	$i = $i +1 
    $a = $a + $i 
end
show $a
```

### Grammar
```
Input:
     | Input Line
;

Line:
  ENDLN
  | Ifstm
  | Loopstm
  | Stms
  | Display
  | Condition
  | error { yyerror("oops\n"); }
;


Oprn:
  VAR
  | CONST
;

Condition:
  Oprn EQ Oprn { printf("CONDITION\n");}
;

Ifstm:
  IF Condition ENDLN
  Stms
  ENDIF ENDLN
;

Stm:
  VAR ASSIGN Exp
;

Stms:
  Stm ENDLN
  | Stm ENDLN Stms
;

Exp:
  CONST
  | VAR
  | Exp PLUS Exp
  | Exp MINUS Exp
  | Exp TIMES Exp
  | Exp DIVIDE Exp
  | Exp MOD Exp
  | MINUS Exp %prec NEG
  | LEFT Exp RIGHT
;

Loopstm:
  LOOP CONST COLON CONST ENDLN
  Stms
  END ENDLN
;

Display:
  SHOW VAR
  | SHOWX VAR
;
```
