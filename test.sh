echo "generating test files"
dart run test/data/generate_data.dart

echo "running tests"
dart -Dfrom_script=true test --coverage=coverage


echo "formating coverage"
format_coverage -c --lcov --in=coverage --out=coverage/lcov.info --report-on=lib  

echo "generating html files"
genhtml -q coverage/lcov.info -o coverage/html

# to see coverage run:
echo "to view coverage, run: open coverage/html/index.html"