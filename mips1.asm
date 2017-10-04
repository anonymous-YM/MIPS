.data  					#数据段
A: 	.asciiz "Alpha " 		#大写字母字符串
BB: 	.asciiz "Bravo "
C: 	.asciiz "China "
D: 	.asciiz "Delta "
E: 	.asciiz "Echo "
F: 	.asciiz "Foxtrot "
G: 	.asciiz "Golf "
H: 	.asciiz "Hotel "
I: 	.asciiz "India "
JJ: 	.asciiz "Juliet "
K: 	.asciiz "Kilo "
L: 	.asciiz "Lima "
M: 	.asciiz "Mary "
N: 	.asciiz "November "
O: 	.asciiz "Oscar "
P: 	.asciiz "Paper "
Q: 	.asciiz "Quebec "
R: 	.asciiz "Research "
S: 	.asciiz "Sierra "
T: 	.asciiz "Tango "
U: 	.asciiz "Uniform "
V: 	.asciiz "Victor "
W: 	.asciiz "Whisky "
X: 	.asciiz "X-ray "
Y: 	.asciiz "Yankee "
Z: 	.asciiz "Zulu "
zero: 	.asciiz "zero "    	#数字字符串
one: 	.asciiz "First "
two: 	.asciiz "Second "
three: 	.asciiz "Third "
four: 	.asciiz "Fourth "
five: 	.asciiz "Fifth "
six: 		.asciiz "Sixth "
seven: 	.asciiz "Seventh "
eight: 	.asciiz "Eighth "
nine: 	.asciiz "Ninth "
other: 	.asciiz "* "   		#其他为星号
	
alphabet: .word A, BB, C, D, E, F, G, H, I, JJ, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z 	#字母索引表(B与J为指令，因此需双写)
number: .word zero, one, two, three, four, five, six, seven, eight, nine 	#数字索引表
	
.text  					#代码段
main:	li $v0, 12		
		syscall			#系统调用：输入一个字符
		beq $v0, '?', exit	#若为‘？’退出
		blt $v0, '0', Pother	#小于‘0’跳转至其他字符
		ble $v0, '9', Pnum	#‘0’-‘9’跳转至数字
		blt $v0, 'A', Pother	#以下同理
		ble $v0, 'Z', PUalpha
		blt $v0, 'a', Pother
		ble $v0, 'z', PLalpha
	
Pother:	la $a0, other		#载入‘*’的地址
		j Print

PLalpha:	li $t0, 'a'			#小写字母以‘a’为基准
		j Lookup
PUalpha:	li $t0, 'A'			#大写字母以‘A’为基准
Lookup:	la $t1, alphabet	
		sub $t0, $v0, $t0	#算出在字母表中的顺序
		mul $t0, $t0, 4 	#计算偏移地址=顺序*4
		add $t0, $t0, $t1	#与字母表基址相加
		lw $a0, ($t0)		#查表
		sb $v0, ($a0)		#将字符串的第一个字母替换为输入字母
		j Print
	
Pnum:	li $t0, '0'			#与上同理
		la $t1, number
		sub $t0, $v0, $t0
		mul $t0, $t0, 4 	
		add $t0, $t0, $t1
		lw $a0, ($t0)
	
Print:	li $v0, 4 			#系统调用：打印字符串
 		syscall  
 		j main
 	
exit:  	li $v0, 10			#系统调用：退出
 		syscall
