const fs = require('fs');
const path = require('path');
const ts = require('typescript');

const sourcePath = path.join(__dirname, '..', 'src', 'renderer', 'index.html');
const outputPath = path.join(__dirname, '..', 'dist', 'renderer', 'index.html');
const sourceHtml = fs.readFileSync(sourcePath, 'utf8');
const scriptMatch = sourceHtml.match(/<script>([\s\S]*?)<\/script>/i);

if (!scriptMatch) {
  throw new Error('Renderer HTML has no inline script to compile.');
}

const compiled = ts.transpileModule(scriptMatch[1], {
  compilerOptions: {
    target: ts.ScriptTarget.ES2022,
    module: ts.ModuleKind.None,
  },
  reportDiagnostics: true,
});
const errors = (compiled.diagnostics ?? []).filter(
  (diagnostic) => diagnostic.category === ts.DiagnosticCategory.Error,
);

if (errors.length) {
  throw new Error(
    errors.map((diagnostic) => ts.flattenDiagnosticMessageText(diagnostic.messageText, '\n')).join('\n'),
  );
}

const outputHtml = sourceHtml.replace(
  scriptMatch[0],
  `<script>\n${compiled.outputText}\n</script>`,
);
fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, outputHtml);
console.log(`Compiled renderer to ${path.relative(process.cwd(), outputPath)}`);
