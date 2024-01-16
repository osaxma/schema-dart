echo "generating test files using test.sh"
dart run test/data/generate_data.dart

if [ "$#" -eq 0 ]; then
    # when no argument is provided, it's most likely running the tests from terminal
    echo "running tests"
    dart -Dfrom_script=true test --coverage=coverage

    echo "formating coverage"
    format_coverage -c --lcov --in=coverage --out=coverage/lcov.info --report-on=lib  

    echo "generating html files"
    genhtml -q coverage/lcov.info -o coverage/html

    # to see coverage run:
    echo "to view coverage, run: open coverage/html/index.html"
else
    # in this case, this is most likely from VS code extension, so we pass all args here
    # https://discord.com/channels/615553440969392147/615553440969392151/1196734658398916712 
    echo "running tests from VS Code"
    
    dart -Dfrom_script=true "$@"
fi