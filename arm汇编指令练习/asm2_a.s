/* 计算（x*2^8+y/2+1）+(y/2+z)/2的结果，并放入寄存器R2中 */
/*---------------------------------------------------------------------------------------*/

.equ x, 45              /* x=45 */
.equ y, 64              /* y=64 */
.equ z, 87              /* z=87 */
.equ stack_top, 0x1000  /* 定义栈顶指针指向0x1000 */
.global _start

/*----------------------------------------------------------------------------------------*/
/*  code */
/*----------------------------------------------------------------------------------------*/
.text 
_start:  
	mov r0, #x           /* 将x的值45存放到R0 */
	mov r0, r0, lsl #8      /* R0 = R0 << 8 （即将r0中的字数据乘上2的8次幂）*/
	mov r1, #y           /* 将y的值放入R1中 */
	add r2, r0, r1, lsr #1    /* R2 = (R1>>1) + R0 （将r1中的字数据除以2得到的值加上r0后存放的r2中）*/
	mov sp, #0x1000    /* 堆栈指针SP指向栈顶指针指向的地址0x1000 */
	str  r2, [sp]    /* 将r2中的字数据写入以SP为地址的存储器中,执行入栈操作 */
	mov r0, #z              /* 将z的值放入R0 */
	and r0, r0, #0xFF         /* 获取R0中字数据的低八位 */
	mov r1, #y              /* 将 y 的值 存放至R1 */
	add r2, r0, r1, lsr #1      /* R2 = (R1>>1) + R0 （将r1中的字数据除以2得到的值加上r0后存放的r2中）*/
	ldr  r0, [sp]             /* 将存储器地址为SP的字数据读入寄存器R0中 */
	mov r1, #0x01           /* 将 立即数1放入R1 中 */
	orr  r0, r0, r1           /* 将r0和r1进行逻辑或运算，并将结果放入r0 */
	mov r1, R2              /* 将r2的字数据存入R1 */
	add r2, r0, r1, lsr #1       /* R2 = (R1>>1) + R0 （将r1中的字数据除以2得到的值加上r0后存放的r2中）*/

stop:
        b  stop 
.end