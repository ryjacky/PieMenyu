#include <iostream>
#include <Windows.h>

HHOOK g_hookHandle = nullptr;

LRESULT CALLBACK MouseHookCallback(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode == HC_ACTION)
    {
        MSLLHOOKSTRUCT* pMouseStruct = (MSLLHOOKSTRUCT*)lParam;

        if (wParam == WM_MOUSEMOVE)
        {
            std::cout << pMouseStruct->pt.x << "\t" << pMouseStruct->pt.y << std::endl;
        }
    }

    return CallNextHookEx(g_hookHandle, nCode, wParam, lParam);
}

int main()
{
    HINSTANCE hInstance = GetModuleHandle(nullptr);

    g_hookHandle = SetWindowsHookExW(WH_MOUSE_LL, MouseHookCallback, hInstance, 0);
    if (g_hookHandle == nullptr)
    {
        std::cerr << "Failed to set mouse hook." << std::endl;
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