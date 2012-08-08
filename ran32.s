* ran32
* Author: Daniel Lidström
* Date: 010724
* Program produces strings in the following format:
* 0xhhhhhhhh where h is a random hex digit
* I needed the digits in a C++ program I was writing at
* the time.
::
 %RAN		( %random )
 % 4294967296	( 2^32 )
 %*
 %>#		( hxs random )
 $ "0x        "
 TOTEMPSWAP
* $ hxs ->
 CODE
	GOSBVL	=PopASavptr	A[A]->#, pointers saved
	D0=A
	D0=D0+	10		D0->hex digits
	A=DAT0	8		A[8] = hex digits
* save in high A
	P=	16-8		loop 8 times
-	ASRC			shift A right circular (saves 1 digit)
	P=P+1
	GONC	-		continue until P = 0
	C=DAT1	A
	D1=C			D1->$
	D1=D1+	10+2*2		D1->first space in $
	LC(3)	#278	
	CSRC			now, C[S] = 8 and C[B] = 32 + 7
	D=C	B		D[B] = 32 + 7
* Convert each digit to ascii, make sure letters are small: a,b,c,d,e,f
--	LC(2)	#39
	A=0	B
	ASLC
	CAEX	P
	?C<=A	P		less than #A?
	GOYES	+ >-----+	yes
	C=C+D	B	|	add constant to make lowercase
+	DAT1=C	B <-----+	write digit
	D1=D1+	2		D1->next
	C=C+1	S		continue until C[S] = 0
	GONC	--
	GOVLNG	=GETPTRLOOP	restore pointers
ENDCODE
;