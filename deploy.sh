#!/bin/sh
set -e

eval "$(ssh-agent -s)"
openssl aes-256-cbc -K $encrypted_509bb3f1cc0b_key -iv $encrypted_509bb3f1cc0b_iv -in elm-fontawesome-example.enc -out elm-fontawesome-example-deploy-key -d
chmod 600 ./elm-fontawesome-example-deploy-key
ssh-add ./elm-fontawesome-example-deploy-key

npm install -g node-jq

git config --global user.name "Gareth Latty"
git config --global user.email "gareth@lattyware.co.uk"

git clone "git@github.com:Lattyware/elm-fontawesome-example.git"
cd elm-fontawesome-example
pkg="elm.json"
tmp=$(mktemp)
npx jq "del(.dependencies.direct.\"lattyware/elm-fontawesome\")" "${pkg}" > "${tmp}" && mv "${tmp}" "${pkg}"
echo "Y" | elm install lattyware/elm-fontawesome
git add -A
git commit -m "Update to use elm-fontawesome ${TRAVIS_TAG}"
git push --quiet
