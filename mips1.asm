.data  					#���ݶ�
A: 	.asciiz "Alpha " 		#��д��ĸ�ַ���
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
zero: 	.asciiz "zero "    	#�����ַ���
one: 	.asciiz "First "
two: 	.asciiz "Second "
three: 	.asciiz "Third "
four: 	.asciiz "Fourth "
five: 	.asciiz "Fifth "
six: 		.asciiz "Sixth "
seven: 	.asciiz "Seventh "
eight: 	.asciiz "Eighth "
nine: 	.asciiz "Ninth "
other: 	.asciiz "* "   		#����Ϊ�Ǻ�
	
alphabet: .word A, BB, C, D, E, F, G, H, I, JJ, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z 	#��ĸ������(B��JΪָ������˫д)
number: .word zero, one, two, three, four, five, six, seven, eight, nine 	#����������
	
.text  					#�����
main:	li $v0, 12		
		syscall			#ϵͳ���ã�����һ���ַ�
		beq $v0, '?', exit	#��Ϊ�������˳�
		blt $v0, '0', Pother	#С�ڡ�0����ת�������ַ�
		ble $v0, '9', Pnum	#��0��-��9����ת������
		blt $v0, 'A', Pother	#����ͬ��
		ble $v0, 'Z', PUalpha
		blt $v0, 'a', Pother
		ble $v0, 'z', PLalpha
	
Pother:	la $a0, other		#���롮*���ĵ�ַ
		j Print

PLalpha:	li $t0, 'a'			#Сд��ĸ�ԡ�a��Ϊ��׼
		j Lookup
PUalpha:	li $t0, 'A'			#��д��ĸ�ԡ�A��Ϊ��׼
Lookup:	la $t1, alphabet	
		sub $t0, $v0, $t0	#�������ĸ���е�˳��
		mul $t0, $t0, 4 	#����ƫ�Ƶ�ַ=˳��*4
		add $t0, $t0, $t1	#����ĸ���ַ���
		lw $a0, ($t0)		#���
		sb $v0, ($a0)		#���ַ����ĵ�һ����ĸ�滻Ϊ������ĸ
		j Print
	
Pnum:	li $t0, '0'			#����ͬ��
		la $t1, number
		sub $t0, $v0, $t0
		mul $t0, $t0, 4 	
		add $t0, $t0, $t1
		lw $a0, ($t0)
	
Print:	li $v0, 4 			#ϵͳ���ã���ӡ�ַ���
 		syscall  
 		j main
 	
exit:  	li $v0, 10			#ϵͳ���ã��˳�
 		syscall
