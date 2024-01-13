#!/bin/bash
# $1 project name
echo "creating project $1"

# Step 1: Create a new project directory
mkdir $1
cd $1

# Step 2: Initialize a new Node.js project
npm init -y

# Step 3: Install TypeScript
pnpm install --save-dev typescript ts-node @types/node

# Step 4: Create tsconfig.json
npx tsc --init --rootDir src --outDir dist --esModuleInterop --lib esnext,dom --target esnext

# Step 5: Create source and distribution directories
mkdir src dist

# Step 6: Create a sample TypeScript file
echo "console.log('Hello, TypeScript!');" > src/index.ts

# Step 7: Add start script in package.json
npx json -I -f package.json -e 'this.scripts["start"] = "ts-node src/index.ts";this.scripts["build"] = "tsc"'

echo "Node.js project with TypeScript support has been created."

npm run start

