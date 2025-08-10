# 🧨 MBR Ransomware (Protótipo em Desenvolvimento) - falta criptografia

> ⚠️ **Aviso Legal Importante**:  
> Este projeto é estritamente para **fins educacionais e de pesquisa em segurança da informação**. O uso deste código fora de ambientes controlados, sem autorização explícita do proprietário da máquina, pode ser **crime** conforme legislações locais e internacionais. O autor **não se responsabiliza** por qualquer uso indevido.

---

## 📌 Descrição

Este é um projeto experimental de um ransomware que sobrescreve o MBR (Master Boot Record) de um disco físico, com bootloader personalizado em Assembly.
O código atual realiza as seguintes etapas:

1.Abre o disco físico 0 (PhysicalDrive0) com permissões de leitura e escrita.

2.Faz backup do setor MBR original (512 bytes).

3.Verifica a assinatura do MBR (0x55AA nos últimos 2 bytes).

4.Sobrescreve os primeiros 1024 bytes do disco com um bootloader customizado escrito em Assembly, que exibe uma mensagem de ransomware e solicita uma senha para liberar o boot.

5.Escreve o MBR original logo após o bootloader (no setor 2), provavelmente para restaurar a lógica original após autenticação.

6.No código do bootloader, é exibida uma mensagem que bloqueia o boot até que a senha correta seja digitada.

7.Se a senha estiver errada, o boot trava com mensagem de erro.

8.Se a senha estiver correta, o boot continua carregando o sistema normalmente.

9.Por fim, o programa eleva privilégios no Windows e dispara uma Tela Azul da Morte (BSOD) como forma de teste ou sinalização do ransomware ativo.

> 💡 O bootloader Assembly implementa uma rotina básica de input via teclado para senha, controle de fluxo e leitura do próximo estágio do boot. O sistema bloqueia o computador até a senha correta ser digitada.



