(cd archives && find . -name '*.zip') | while read x; do
    echo "https://raw.githubusercontent.com/arcanis/npm-vs-github-test/master/archives/$x"
done | sed 's#/\./#/#g' > filelist-zip

(cd archives && find . -name '*.zip') | while read x; do
    if [[ $x == *"/@"* ]]; then
        unzip -W -p "$x" 'node_modules/@*/*/package.json'
    else
        unzip -W -p "$x" 'node_modules/*/package.json'
    fi | jq -r '"https://registry.npmjs.org/\(.name)/-/\(.name | sub("@[^/]+/"; ""))-\(.version).tgz"'
done > filelist-npm
