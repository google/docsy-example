#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

cd public

if [ -n "$GITHUB_AUTH_SECRET" ]
then
    touch ~/.git-credentials
    chmod 0600 ~/.git-credentials
    echo $GITHUB_AUTH_SECRET > ~/.git-credentials    git config credential.helper store
    git config user.email "mixxit-bot@users.noreply.github.com"
    git config user.name "mixxit-bot"
fi

git add .
git commit -m "Rebuild site"
git push --force origin HEAD:master