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
 	loop start:end:increment 
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
นับจำนวนเลขคู่จาก 1 - 100

```
loop 1:100:1
	$i = $i +1
$a = $i % 2
if $a == 0 
	$c = $c +1 
endif
end 
show $c 
```


