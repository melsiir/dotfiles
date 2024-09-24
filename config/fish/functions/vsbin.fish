
function vsbin -d "create bin files for vscode-langservers-extracted"
    mkdir -p $HOME/.local/share/nvim/mason/bin
    echo '#!/usr/bin/env node
const path = require("path");
// require(path.join(__dirname, "/../lib/css-language-server/node/cssServerMain.js"));

// require(path.join(__dirname, "../packages/vscode-langservers-extracted/lib/css-language-server/node/cssServerMain.js"));


require(path.join(__dirname, "../packages/html-lsp/node_modules/vscode-langservers-extracted/lib/css-language-server/node/cssServerMain.js"));' >$HOME/.local/share/nvim/mason/bin/vscode-css-language-server



    echo '#!/usr/bin/env node
    const path = require("path")
    // require(path.join(__dirname, "/../lib/eslint-language-server/eslintServer.js"))


    // require(path.join(__dirname, "../packages/vscode-langservers-extracted/lib/eslint-language-server/eslintServer.js"))


    require(path.join(__dirname, "../packages/html-lsp/node_modules/vscode-langservers-extracted/lib/eslint-language-server/eslintServer.js"));' >$HOME/.local/share/nvim/mason/bin/vscode-eslint-language-server

    echo '#!/usr/bin/env node
const path = require("path")
// require(path.join(__dirname, "/../lib/html-language-server/node/htmlServerMain.js"))


// require(path.join(__dirname, "../packages/vscode-langservers-extracted/lib/html-language-server/node/htmlServerMain.js"))


require(path.join(__dirname, "../packages/html-lsp/node_modules/vscode-langservers-extracted/lib/html-language-server/node/htmlServerMain.js"));' >$HOME/.local/share/nvim/mason/bin/vscode-html-language-server


    echo '#!/usr/bin/env node
const path = require("path");
// require(path.join(__dirname, "/../lib/json-language-server/node/jsonServerMain.js"));


// require(path.join(__dirname, "../packages/vscode-langservers-extracted/lib/json-language-server/node/jsonServerMain.js"));

require(path.join(__dirname, "../packages/html-lsp/node_modules/vscode-langservers-extracted/lib/json-language-server/node/jsonServerMain.js"));' >$HOME/.local/share/nvim/mason/bin/vscode-json-language-server



    echo '#!/usr/bin/env node
const path = require("path");
// require(path.join(__dirname, "/../lib/markdown-language-server/node/main.js"));


// require(path.join(__dirname, "../packages/vscode-langservers-extracted/lib/markdown-language-server/node/main.js"));


require(path.join(__dirname, "../packages/html-lsp/node_modules/vscode-langservers-extracted/lib/markdown-language-server/node/main.js"));' >$HOME/.local/share/nvim/mason/bin/vscode-markdown-language-server

    exe $HOME/.local/share/nvim/mason/bin/vsco*

    sed -i "s/\"/'/g" $HOME/.local/share/nvim/mason/bin/vscode*

end
