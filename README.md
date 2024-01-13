A cross-platform radial menu. Originally the version 3 of AutoHotPie but later separated into its own repository. Big thanks to @dumbeau for the AutoHotPie project.

Instructions to create release build on Windows
1. Open a terminal at the project root and run the following commands one by one.
cd .\pie_menyu\
flutter build windows
cd ..\pie_menyu_editor\
flutter build windows
cd ../
del Release/
mv .\pie_menyu_editor\build\windows\x64\runner\Release\ .\Release\
mv .\pie_menyu\build\windows\x64\runner\Release\ .\Release\pie_menyu\
2. Check out the build in Release/ folder of the project root


