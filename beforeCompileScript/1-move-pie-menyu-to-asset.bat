del -R ../pie_menyu_editor/build/windows/x64/runner/Debug/pie_menyu/ 2>null
del -R ../pie_menyu_editor/build/windows/x64/runner/Release/pie_menyu/ 2>null
mv ../pie_menyu/build/windows/x64/runner/Release/ ../pie_menyu_editor/build/windows/x64/runner/Debug/pie_menyu 2>null
mv ../pie_menyu/build/windows/x64/runner/Release/ ../pie_menyu_editor/build/windows/x64/runner/Release/pie_menyu 2>null
echo 0

