#!/bin/bash

extensions=('alexcvzz.vscode-sqlite'
'bradlc.vscode-tailwindcss'
'budparr.language-hugo-vscode'
'bung87.rails'
'bung87.vscode-gemfile'
'bungcip.better-toml'
'castwide.solargraph'
'davidanson.vscode-markdownlint'
'GitHub.copilot'
'github.vscode-pull-request-github'
'GrapeCity.gc-excelviewer'
'hridoy.rails-snippets'
'mechatroner.rainbow-csv'
'ms-azuretools.vscode-docker'
'ms-vscode-remote.remote-containers'
'mtxr.sqltools'
'rebornix.ruby'
'redhat.vscode-yaml'
'streetsidesoftware.code-spell-checker'
'wingrunr21.vscode-ruby'
)

for ext in ${extensions[*]}
do
    code --install-extension $ext
done

