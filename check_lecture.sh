set -e

if [ "$#" -ne 1 ]; then
    echo "Syntax: $0 <path_to_lecture>"
    exit 1
fi

dir=$(dirname "$1")
build_dir="$dir/example_tests"
check_name="$build_dir/check"

mkdir "$build_dir" || rm -rf "$build_dir/*"

node --harmony_destructuring extract.js "$1" --tests > "$check_name.hs"

ghc --make "$check_name.hs" -o "$check_name"

echo ""
echo ""

./"$check_name"

rm -rf "$build_dir"
