#!/bin/bash
# $1 project name
echo "creating project $1"

# Step 1: Create a new project directory
mkdir $1
cd $1

# Step 2: Initialize a new Node.js project
npm init -y

# Step 3: Install TypeScript
pnpm install --save-dev typescript @types/node

# Step 4: Create tsconfig.json
npx tsc --init --rootDir src --outDir dist --esModuleInterop --lib esnext,dom --target esnext --module esnext

# Step 5: Create source and distribution directories
mkdir src dist

# Step 6: Create a sample TypeScript file
# miss semi for test if lint is working
echo "console.log('Hello, TypeScript!')" > src/index.ts

# Step 7: Add start script in package.json
npx json -I -f package.json -e 'this.scripts["build"] = "tsc";this.scripts["start"] = "npm run build && src/index.ts"'

# Add eslint support
pnpm install --save-dev eslint-config-airbnb-base
npx json -I -f package.json -e 'this.scripts["lint"] = "eslint ."'
# add .eslintignore
echo "node_modules/
dist/" > .eslintignore
# add typescript lint support 
pnpm add --save-dev @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Add prettier
# https://github.com/prettier/stylelint-prettier
pnpm add --save-dev --save-exact prettier
pnpm install --save-dev eslint-config-prettier eslint-plugin-prettier

# use esmodule
pnpm install eslint-plugin-plugin:import/recommended@latest --save-dev
npx json -I -f package.json -e 'this.scripts["type"] = "module"'


echo "{
  "singleQuote": true,
  "tabWidth": 2,
  "useTabs": false
}" >> .prettierrc

# Add .eslintrc.js
echo "module.exports = {
  env: {
    node: true,
    es2024: true,
  },
  extends: [
    'eslint-config-airbnb-base',
    'plugin:import/recommended',
    'plugin:import/typescript',
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended',
  ],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  settings: {
    'import/resolver': {
      typescript: true,
      node: true,
    },
  },
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {},
  root: true,
};" >> .eslintrc.js

echo "Node.js project with TypeScript support has been created."

npm run start
# should find miss semi error
npm run lint
