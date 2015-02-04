
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 b1 02 00 00       	call   1002ca <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 08 96 10 00       	mov    0x109608,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 a8 88 10 00 01 	cmpl   $0x1,0x1088a8(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 60 88 10 00       	add    $0x108860,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 31 04 00 00       	call   1004ec <run>

001000bb <interrupt>:
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(process_t *parent, void (*start_function)(void));

void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(process_t *parent, void (*start_function)(void));

void
interrupt(registers_t *reg)
{
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d 08 96 10 00    	mov    0x109608,%ebx
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(process_t *parent, void (*start_function)(void));

void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 06             	cmp    $0x6,%eax
  1000e1:	0f 87 e1 01 00 00    	ja     1002c8 <interrupt+0x20d>
  1000e7:	ff 24 85 a4 0a 10 00 	jmp    *0x100aa4(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
  1000f0:	89 43 20             	mov    %eax,0x20(%ebx)
  1000f3:	e9 c7 01 00 00       	jmp    1002bf <interrupt+0x204>
		run(current);
  1000f8:	b8 fc 88 10 00       	mov    $0x1088fc,%eax
  1000fd:	ba 01 00 00 00       	mov    $0x1,%edx
	
	pid_t pid = -1;
	pid_t i;
	
	for (i = 1; i < NPROCS; i++) {
		if (proc_array[i].p_state == P_EMPTY)
  100102:	83 38 00             	cmpl   $0x0,(%eax)
  100105:	74 0e                	je     100115 <interrupt+0x5a>
	// Finally, return the child's process ID to the parent.
	
	pid_t pid = -1;
	pid_t i;
	
	for (i = 1; i < NPROCS; i++) {
  100107:	42                   	inc    %edx
  100108:	83 c0 54             	add    $0x54,%eax
  10010b:	83 fa 10             	cmp    $0x10,%edx
  10010e:	75 f2                	jne    100102 <interrupt+0x47>
  100110:	83 ca ff             	or     $0xffffffff,%edx
  100113:	eb 6a                	jmp    10017f <interrupt+0xc4>
	}
	
	if (pid == -1)
		return pid;

	proc_array[pid].p_state = P_RUNNABLE;
  100115:	6b ea 54             	imul   $0x54,%edx,%ebp
	proc_array[pid].p_registers = parent->p_registers;
  100118:	b9 11 00 00 00       	mov    $0x11,%ecx
  10011d:	8d 73 04             	lea    0x4(%ebx),%esi
  100120:	8d 85 60 88 10 00    	lea    0x108860(%ebp),%eax
  100126:	89 c7                	mov    %eax,%edi
  100128:	83 c7 04             	add    $0x4,%edi
  10012b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	dest_stack_bottom = dest_stack_top + (src_stack_bottom - src_stack_top) /* YOUR CODE HERE: calculate based on the
  10012d:	8b b5 60 88 10 00    	mov    0x108860(%ebp),%esi
	
	if (pid == -1)
		return pid;

	proc_array[pid].p_state = P_RUNNABLE;
	proc_array[pid].p_registers = parent->p_registers;
  100133:	89 44 24 0c          	mov    %eax,0xc(%esp)
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
  100137:	8b 03                	mov    (%ebx),%eax
	}
	
	if (pid == -1)
		return pid;

	proc_array[pid].p_state = P_RUNNABLE;
  100139:	c7 85 a8 88 10 00 01 	movl   $0x1,0x1088a8(%ebp)
  100140:	00 00 00 
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	src_stack_bottom = src->p_registers.reg_esp;
  100143:	8b 4b 40             	mov    0x40(%ebx),%ecx
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	dest_stack_bottom = dest_stack_top + (src_stack_bottom - src_stack_top) /* YOUR CODE HERE: calculate based on the
  100146:	c1 e6 12             	shl    $0x12,%esi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
  100149:	83 c0 0a             	add    $0xa,%eax
  10014c:	c1 e0 12             	shl    $0x12,%eax
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	dest_stack_bottom = dest_stack_top + (src_stack_bottom - src_stack_top) /* YOUR CODE HERE: calculate based on the
  10014f:	8d b4 0e 00 00 28 00 	lea    0x280000(%esi,%ecx,1),%esi
				 other variables */;
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top-src_stack_bottom);
  100156:	57                   	push   %edi
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	dest_stack_bottom = dest_stack_top + (src_stack_bottom - src_stack_top) /* YOUR CODE HERE: calculate based on the
  100157:	29 c6                	sub    %eax,%esi
				 other variables */;
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top-src_stack_bottom);
  100159:	29 c8                	sub    %ecx,%eax
  10015b:	50                   	push   %eax
  10015c:	51                   	push   %ecx
  10015d:	56                   	push   %esi
  10015e:	89 54 24 18          	mov    %edx,0x18(%esp)
  100162:	e8 5d 04 00 00       	call   1005c4 <memcpy>
	dest->p_registers.reg_esp = dest_stack_bottom;
  100167:	8b 44 24 1c          	mov    0x1c(%esp),%eax
		return pid;

	proc_array[pid].p_state = P_RUNNABLE;
	proc_array[pid].p_registers = parent->p_registers;
	copy_stack(&proc_array[pid],parent);
	proc_array[pid].p_registers.reg_eax = 0;
  10016b:	83 c4 10             	add    $0x10,%esp
  10016e:	8b 54 24 08          	mov    0x8(%esp),%edx
  100172:	c7 85 80 88 10 00 00 	movl   $0x0,0x108880(%ebp)
  100179:	00 00 00 
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE) /* YOUR CODE HERE */;
	dest_stack_bottom = dest_stack_top + (src_stack_bottom - src_stack_top) /* YOUR CODE HERE: calculate based on the
				 other variables */;
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top-src_stack_bottom);
	dest->p_registers.reg_esp = dest_stack_bottom;
  10017c:	89 70 40             	mov    %esi,0x40(%eax)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10017f:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  100182:	83 ec 0c             	sub    $0xc,%esp
  100185:	ff 35 08 96 10 00    	pushl  0x109608
  10018b:	e8 5c 03 00 00       	call   1004ec <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  100190:	e8 f7 fe ff ff       	call   10008c <schedule>
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		//current->p_state = P_ZOMBIE;
		current->p_state = P_ZOMBIE;		
  100195:	a1 08 96 10 00       	mov    0x109608,%eax
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->p_waiting != 0)
  10019a:	8b 50 50             	mov    0x50(%eax),%edx
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		//current->p_state = P_ZOMBIE;
		current->p_state = P_ZOMBIE;		
		current->p_exit_status = current->p_registers.reg_eax;
  10019d:	8b 48 20             	mov    0x20(%eax),%ecx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		//current->p_state = P_ZOMBIE;
		current->p_state = P_ZOMBIE;		
  1001a0:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->p_waiting != 0)
  1001a7:	85 d2                	test   %edx,%edx
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		//current->p_state = P_ZOMBIE;
		current->p_state = P_ZOMBIE;		
		current->p_exit_status = current->p_registers.reg_eax;
  1001a9:	89 48 4c             	mov    %ecx,0x4c(%eax)
		if (current->p_waiting != 0)
  1001ac:	74 1a                	je     1001c8 <interrupt+0x10d>
		{
			proc_array[current->p_waiting].p_state = P_RUNNABLE;
  1001ae:	6b d2 54             	imul   $0x54,%edx,%edx
  1001b1:	c7 82 a8 88 10 00 01 	movl   $0x1,0x1088a8(%edx)
  1001b8:	00 00 00 
			proc_array[current->p_waiting].p_registers.reg_eax = current->p_exit_status;
  1001bb:	89 8a 80 88 10 00    	mov    %ecx,0x108880(%edx)
			current->p_state = P_EMPTY;
  1001c1:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		}
		//current->p_state = P_EMPTY;
		schedule();
  1001c8:	e8 bf fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001cd:	a1 08 96 10 00       	mov    0x109608,%eax
  1001d2:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001d5:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001d8:	83 f9 0e             	cmp    $0xe,%ecx
  1001db:	77 14                	ja     1001f1 <interrupt+0x136>
  1001dd:	3b 10                	cmp    (%eax),%edx
  1001df:	74 10                	je     1001f1 <interrupt+0x136>
		    || proc_array[p].p_state == P_EMPTY)
  1001e1:	6b d2 54             	imul   $0x54,%edx,%edx
  1001e4:	8d 8a 68 88 10 00    	lea    0x108868(%edx),%ecx
  1001ea:	8b 59 40             	mov    0x40(%ecx),%ebx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001ed:	85 db                	test   %ebx,%ebx
  1001ef:	75 09                	jne    1001fa <interrupt+0x13f>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  1001f1:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001f8:	eb 26                	jmp    100220 <interrupt+0x165>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  1001fa:	83 fb 03             	cmp    $0x3,%ebx
  1001fd:	75 12                	jne    100211 <interrupt+0x156>
		{
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001ff:	8b 92 ac 88 10 00    	mov    0x1088ac(%edx),%edx
			proc_array[p].p_state = P_EMPTY;
  100205:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
		if (p <= 0 || p >= NPROCS || p == current->p_pid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
		{
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  10020c:	89 50 20             	mov    %edx,0x20(%eax)
  10020f:	eb 0f                	jmp    100220 <interrupt+0x165>
			proc_array[p].p_state = P_EMPTY;
		}
		else
		{
			current->p_state = P_BLOCKED;
  100211:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
			proc_array[p].p_waiting = current->p_pid;
  100218:	8b 00                	mov    (%eax),%eax
  10021a:	89 82 b0 88 10 00    	mov    %eax,0x1088b0(%edx)
		}
		schedule();
  100220:	e8 67 fe ff ff       	call   10008c <schedule>
		schedule();*/
	}

	case INT_SYS_NEWTHREAD:
		// The 'sys_newthread' system call will create a new process as a new thread.				
		current->p_registers.reg_eax = do_newthread(current,(void(*)(void))current->p_registers.reg_eax);
  100225:	8b 1d 08 96 10 00    	mov    0x109608,%ebx
  10022b:	b8 a8 88 10 00       	mov    $0x1088a8,%eax
  100230:	31 d2                	xor    %edx,%edx
  100232:	8b 6b 20             	mov    0x20(%ebx),%ebp
{
	pid_t pid = -1;
	pid_t i;
	for (i  = 0; i < NPROCS; i++)
	{
		if (proc_array[i].p_state == P_EMPTY)
  100235:	83 38 00             	cmpl   $0x0,(%eax)
  100238:	74 0e                	je     100248 <interrupt+0x18d>
static pid_t
do_newthread(process_t *parent, void (*start_function)(void))
{
	pid_t pid = -1;
	pid_t i;
	for (i  = 0; i < NPROCS; i++)
  10023a:	42                   	inc    %edx
  10023b:	83 c0 54             	add    $0x54,%eax
  10023e:	83 fa 10             	cmp    $0x10,%edx
  100241:	75 f2                	jne    100235 <interrupt+0x17a>
  100243:	83 ca ff             	or     $0xffffffff,%edx
  100246:	eb 2d                	jmp    100275 <interrupt+0x1ba>
		}
	}
	if (pid == -1)
		return pid;
	
	proc_array[pid].p_state = P_RUNNABLE;
  100248:	6b c2 54             	imul   $0x54,%edx,%eax
	proc_array[pid].p_registers = parent->p_registers;
  10024b:	b9 11 00 00 00       	mov    $0x11,%ecx
  100250:	8d 73 04             	lea    0x4(%ebx),%esi
  100253:	8d b8 64 88 10 00    	lea    0x108864(%eax),%edi
		}
	}
	if (pid == -1)
		return pid;
	
	proc_array[pid].p_state = P_RUNNABLE;
  100259:	c7 80 a8 88 10 00 01 	movl   $0x1,0x1088a8(%eax)
  100260:	00 00 00 
	proc_array[pid].p_registers = parent->p_registers;
  100263:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	proc_array[pid].p_registers.reg_eip = (int) start_function;
  100265:	89 a8 94 88 10 00    	mov    %ebp,0x108894(%eax)
	proc_array[pid].p_registers.reg_eax = 0;
  10026b:	c7 80 80 88 10 00 00 	movl   $0x0,0x108880(%eax)
  100272:	00 00 00 
		schedule();*/
	}

	case INT_SYS_NEWTHREAD:
		// The 'sys_newthread' system call will create a new process as a new thread.				
		current->p_registers.reg_eax = do_newthread(current,(void(*)(void))current->p_registers.reg_eax);
  100275:	89 53 20             	mov    %edx,0x20(%ebx)
  100278:	eb 45                	jmp    1002bf <interrupt+0x204>
		run(current);

	case INT_SYS_KILL: {
		// The 'sys_kill' system call will kill a targeted process.				
		
		pid_t p = current->p_registers.reg_eax;	
  10027a:	8b 43 20             	mov    0x20(%ebx),%eax
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  10027d:	8d 50 ff             	lea    -0x1(%eax),%edx
  100280:	83 fa 0e             	cmp    $0xe,%edx
  100283:	77 14                	ja     100299 <interrupt+0x1de>
  100285:	3b 03                	cmp    (%ebx),%eax
  100287:	74 10                	je     100299 <interrupt+0x1de>
		    || proc_array[p].p_state == P_EMPTY)
  100289:	6b c0 54             	imul   $0x54,%eax,%eax
  10028c:	8d 90 68 88 10 00    	lea    0x108868(%eax),%edx
  100292:	8b 4a 40             	mov    0x40(%edx),%ecx

	case INT_SYS_KILL: {
		// The 'sys_kill' system call will kill a targeted process.				
		
		pid_t p = current->p_registers.reg_eax;	
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100295:	85 c9                	test   %ecx,%ecx
  100297:	75 09                	jne    1002a2 <interrupt+0x1e7>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  100299:	c7 43 20 ff ff ff ff 	movl   $0xffffffff,0x20(%ebx)

	case INT_SYS_KILL: {
		// The 'sys_kill' system call will kill a targeted process.				
		
		pid_t p = current->p_registers.reg_eax;	
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1002a0:	eb 1d                	jmp    1002bf <interrupt+0x204>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state != P_ZOMBIE)
  1002a2:	83 f9 03             	cmp    $0x3,%ecx
  1002a5:	74 11                	je     1002b8 <interrupt+0x1fd>
		{
			proc_array[p].p_state = P_ZOMBIE;
  1002a7:	c7 42 40 03 00 00 00 	movl   $0x3,0x40(%edx)
			proc_array[p].p_exit_status = -1;
  1002ae:	c7 80 ac 88 10 00 ff 	movl   $0xffffffff,0x1088ac(%eax)
  1002b5:	ff ff ff 
			current->p_registers.reg_eax = 0;
		}
		else
			current->p_registers.reg_eax = 0;
  1002b8:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
	
		run(current);
  1002bf:	83 ec 0c             	sub    $0xc,%esp
  1002c2:	53                   	push   %ebx
  1002c3:	e9 c3 fe ff ff       	jmp    10018b <interrupt+0xd0>
  1002c8:	eb fe                	jmp    1002c8 <interrupt+0x20d>

001002ca <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002ca:	53                   	push   %ebx
  1002cb:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002ce:	68 40 05 00 00       	push   $0x540
  1002d3:	6a 00                	push   $0x0
  1002d5:	68 60 88 10 00       	push   $0x108860
  1002da:	e8 49 03 00 00       	call   100628 <memset>
  1002df:	b8 60 88 10 00       	mov    $0x108860,%eax
  1002e4:	31 d2                	xor    %edx,%edx
  1002e6:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e9:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  1002eb:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002ec:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_waiting = 0;
  1002f3:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  1002fa:	83 c0 54             	add    $0x54,%eax
  1002fd:	83 fa 10             	cmp    $0x10,%edx
  100300:	75 e7                	jne    1002e9 <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_waiting = 0;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100302:	c7 05 08 96 10 00 b4 	movl   $0x1088b4,0x109608
  100309:	88 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  10030c:	e8 73 00 00 00       	call   100384 <segments_init>
	special_registers_init(current);
  100311:	83 ec 0c             	sub    $0xc,%esp
  100314:	ff 35 08 96 10 00    	pushl  0x109608
  10031a:	e8 e4 01 00 00       	call   100503 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  10031f:	e8 2f 01 00 00       	call   100453 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100324:	83 c4 0c             	add    $0xc,%esp
  100327:	68 c0 0a 10 00       	push   $0x100ac0
  10032c:	68 00 07 00 00       	push   $0x700
  100331:	ff 35 00 00 06 00    	pushl  0x60000
  100337:	e8 4e 07 00 00       	call   100a8a <console_printf>
  10033c:	83 c4 10             	add    $0x10,%esp
  10033f:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  100344:	e8 4d 01 00 00       	call   100496 <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  100349:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10034c:	83 fb 01             	cmp    $0x1,%ebx
  10034f:	77 f3                	ja     100344 <start+0x7a>
	console_clear();
  100351:	e8 fd 00 00 00       	call   100453 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  100356:	50                   	push   %eax
  100357:	50                   	push   %eax
  100358:	a1 08 96 10 00       	mov    0x109608,%eax
  10035d:	83 c0 34             	add    $0x34,%eax
  100360:	50                   	push   %eax
  100361:	53                   	push   %ebx
  100362:	e8 d1 01 00 00       	call   100538 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  100367:	a1 08 96 10 00       	mov    0x109608,%eax
  10036c:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  100373:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  10037a:	89 04 24             	mov    %eax,(%esp)
  10037d:	e8 6a 01 00 00       	call   1004ec <run>
  100382:	90                   	nop
  100383:	90                   	nop

00100384 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100384:	b8 a0 8d 10 00       	mov    $0x108da0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100389:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10038e:	89 c2                	mov    %eax,%edx
  100390:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100393:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100394:	bb 56 00 10 00       	mov    $0x100056,%ebx
  100399:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10039c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1003a2:	c1 e8 18             	shr    $0x18,%eax
  1003a5:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ab:	ba 08 8e 10 00       	mov    $0x108e08,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b0:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b7:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1003be:	68 00 
  1003c0:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003c7:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003ce:	c7 05 a4 8d 10 00 00 	movl   $0x80000,0x108da4
  1003d5:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003d8:	66 c7 05 a8 8d 10 00 	movw   $0x10,0x108da8
  1003df:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e1:	66 89 0c c5 08 8e 10 	mov    %cx,0x108e08(,%eax,8)
  1003e8:	00 
  1003e9:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003f0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003f5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003fa:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003ff:	40                   	inc    %eax
  100400:	3d 00 01 00 00       	cmp    $0x100,%eax
  100405:	75 da                	jne    1003e1 <segments_init+0x5d>
  100407:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10040b:	ba 08 8e 10 00       	mov    $0x108e08,%edx
  100410:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  100417:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10041e:	66 89 0c c5 08 8e 10 	mov    %cx,0x108e08(,%eax,8)
  100425:	00 
  100426:	c1 e9 10             	shr    $0x10,%ecx
  100429:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10042e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100433:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  100438:	40                   	inc    %eax
  100439:	83 f8 3a             	cmp    $0x3a,%eax
  10043c:	75 d2                	jne    100410 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10043e:	b0 28                	mov    $0x28,%al
  100440:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100447:	0f 00 d8             	ltr    %ax
  10044a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100451:	5b                   	pop    %ebx
  100452:	c3                   	ret    

00100453 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100453:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100454:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100456:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100457:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  10045e:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100461:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  100468:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10046b:	40                   	inc    %eax
  10046c:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100471:	75 ee                	jne    100461 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100473:	be d4 03 00 00       	mov    $0x3d4,%esi
  100478:	b0 0e                	mov    $0xe,%al
  10047a:	89 f2                	mov    %esi,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	31 c9                	xor    %ecx,%ecx
  10047f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100484:	88 c8                	mov    %cl,%al
  100486:	89 da                	mov    %ebx,%edx
  100488:	ee                   	out    %al,(%dx)
  100489:	b0 0f                	mov    $0xf,%al
  10048b:	89 f2                	mov    %esi,%edx
  10048d:	ee                   	out    %al,(%dx)
  10048e:	88 c8                	mov    %cl,%al
  100490:	89 da                	mov    %ebx,%edx
  100492:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100493:	5b                   	pop    %ebx
  100494:	5e                   	pop    %esi
  100495:	c3                   	ret    

00100496 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100496:	ba 64 00 00 00       	mov    $0x64,%edx
  10049b:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10049c:	a8 01                	test   $0x1,%al
  10049e:	74 45                	je     1004e5 <console_read_digit+0x4f>
  1004a0:	b2 60                	mov    $0x60,%dl
  1004a2:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004a3:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004a6:	80 fa 08             	cmp    $0x8,%dl
  1004a9:	77 05                	ja     1004b0 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004ab:	0f b6 c0             	movzbl %al,%eax
  1004ae:	48                   	dec    %eax
  1004af:	c3                   	ret    
	else if (data == 0x0B)
  1004b0:	3c 0b                	cmp    $0xb,%al
  1004b2:	74 35                	je     1004e9 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004b4:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004b7:	80 fa 02             	cmp    $0x2,%dl
  1004ba:	77 07                	ja     1004c3 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004bc:	0f b6 c0             	movzbl %al,%eax
  1004bf:	83 e8 40             	sub    $0x40,%eax
  1004c2:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004c3:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004c6:	80 fa 02             	cmp    $0x2,%dl
  1004c9:	77 07                	ja     1004d2 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004cb:	0f b6 c0             	movzbl %al,%eax
  1004ce:	83 e8 47             	sub    $0x47,%eax
  1004d1:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004d2:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004d5:	80 fa 02             	cmp    $0x2,%dl
  1004d8:	77 07                	ja     1004e1 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004da:	0f b6 c0             	movzbl %al,%eax
  1004dd:	83 e8 4e             	sub    $0x4e,%eax
  1004e0:	c3                   	ret    
	else if (data == 0x53)
  1004e1:	3c 53                	cmp    $0x53,%al
  1004e3:	74 04                	je     1004e9 <console_read_digit+0x53>
  1004e5:	83 c8 ff             	or     $0xffffffff,%eax
  1004e8:	c3                   	ret    
  1004e9:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004eb:	c3                   	ret    

001004ec <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004ec:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004f0:	a3 08 96 10 00       	mov    %eax,0x109608

	asm volatile("movl %0,%%esp\n\t"
  1004f5:	83 c0 04             	add    $0x4,%eax
  1004f8:	89 c4                	mov    %eax,%esp
  1004fa:	61                   	popa   
  1004fb:	07                   	pop    %es
  1004fc:	1f                   	pop    %ds
  1004fd:	83 c4 08             	add    $0x8,%esp
  100500:	cf                   	iret   
  100501:	eb fe                	jmp    100501 <run+0x15>

00100503 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100503:	53                   	push   %ebx
  100504:	83 ec 0c             	sub    $0xc,%esp
  100507:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10050b:	6a 44                	push   $0x44
  10050d:	6a 00                	push   $0x0
  10050f:	8d 43 04             	lea    0x4(%ebx),%eax
  100512:	50                   	push   %eax
  100513:	e8 10 01 00 00       	call   100628 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100518:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10051e:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100524:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10052a:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  100530:	83 c4 18             	add    $0x18,%esp
  100533:	5b                   	pop    %ebx
  100534:	c3                   	ret    
  100535:	90                   	nop
  100536:	90                   	nop
  100537:	90                   	nop

00100538 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100538:	55                   	push   %ebp
  100539:	57                   	push   %edi
  10053a:	56                   	push   %esi
  10053b:	53                   	push   %ebx
  10053c:	83 ec 1c             	sub    $0x1c,%esp
  10053f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100543:	83 f8 01             	cmp    $0x1,%eax
  100546:	7f 04                	jg     10054c <program_loader+0x14>
  100548:	85 c0                	test   %eax,%eax
  10054a:	79 02                	jns    10054e <program_loader+0x16>
  10054c:	eb fe                	jmp    10054c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10054e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100555:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10055b:	74 02                	je     10055f <program_loader+0x27>
  10055d:	eb fe                	jmp    10055d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10055f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100562:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100566:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100568:	c1 e5 05             	shl    $0x5,%ebp
  10056b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10056e:	eb 3f                	jmp    1005af <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100570:	83 3b 01             	cmpl   $0x1,(%ebx)
  100573:	75 37                	jne    1005ac <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100575:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100578:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10057b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10057e:	01 c7                	add    %eax,%edi
	memsz += va;
  100580:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100582:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100587:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10058b:	52                   	push   %edx
  10058c:	89 fa                	mov    %edi,%edx
  10058e:	29 c2                	sub    %eax,%edx
  100590:	52                   	push   %edx
  100591:	8b 53 04             	mov    0x4(%ebx),%edx
  100594:	01 f2                	add    %esi,%edx
  100596:	52                   	push   %edx
  100597:	50                   	push   %eax
  100598:	e8 27 00 00 00       	call   1005c4 <memcpy>
  10059d:	83 c4 10             	add    $0x10,%esp
  1005a0:	eb 04                	jmp    1005a6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005a2:	c6 07 00             	movb   $0x0,(%edi)
  1005a5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005a6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005aa:	72 f6                	jb     1005a2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005ac:	83 c3 20             	add    $0x20,%ebx
  1005af:	39 eb                	cmp    %ebp,%ebx
  1005b1:	72 bd                	jb     100570 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005b3:	8b 56 18             	mov    0x18(%esi),%edx
  1005b6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005ba:	89 10                	mov    %edx,(%eax)
}
  1005bc:	83 c4 1c             	add    $0x1c,%esp
  1005bf:	5b                   	pop    %ebx
  1005c0:	5e                   	pop    %esi
  1005c1:	5f                   	pop    %edi
  1005c2:	5d                   	pop    %ebp
  1005c3:	c3                   	ret    

001005c4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005c4:	56                   	push   %esi
  1005c5:	31 d2                	xor    %edx,%edx
  1005c7:	53                   	push   %ebx
  1005c8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005cc:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005d0:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005d4:	eb 08                	jmp    1005de <memcpy+0x1a>
		*d++ = *s++;
  1005d6:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005d9:	4e                   	dec    %esi
  1005da:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005dd:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005de:	85 f6                	test   %esi,%esi
  1005e0:	75 f4                	jne    1005d6 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005e2:	5b                   	pop    %ebx
  1005e3:	5e                   	pop    %esi
  1005e4:	c3                   	ret    

001005e5 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005e5:	57                   	push   %edi
  1005e6:	56                   	push   %esi
  1005e7:	53                   	push   %ebx
  1005e8:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005ec:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005f0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005f4:	39 c7                	cmp    %eax,%edi
  1005f6:	73 26                	jae    10061e <memmove+0x39>
  1005f8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005fb:	39 c6                	cmp    %eax,%esi
  1005fd:	76 1f                	jbe    10061e <memmove+0x39>
		s += n, d += n;
  1005ff:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100602:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100604:	eb 07                	jmp    10060d <memmove+0x28>
			*--d = *--s;
  100606:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100609:	4a                   	dec    %edx
  10060a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10060d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10060e:	85 d2                	test   %edx,%edx
  100610:	75 f4                	jne    100606 <memmove+0x21>
  100612:	eb 10                	jmp    100624 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100614:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100617:	4a                   	dec    %edx
  100618:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10061b:	41                   	inc    %ecx
  10061c:	eb 02                	jmp    100620 <memmove+0x3b>
  10061e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100620:	85 d2                	test   %edx,%edx
  100622:	75 f0                	jne    100614 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100624:	5b                   	pop    %ebx
  100625:	5e                   	pop    %esi
  100626:	5f                   	pop    %edi
  100627:	c3                   	ret    

00100628 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100628:	53                   	push   %ebx
  100629:	8b 44 24 08          	mov    0x8(%esp),%eax
  10062d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100631:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100635:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100637:	eb 04                	jmp    10063d <memset+0x15>
		*p++ = c;
  100639:	88 1a                	mov    %bl,(%edx)
  10063b:	49                   	dec    %ecx
  10063c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10063d:	85 c9                	test   %ecx,%ecx
  10063f:	75 f8                	jne    100639 <memset+0x11>
		*p++ = c;
	return v;
}
  100641:	5b                   	pop    %ebx
  100642:	c3                   	ret    

