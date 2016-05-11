/* 循环执行加减法 */

.global _start   /*定义全局标号*/

.text            /*定义代码段*/
.equ num, 2      /* 程序执行的入口点 */

_start:

		mov r0, #0     /* 设置三个参数，r0选择调用哪个子程序 */
		mov r1, #3     /* r1为子程序要用的参数*/
		mov r2, #2    /* r2为子程序要用的参数*/
		bl  arithfunc   /* 调用子程序arithfunc，进行算术运算 */
                bl  arithfunc   /* 调用子程序arithfunc，进行算术运算 */

stop:
b  stop

#******************************************************************************
# 根据参数r0 的值跳转至相应的子程序 *
#******************************************************************************
arithfunc:    
		cmp r0, #num    /* 将r0的值与立即数2相减，并根据结果设置CPSR 的标志位 */
		bhs DoSub               /* 如果r0 >=2 的时候就跳转 */
		adr r3, JumpTable         /* 读取跳转表JumpTable的基地址给r3   */
		ldr  pc, [r3,r0,lsl#2]       /* 以存储器地址为[R3 + R0 << 2]的字数据作为操作数的有效地址，将取得的操作数存入寄存器PC中并跳转至相应的子程序 */
JumpTable:               /* 定义跳转表的首地址 */
		.long DoAdd      /* 当参数r0的值为0时，上面的代码将选择DoAdd */
		.long DoSub      /* 当参数r0的值为1时，上面的代码将选择DoSub */
DoAdd:
		add r0, r1, r2     /* r0 <- r1+r2 */
		mov pc, lr       /* 子程序返回*/
DoSub:
		sub r0, r1, r2    /* r0 <- r1-r2  */
		mov pc,lr       /* 子程序返回 */
		.end           /* mark the end of this file */