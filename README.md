# 🧨 MBR Ransomware (Protótipo em Desenvolvimento) - falta criptografia

> ⚠️ **Aviso Legal Importante**:  
> Este projeto é estritamente para **fins educacionais e de pesquisa em segurança da informação**.  
> O uso deste código fora de ambientes controlados, sem autorização explícita do proprietário da máquina, pode ser **crime** conforme legislações locais e internacionais.  
> O autor **não se responsabiliza** por qualquer uso indevido.

---

## 📌 Descrição

Este é um projeto experimental de um **ransomware que sobrescreve o MBR (Master Boot Record)** de um disco físico, com bootloader personalizado em **Assembly**.

O código atual realiza as seguintes etapas:

1. **Abre** o disco físico 0 (`PhysicalDrive0`) com permissões de leitura e escrita.  
2. **Faz backup** do setor MBR original (512 bytes).  
3. **Verifica** a assinatura do MBR (`0x55AA` nos últimos 2 bytes).  
4. **Sobrescreve** os primeiros 1024 bytes do disco com um bootloader customizado escrito em Assembly, que exibe uma mensagem de ransomware e solicita uma senha para liberar o boot.  
5. **Escreve** o MBR original logo após o bootloader (no setor 2), provavelmente para restaurar a lógica original após autenticação.  
6. No código do bootloader, **exibe uma mensagem que bloqueia o boot até que a senha correta seja digitada**.  
7. Se a senha estiver errada, o boot **trava o boot com mensagem de erro**.  
8. Se a senha estiver correta, o boot **continua carregando o sistema normalmente**.  
9. Por fim, o programa **eleva privilégios no Windows** e dispara uma **Tela Azul da Morte (BSOD)** como forma de teste ou sinalização do ransomware ativo.

> 💡 O bootloader Assembly implementa uma rotina básica de input via teclado para senha, controle de fluxo e leitura do próximo estágio do boot.  
> O sistema bloqueia o computador até a senha correta ser digitada.

---

## 🛠️ Como funciona o código

- **C (Windows API)**:  
  - Acesso direto ao disco físico via `CreateFile` para leitura e escrita dos setores.  
  - Backup do MBR original e escrita do bootloader personalizado.  
  - Elevação de privilégios com `RtlAdjustPrivilege`.  
  - Disparo da BSOD com `NtRaiseHardError` para efeito ou teste.

- **Assembly (bootloader)**:  
  - Código de 1024 bytes que substitui o MBR e setor seguinte.  
  - Exibição de mensagens via BIOS interrupt `int 0x10`.  
  - Rotina para captura da senha digitada pelo usuário via teclado (`int 0x16`).  
  - Validação da senha e controle de fluxo para continuar boot ou travar sistema.

---

## ⚠️ Considerações importantes

- **Este projeto é um protótipo e não possui criptografia implementada ainda.**  
- O código pode causar danos irreversíveis ao sistema, use apenas em ambiente controlado e de teste.  
- Recomendado testar em máquina virtual para evitar perda de dados.  
- O autor não se responsabiliza por qualquer dano causado pelo uso do código.

---

## 📁 Estrutura do projeto

- `main.c` — Código fonte em C para Windows, manipula o disco e chama BSOD.  
- `bootloader.asm` — Código Assembly do bootloader que será gravado no MBR e setor 2.  

---
