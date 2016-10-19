
const fs = require('fs');

function fail(msg) {
    console.error(msg || 'Snap! I failed!');
    process.exit(1);
}

const fileName = process.argv[2];
fs.existsSync(fileName) || fail(`File "${fileName}" does not exist!`);

const contents = fs.readFileSync(fileName, "utf-8");

const parts = [];
contents.replace(/```hs((?:.|\n)*?)```/g, (_, part) => parts.push(part));

const tests = [];

const hsSrc = parts
        .filter(val => /^\s*/.exec(val)[0].length < 5)
        .map(val => val.replace(/\s*--.*/g, ''))
        .map(val => val.replace(/^>(.*)\n(.*)\n/gm, (_, expr, res) => {
            tests.push([expr, res]);
            return '';
        }))
        .join('');

const main = `
main :: IO ()
main = putStrLn $ printRes testAll
    where printRes True = "Success!"

`

const testAll = `
testAll :: Bool
testAll = ${tests
    .map(([expr, res]) => `(${expr}) == ${res} || error ${JSON.stringify(expr + ' == ' + res)}`)
    .join('\n           && ')
}
`

const source = hsSrc + main + testAll;
fs.writeFileSync(fileName + '.hs', source, { flag : 'w+' });
