 .data
msg_s:	.asciiz "\nSuccess! Location: "
msg_f:	.asciiz "\nFail!\r\n"
s_end:	.asciiz "\n"
buf:	.space 50 			#缓存区大小50个字符

.text
main:	la $a0, buf 		#载入输入缓存区地址
		la $a1, 50		#最大读入50个字符
		li $v0, 8 			#系统调用：读入字符串
		syscall

input:	li $v0, 12 			#系统调用：读入字符
		syscall
		beq $v0, '?', exit	#如果为‘？’，退出
		la $t1, buf		#载入缓存区基址
		addi $t2, $zero, 1	#设置当先比较字符位置

find:		lb $t0, ($t1)		#读入第一个比较字符
		beq $t0, '\n', fail	#如果为“回车”键，则比较到底
		beq $t0, $v0, success	#如果相同则比较成功
		addi $t1, $t1, 1	#偏移地址加1
		addi $t2 $t2, 1		#比较位置加1
		j find			#进行下一次比较

success:	la $a0, msg_s		#输出成功信息
		li $v0, 4 
		syscall
		move $a0, $t2
		li $v0, 1 
		syscall
		la $a0, s_end
		li $v0, 4
		syscall
		j input

fail:		la $a0, msg_f		#输入失败信息
		li $v0, 4
		syscall
		j input

exit:		li $v0, 10
		syscall