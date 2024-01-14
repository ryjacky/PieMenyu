#include <Windows.h>
#include <iostream>

// WinEventProc callback function
void CALLBACK WinEventProc(HWINEVENTHOOK hWinEventHook, DWORD event, HWND hwnd, LONG idObject, LONG idChild, DWORD dwEventThread, DWORD dwmsEventTime)
{
    if (event == EVENT_SYSTEM_FOREGROUND)
    {
        DWORD processId;
        GetWindowThreadProcessId(hwnd, &processId);

        HANDLE hProcess = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, processId);
        if (hProcess != NULL)
        {
            char exePath[MAX_PATH];
            DWORD pathSize = MAX_PATH;
            if (QueryFullProcessImageNameA(hProcess, 0, exePath, &pathSize))
            {
                std::cout << exePath << std::endl;
            }
            CloseHandle(hProcess);
        }
    }
}

int main()
{
    // Install the hook
    HWINEVENTHOOK hHook = SetWinEventHook(EVENT_SYSTEM_FOREGROUND, EVENT_SYSTEM_FOREGROUND, NULL, WinEventProc, 0, 0, WINEVENT_OUTOFCONTEXT);

    // Check if the hook was installed successfully
    if (hHook == NULL)
    {
        std::cerr << "Failed to install hook." << std::endl;
        return 1;
    }

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    // Uninstall the hook
    UnhookWinEvent(hHook);

    return 0;
}