# 🧨 MBR Ransomware (Protótipo em Desenvolvimento)

> ⚠️ **Aviso Legal Importante**:  
> Este projeto é estritamente para **fins educacionais e de pesquisa em segurança da informação**. O uso deste código fora de ambientes controlados, sem autorização explícita do proprietário da máquina, pode ser **crime** conforme legislações locais e internacionais. O autor **não se responsabiliza** por qualquer uso indevido.

---

## 📌 Descrição

Este é um projeto experimental de um **ransomware que sobrescreve o MBR (Master Boot Record)** de um disco físico.  
O código atual realiza as seguintes etapas:

1. Abre o **disco físico 0** (`PhysicalDrive0`) com permissões de leitura e escrita.
2. Faz backup do setor MBR original (512 bytes).
3. Verifica a **assinatura do MBR** (0x55AA nos últimos 2 bytes).
4. Cria um buffer de 512 bytes com o caractere `'R'` e sobrescreve o MBR com esse conteúdo.
5. Em seguida, **restaura o MBR original** (talvez como teste ou placeholder).
6. Eleva privilégios e **dispara uma tela azul da morte (BSOD)** usando `NtRaiseHardError`.

> 💡 *Atualmente, o código ainda não injeta um bootloader funcional. Isso será implementado nas próximas etapas.*



