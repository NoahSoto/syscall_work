



.code
public NoahRead
EXTERN GetSSN: PROC
EXTERN GetJMP: PROC
EXTERN gSSN:QWORD 
EXTERN gJMP:QWORD

EXTERN SW3_GetSyscallNumber: PROC

EXTERN SW3_GetRandomSyscallAddress: PROC


NoahRead PROC
	mov [rsp+8],rcx
	mov [rsp+16],rax
	mov [rsp+24],rsp


	

	call GetJMP ; this is fucked.
	mov r11,rax

	mov rcx,0
	call GetSSN
	mov r10,rax

	mov rcx, [rsp+8] ; Restore RCX.
	mov rax, [rsp+16]
	mov rsp, [rsp+24]

	jmp r11
	
NoahRead ENDP
end


;I dont fully understand this syntax but im gonna go w it for now;

;Okay so what I'm thinking is we remake that GetRandomSyscallAddress by Hells Gating through NTDLL and saving all
;of the syscall opcodes

;Then we just pick a random one based off somekinda time based seed

;Then we return that SSN to the function and note which register the return val gets save into

;Then we move our good SSN into the proper register, we just jmp to the new syscall location prior 

;I think that since we're doing all this work to get ALL the SSN's i want this function to be universal for any syscall. ideally.


; we already know the correct SSN, call our original func and take return val or just have a getter
;pass SSN, random syscall address, 
;NoahAssembly PROC
	;mov [rsp +8], rcx ; first input param.
	;mov [rsp+16], rdx ; second input param		
	;mov [rsp+24], r8  ; third input param
	;mov [rsp+32], r9  ; fourth input param!
	;sub rsp, 28h
	;mov ecx, 0F8D7E269h        ; Load function hash into ECX.
	;call IndirectSyscall        ; Get a syscall offset from a different api - > return val goes to rax.
	;mov r11, rax                           ; Save the address of the syscall
	;mov ecx, 0F8D7E269h        ; Re-Load function hash into ECX (optional).
	;call RetrieveOriginalSSN              ; Resolve function hash into syscall number.
	;add rsp, 28h
	;mov rcx, [rsp+8]                      ; Restore registers.
	;mov rdx, [rsp+16]
	;mov r8, [rsp+24]
	;mov r9, [rsp+32]
	;mov r10, rcx
	;jmp r11                                ; Jump to -> Invoke system call.
;NoahAssembly ENDP




;Parameters
;RCX=1
;RDX=2
;ActualSSN,Indirect JMP Location

