org 100h
.model small

.data
msg db "Please Enter array elements and press Enter to finish:  $"
arr db 1000 DUP(?) 
arrlen dw ?


.code

main proc
mov ax,@data
mov ds,ax
mov arrlen,0


call input
call sort
call print


mov ax, 4c00h   ;return to dos
int 21h
ret
main endp  



input proc
    lea dx,msg
    mov ah,09h
    int 21h
    
    mov cx,1000d
    
    mov di, offset arr
   
    inloop:
    mov ah,01h
    int 21h
    
    
    cmp al,0dH
    jz endinput                          
                             
    mov [di],al
    inc arrlen
    inc di
    loop inloop
    
    endinput:           ; append string with $
    inc di
    mov [di],'$'    
    
   ret 
endp







sort proc

    mov cx,arrlen
    cmp cx,1            ; check if array length = 1 "no need to sort"
    Jz end
    dec cx              ; to stop before (newline) ascii in array 
    xor di,di
    mov di, offset arr
    
    bigloop:
    push cx             ; save big loop counter
    
    mov cx,arrlen
    add cx,offset arr
    sub cx,di
    
    dec cx
    mov si,di
    inc si
    
    subloop:
    mov bl,byte ptr [si]
    cmp byte ptr [di],bl
    JLE  noswap          ;if [di] less or equal [si]->[di+1] don't swap
         
    mov dh,[si]
    mov dl,[di]
    mov [si],dl
    mov [di],dh
    
    
    noswap:
    inc si
    
     
    loop subloop
    
    pop cx              ; load big loop counter
    inc di 
    loop bigloop
    end:
   ret 
    
sort endp



print proc
    ;;;;;;; new line ;;;;;;;;;;;
    mov ah, 2                    
    mov dl, 0dh
    int 21h
    
    mov ah,02h
    mov dl, 0ah                  
    int 21h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
           
    lea dx,arr
    mov ah,09h
    int 21h 
    ret   
print endp





