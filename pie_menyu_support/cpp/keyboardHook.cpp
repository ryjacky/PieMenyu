#include <iostream>
#include <windows.h>

HHOOK g_hookHandle = nullptr;

LRESULT CALLBACK KeyboardHookCallback(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode == HC_ACTION)
    {
        KBDLLHOOKSTRUCT* pKeyboardStruct = (KBDLLHOOKSTRUCT*)lParam;

        if (wParam == WM_KEYUP || wParam == WM_SYSKEYUP)
        {
            DWORD vkCode = pKeyboardStruct->vkCode;
            std::cout << "{key_release:" << vkCode << "}" << std::endl;
        }
    }

    return CallNextHookEx(g_hookHandle, nCode, wParam, lParam);
}

int main()
{
    HINSTANCE hInstance = GetModuleHandle(nullptr);

    g_hookHandle = SetWindowsHookExW(WH_KEYBOARD_LL, KeyboardHookCallback, hInstance, 0);
    if (g_hookHandle == nullptr)
    {
        std::cerr << "Failed to set keyboard hook." << std::endl;
        return 1;
    }

    MSG message;
    while (GetMessage(&message, nullptr, 0, 0))
    {
        TranslateMessage(&message);
        DispatchMessage(&message);
    }

    UnhookWindowsHookEx(g_hookHandle);

    return 0;
}