00100643 <strlen>:

size_t
strlen(const char *s)
{
  100643:	8b 54 24 04          	mov    0x4(%esp),%edx
  100647:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100649:	eb 01                	jmp    10064c <strlen+0x9>
		++n;
  10064b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10064c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100650:	75 f9                	jne    10064b <strlen+0x8>
		++n;
	return n;
}
  100652:	c3                   	ret    

00100653 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100653:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100657:	31 c0                	xor    %eax,%eax
  100659:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10065d:	eb 01                	jmp    100660 <strnlen+0xd>
		++n;
  10065f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100660:	39 d0                	cmp    %edx,%eax
  100662:	74 06                	je     10066a <strnlen+0x17>
  100664:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100668:	75 f5                	jne    10065f <strnlen+0xc>
		++n;
	return n;
}
  10066a:	c3                   	ret    

0010066b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10066b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10066c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100671:	53                   	push   %ebx
  100672:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100674:	76 05                	jbe    10067b <console_putc+0x10>
  100676:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10067b:	80 fa 0a             	cmp    $0xa,%dl
  10067e:	75 2c                	jne    1006ac <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100680:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100686:	be 50 00 00 00       	mov    $0x50,%esi
  10068b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10068d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100690:	99                   	cltd   
  100691:	f7 fe                	idiv   %esi
  100693:	89 de                	mov    %ebx,%esi
  100695:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100697:	eb 07                	jmp    1006a0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100699:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10069c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10069d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006a0:	83 f8 50             	cmp    $0x50,%eax
  1006a3:	75 f4                	jne    100699 <console_putc+0x2e>
  1006a5:	29 d0                	sub    %edx,%eax
  1006a7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006aa:	eb 0b                	jmp    1006b7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006ac:	0f b6 d2             	movzbl %dl,%edx
  1006af:	09 ca                	or     %ecx,%edx
  1006b1:	66 89 13             	mov    %dx,(%ebx)
  1006b4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006b7:	5b                   	pop    %ebx
  1006b8:	5e                   	pop    %esi
  1006b9:	c3                   	ret    

