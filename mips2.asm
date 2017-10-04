 .data
msg_s:	.asciiz "\nSuccess! Location: "
msg_f:	.asciiz "\nFail!\r\n"
s_end:	.asciiz "\n"
buf:	.space 50 			#��������С50���ַ�

.text
main:	la $a0, buf 		#�������뻺������ַ
		la $a1, 50		#������50���ַ�
		li $v0, 8 			#ϵͳ���ã������ַ���
		syscall

input:	li $v0, 12 			#ϵͳ���ã������ַ�
		syscall
		beq $v0, '?', exit	#���Ϊ���������˳�
		la $t1, buf		#���뻺������ַ
		addi $t2, $zero, 1	#���õ��ȱȽ��ַ�λ��

find:		lb $t0, ($t1)		#�����һ���Ƚ��ַ�
		beq $t0, '\n', fail	#���Ϊ���س���������Ƚϵ���
		beq $t0, $v0, success	#�����ͬ��Ƚϳɹ�
		addi $t1, $t1, 1	#ƫ�Ƶ�ַ��1
		addi $t2 $t2, 1		#�Ƚ�λ�ü�1
		j find			#������һ�αȽ�

success:	la $a0, msg_s		#����ɹ���Ϣ
		li $v0, 4 
		syscall
		move $a0, $t2
		li $v0, 1 
		syscall
		la $a0, s_end
		li $v0, 4
		syscall
		j input

fail:		la $a0, msg_f		#����ʧ����Ϣ
		li $v0, 4
		syscall
		j input

exit:		li $v0, 10
		syscall