001006ba <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006ba:	56                   	push   %esi
  1006bb:	53                   	push   %ebx
  1006bc:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006c3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006c7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006cc:	75 04                	jne    1006d2 <fill_numbuf+0x18>
  1006ce:	85 d2                	test   %edx,%edx
  1006d0:	74 10                	je     1006e2 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006d2:	89 d0                	mov    %edx,%eax
  1006d4:	31 d2                	xor    %edx,%edx
  1006d6:	f7 f1                	div    %ecx
  1006d8:	4b                   	dec    %ebx
  1006d9:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006dc:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006de:	89 c2                	mov    %eax,%edx
  1006e0:	eb ec                	jmp    1006ce <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006e2:	89 d8                	mov    %ebx,%eax
  1006e4:	5b                   	pop    %ebx
  1006e5:	5e                   	pop    %esi
  1006e6:	c3                   	ret    

001006e7 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006e7:	55                   	push   %ebp
  1006e8:	57                   	push   %edi
  1006e9:	56                   	push   %esi
  1006ea:	53                   	push   %ebx
  1006eb:	83 ec 38             	sub    $0x38,%esp
  1006ee:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006f2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006f6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006fa:	e9 60 03 00 00       	jmp    100a5f <console_vprintf+0x378>
		if (*format != '%') {
  1006ff:	80 fa 25             	cmp    $0x25,%dl
  100702:	74 13                	je     100717 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100704:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100708:	0f b6 d2             	movzbl %dl,%edx
  10070b:	89 f0                	mov    %esi,%eax
  10070d:	e8 59 ff ff ff       	call   10066b <console_putc>
  100712:	e9 45 03 00 00       	jmp    100a5c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100717:	47                   	inc    %edi
  100718:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10071f:	00 
  100720:	eb 12                	jmp    100734 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100722:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100723:	8a 11                	mov    (%ecx),%dl
  100725:	84 d2                	test   %dl,%dl
  100727:	74 1a                	je     100743 <console_vprintf+0x5c>
  100729:	89 e8                	mov    %ebp,%eax
  10072b:	38 c2                	cmp    %al,%dl
  10072d:	75 f3                	jne    100722 <console_vprintf+0x3b>
  10072f:	e9 3f 03 00 00       	jmp    100a73 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100734:	8a 17                	mov    (%edi),%dl
  100736:	84 d2                	test   %dl,%dl
  100738:	74 0b                	je     100745 <console_vprintf+0x5e>
  10073a:	b9 f4 0a 10 00       	mov    $0x100af4,%ecx
  10073f:	89 d5                	mov    %edx,%ebp
  100741:	eb e0                	jmp    100723 <console_vprintf+0x3c>
  100743:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100745:	8d 42 cf             	lea    -0x31(%edx),%eax
  100748:	3c 08                	cmp    $0x8,%al
  10074a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100751:	00 
  100752:	76 13                	jbe    100767 <console_vprintf+0x80>
  100754:	eb 1d                	jmp    100773 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100756:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10075b:	0f be c0             	movsbl %al,%eax
  10075e:	47                   	inc    %edi
  10075f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100763:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100767:	8a 07                	mov    (%edi),%al
  100769:	8d 50 d0             	lea    -0x30(%eax),%edx
  10076c:	80 fa 09             	cmp    $0x9,%dl
  10076f:	76 e5                	jbe    100756 <console_vprintf+0x6f>
  100771:	eb 18                	jmp    10078b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100773:	80 fa 2a             	cmp    $0x2a,%dl
  100776:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10077d:	ff 
  10077e:	75 0b                	jne    10078b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100780:	83 c3 04             	add    $0x4,%ebx
			++format;
  100783:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100784:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100787:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10078b:	83 cd ff             	or     $0xffffffff,%ebp
  10078e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100791:	75 37                	jne    1007ca <console_vprintf+0xe3>
			++format;
  100793:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100794:	31 ed                	xor    %ebp,%ebp
  100796:	8a 07                	mov    (%edi),%al
  100798:	8d 50 d0             	lea    -0x30(%eax),%edx
  10079b:	80 fa 09             	cmp    $0x9,%dl
  10079e:	76 0d                	jbe    1007ad <console_vprintf+0xc6>
  1007a0:	eb 17                	jmp    1007b9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007a2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007a5:	0f be c0             	movsbl %al,%eax
  1007a8:	47                   	inc    %edi
  1007a9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007ad:	8a 07                	mov    (%edi),%al
  1007af:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007b2:	80 fa 09             	cmp    $0x9,%dl
  1007b5:	76 eb                	jbe    1007a2 <console_vprintf+0xbb>
  1007b7:	eb 11                	jmp    1007ca <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007b9:	3c 2a                	cmp    $0x2a,%al
  1007bb:	75 0b                	jne    1007c8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007bd:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007c0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007c1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007c4:	85 ed                	test   %ebp,%ebp
  1007c6:	79 02                	jns    1007ca <console_vprintf+0xe3>
  1007c8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007ca:	8a 07                	mov    (%edi),%al
  1007cc:	3c 64                	cmp    $0x64,%al
  1007ce:	74 34                	je     100804 <console_vprintf+0x11d>
  1007d0:	7f 1d                	jg     1007ef <console_vprintf+0x108>
  1007d2:	3c 58                	cmp    $0x58,%al
  1007d4:	0f 84 a2 00 00 00    	je     10087c <console_vprintf+0x195>
  1007da:	3c 63                	cmp    $0x63,%al
  1007dc:	0f 84 bf 00 00 00    	je     1008a1 <console_vprintf+0x1ba>
  1007e2:	3c 43                	cmp    $0x43,%al
  1007e4:	0f 85 d0 00 00 00    	jne    1008ba <console_vprintf+0x1d3>
  1007ea:	e9 a3 00 00 00       	jmp    100892 <console_vprintf+0x1ab>
  1007ef:	3c 75                	cmp    $0x75,%al
  1007f1:	74 4d                	je     100840 <console_vprintf+0x159>
  1007f3:	3c 78                	cmp    $0x78,%al
  1007f5:	74 5c                	je     100853 <console_vprintf+0x16c>
  1007f7:	3c 73                	cmp    $0x73,%al
  1007f9:	0f 85 bb 00 00 00    	jne    1008ba <console_vprintf+0x1d3>
  1007ff:	e9 86 00 00 00       	jmp    10088a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100804:	83 c3 04             	add    $0x4,%ebx
  100807:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10080a:	89 d1                	mov    %edx,%ecx
  10080c:	c1 f9 1f             	sar    $0x1f,%ecx
  10080f:	89 0c 24             	mov    %ecx,(%esp)
  100812:	31 ca                	xor    %ecx,%edx
  100814:	55                   	push   %ebp
  100815:	29 ca                	sub    %ecx,%edx
  100817:	68 fc 0a 10 00       	push   $0x100afc
  10081c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100821:	8d 44 24 40          	lea    0x40(%esp),%eax
  100825:	e8 90 fe ff ff       	call   1006ba <fill_numbuf>
  10082a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10082e:	58                   	pop    %eax
  10082f:	5a                   	pop    %edx
  100830:	ba 01 00 00 00       	mov    $0x1,%edx
  100835:	8b 04 24             	mov    (%esp),%eax
  100838:	83 e0 01             	and    $0x1,%eax
  10083b:	e9 a5 00 00 00       	jmp    1008e5 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100840:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100843:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100848:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10084b:	55                   	push   %ebp
  10084c:	68 fc 0a 10 00       	push   $0x100afc
  100851:	eb 11                	jmp    100864 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100853:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100856:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100859:	55                   	push   %ebp
  10085a:	68 10 0b 10 00       	push   $0x100b10
  10085f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100864:	8d 44 24 40          	lea    0x40(%esp),%eax
  100868:	e8 4d fe ff ff       	call   1006ba <fill_numbuf>
  10086d:	ba 01 00 00 00       	mov    $0x1,%edx
  100872:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100876:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100878:	59                   	pop    %ecx
  100879:	59                   	pop    %ecx
  10087a:	eb 69                	jmp    1008e5 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10087c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10087f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100882:	55                   	push   %ebp
  100883:	68 fc 0a 10 00       	push   $0x100afc
  100888:	eb d5                	jmp    10085f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10088a:	83 c3 04             	add    $0x4,%ebx
  10088d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100890:	eb 40                	jmp    1008d2 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100892:	83 c3 04             	add    $0x4,%ebx
  100895:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100898:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10089c:	e9 bd 01 00 00       	jmp    100a5e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008a1:	83 c3 04             	add    $0x4,%ebx
  1008a4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008a7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008ab:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008b0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008b4:	88 44 24 24          	mov    %al,0x24(%esp)
  1008b8:	eb 27                	jmp    1008e1 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008ba:	84 c0                	test   %al,%al
  1008bc:	75 02                	jne    1008c0 <console_vprintf+0x1d9>
  1008be:	b0 25                	mov    $0x25,%al
  1008c0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008c4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008c9:	80 3f 00             	cmpb   $0x0,(%edi)
  1008cc:	74 0a                	je     1008d8 <console_vprintf+0x1f1>
  1008ce:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008d2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008d6:	eb 09                	jmp    1008e1 <console_vprintf+0x1fa>
				format--;
  1008d8:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008dc:	4f                   	dec    %edi
  1008dd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008e1:	31 d2                	xor    %edx,%edx
  1008e3:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008e5:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008e7:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008f1:	74 1f                	je     100912 <console_vprintf+0x22b>
  1008f3:	89 04 24             	mov    %eax,(%esp)
  1008f6:	eb 01                	jmp    1008f9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008f8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008f9:	39 e9                	cmp    %ebp,%ecx
  1008fb:	74 0a                	je     100907 <console_vprintf+0x220>
  1008fd:	8b 44 24 04          	mov    0x4(%esp),%eax
  100901:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100905:	75 f1                	jne    1008f8 <console_vprintf+0x211>
  100907:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10090a:	89 0c 24             	mov    %ecx,(%esp)
  10090d:	eb 1f                	jmp    10092e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10090f:	42                   	inc    %edx
  100910:	eb 09                	jmp    10091b <console_vprintf+0x234>
  100912:	89 d1                	mov    %edx,%ecx
  100914:	8b 14 24             	mov    (%esp),%edx
  100917:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10091b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10091f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100923:	75 ea                	jne    10090f <console_vprintf+0x228>
  100925:	8b 44 24 08          	mov    0x8(%esp),%eax
  100929:	89 14 24             	mov    %edx,(%esp)
  10092c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10092e:	85 c0                	test   %eax,%eax
  100930:	74 0c                	je     10093e <console_vprintf+0x257>
  100932:	84 d2                	test   %dl,%dl
  100934:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10093b:	00 
  10093c:	75 24                	jne    100962 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10093e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100943:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10094a:	00 
  10094b:	75 15                	jne    100962 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10094d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100951:	83 e0 08             	and    $0x8,%eax
  100954:	83 f8 01             	cmp    $0x1,%eax
  100957:	19 c9                	sbb    %ecx,%ecx
  100959:	f7 d1                	not    %ecx
  10095b:	83 e1 20             	and    $0x20,%ecx
  10095e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100962:	3b 2c 24             	cmp    (%esp),%ebp
  100965:	7e 0d                	jle    100974 <console_vprintf+0x28d>
  100967:	84 d2                	test   %dl,%dl
  100969:	74 40                	je     1009ab <console_vprintf+0x2c4>
			zeros = precision - len;
  10096b:	2b 2c 24             	sub    (%esp),%ebp
  10096e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100972:	eb 3f                	jmp    1009b3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100974:	84 d2                	test   %dl,%dl
  100976:	74 33                	je     1009ab <console_vprintf+0x2c4>
  100978:	8b 44 24 14          	mov    0x14(%esp),%eax
  10097c:	83 e0 06             	and    $0x6,%eax
  10097f:	83 f8 02             	cmp    $0x2,%eax
  100982:	75 27                	jne    1009ab <console_vprintf+0x2c4>
  100984:	45                   	inc    %ebp
  100985:	75 24                	jne    1009ab <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100987:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100989:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  10098c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100991:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100994:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100997:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10099b:	7d 0e                	jge    1009ab <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  10099d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009a1:	29 ca                	sub    %ecx,%edx
  1009a3:	29 c2                	sub    %eax,%edx
  1009a5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009a9:	eb 08                	jmp    1009b3 <console_vprintf+0x2cc>
  1009ab:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009b2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009b3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009b7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009bd:	2b 2c 24             	sub    (%esp),%ebp
  1009c0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009c5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009cb:	29 c5                	sub    %eax,%ebp
  1009cd:	89 f0                	mov    %esi,%eax
  1009cf:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009d3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009d7:	eb 0f                	jmp    1009e8 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009d9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009dd:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009e3:	e8 83 fc ff ff       	call   10066b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e8:	85 ed                	test   %ebp,%ebp
  1009ea:	7e 07                	jle    1009f3 <console_vprintf+0x30c>
  1009ec:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009f1:	74 e6                	je     1009d9 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009f3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009f8:	89 c6                	mov    %eax,%esi
  1009fa:	74 23                	je     100a1f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009fc:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a05:	e8 61 fc ff ff       	call   10066b <console_putc>
  100a0a:	89 c6                	mov    %eax,%esi
  100a0c:	eb 11                	jmp    100a1f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a0e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a12:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a17:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a18:	e8 4e fc ff ff       	call   10066b <console_putc>
  100a1d:	eb 06                	jmp    100a25 <console_vprintf+0x33e>
  100a1f:	89 f0                	mov    %esi,%eax
  100a21:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a25:	85 f6                	test   %esi,%esi
  100a27:	7f e5                	jg     100a0e <console_vprintf+0x327>
  100a29:	8b 34 24             	mov    (%esp),%esi
  100a2c:	eb 15                	jmp    100a43 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a2e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a32:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a33:	0f b6 11             	movzbl (%ecx),%edx
  100a36:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a3a:	e8 2c fc ff ff       	call   10066b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a3f:	ff 44 24 04          	incl   0x4(%esp)
  100a43:	85 f6                	test   %esi,%esi
  100a45:	7f e7                	jg     100a2e <console_vprintf+0x347>
  100a47:	eb 0f                	jmp    100a58 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a49:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a4d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a52:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a53:	e8 13 fc ff ff       	call   10066b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a58:	85 ed                	test   %ebp,%ebp
  100a5a:	7f ed                	jg     100a49 <console_vprintf+0x362>
  100a5c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a5e:	47                   	inc    %edi
  100a5f:	8a 17                	mov    (%edi),%dl
  100a61:	84 d2                	test   %dl,%dl
  100a63:	0f 85 96 fc ff ff    	jne    1006ff <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a69:	83 c4 38             	add    $0x38,%esp
  100a6c:	89 f0                	mov    %esi,%eax
  100a6e:	5b                   	pop    %ebx
  100a6f:	5e                   	pop    %esi
  100a70:	5f                   	pop    %edi
  100a71:	5d                   	pop    %ebp
  100a72:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a73:	81 e9 f4 0a 10 00    	sub    $0x100af4,%ecx
  100a79:	b8 01 00 00 00       	mov    $0x1,%eax
  100a7e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a80:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a81:	09 44 24 14          	or     %eax,0x14(%esp)
  100a85:	e9 aa fc ff ff       	jmp    100734 <console_vprintf+0x4d>

00100a8a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a8a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a8e:	50                   	push   %eax
  100a8f:	ff 74 24 10          	pushl  0x10(%esp)
  100a93:	ff 74 24 10          	pushl  0x10(%esp)
  100a97:	ff 74 24 10          	pushl  0x10(%esp)
  100a9b:	e8 47 fc ff ff       	call   1006e7 <console_vprintf>
  100aa0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100aa3:	c3                   	ret    
