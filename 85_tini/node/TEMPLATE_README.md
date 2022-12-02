# README

Demonstrates nodetini.  

TODO:

* Examine rules and plugins for eslint https://www.npmjs.com/package/eslint-plugin-jest


## How to run

```sh
nvm use
npm install

# use typescript compiler
npm run tsc -- --version  

# run targets
npm run start:dev

curl http://localhost:8000
curl http://localhost:8000/api
curl http://localhost:8000/api/ping
curl http://localhost:8000/api/sleep?wait=1000

npm run test
npm run lint

npm run docker:run
```

## How to recreate

Create folder  

```sh
mkdir xx_project_name
cd ./xx_project_name

# write out an .nvmrc file
node --version > .nvmrc        
```

Setup typescript for a basic nodejs project

```sh
npm init -y   
npm install typescript @types/node ts-node nodemon rimraf --save-dev  

# get typescript version
./node_modules/typescript/bin/tsc --version 

# create tsconfig.json
npx tsc --init --rootDir "." --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true --sourceMap
```

Add `scripts` section to `package.json`

```js
  "scripts": {
    "clean": "rimraf ./build",
    "build": "npm run clean && tsc",
    "start": "npm run build && node build/index.js",
    "rebuild": "npm run build && node build/index.js",
    "dev": "concurrently \"nodemon\" \"nodemon -x tsoa spec\"",
    "test": "jest",
    "coverage": "jest --coverage",
    "type-check": "tsc --noEmit",
    "type-check:watch": "npm run type-check -- --watch"
  },
```

Add a `nodemonConfig` to `package.json`

```json
  "nodemonConfig": {
    "watch": ["src", "nodemon.json", "tsconfig.json", "package.json"],
    "ext": "ts",
    "ignore": [],
    "exec": "ts-node ./src/index.ts"
  }
```

## Add Express

```sh
npm install --save express 
npm install --save-dev @types/express
```

## Add pino logging

```sh
npm install pino     
npm install express-pino-logger
npm install --save-dev @types/express-pino-logger
```

## Add extras

```sh
npm install --save-dev concurrently
```

## Install prettier

```sh
code --install-extension esbenp.prettier-vscode
npm install --save-dev prettier 

cat << EOF  > ./.prettierrc
{
  "useTabs": false,
  "semi":  false,
  "trailingComma":  "all",
  "singleQuote":  true,
  "printWidth":  120,
  "tabWidth":  2
}
EOF
```

```sh
#run it
npm run start
```

## Testing

```sh
npm install --save-dev jest-express jest @types/jest ts-jest
```

Add an `index.test.ts` to `tests`

```bash
mkdir -p ./tests
cat << EOF  > ./tests/index.test.ts
import { main } from '../src/index'

test('empty test', () => {
  // ARRANGE
  const a = 0
  // ACT

  // ASSERT
  expect(main()).toBe(0)
})
EOF
```

Add more targets to `scripts` section in `package.json`

```js
  "scripts": {
    "test": "jest",
    "coverage": "jest --coverage"
  },
```

Add a `jest.config.js` file

```sh
cat << EOF > ./jest.config.js
module.exports = {
  transform: {
    '^.+\\\\.ts?$': 'ts-jest',
  },
  testEnvironment: 'node',
  testRegex: 'tests/.*\\\\.(test|spec)?\\\\.(ts|tsx)$',
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
}
EOF
```

```sh
#test it
npm run test
```

## Add linting

Add a basic linter

```sh
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install eslint-plugin-prettier@latest eslint-config-prettier --save-dev 

# add an .eslintrc
cat << EOF > ./.eslintignore
node_modules
build
EOF

cat << EOF > ./.eslintrc
{
  "env": {
      "browser": false,
      "es2021": true
  },
  "extends": [
      "eslint:recommended",
      "plugin:@typescript-eslint/recommended",
      "plugin:prettier/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
      "ecmaVersion": 2019,
      "sourceType": "module"
  },
  "plugins": [
      "@typescript-eslint", 
      "prettier"
  ],
  "rules": {
      "prettier/prettier": [
          "error",
          {
              "useTabs": false,
              "semi":  false,
              "trailingComma":  "all",
              "singleQuote":  true,
              "printWidth":  120,
              "tabWidth":  2
          }]
  }
}
EOF
```

Add more targets to `scripts` section in `package.json`

```js
  "scripts": {
    "lint": "eslint . --ext .ts",
    "lint:fix": "eslint . --ext .ts --fix",
  },
```

```sh
#test it
npm run lint
```

## Debugging

Ensure that the sourcemap output is enabled.  

```json
  "sourceMap": true,  
```

Open `vscode` in the correct directory.  

```sh
# you must be in the code directory and not in the git root
cd ./xx_project_name
nvm install

# if the code is built it will use the version in here to debug
npm run clean
code .
```

1. Select `./src/index.ts` and put a breakpoint on the log line.  
2. Click the debug icon. Click on create a `launch.json` and select `node.js` NOTE: If you select Run and Debug it will fail because the code is not built.  
3. Click the debug icon again and then drop down the selection to select node.js and select a target of "start:dev"

The code should break on the breakpoint.  

## Resources

* https://www.split.io/blog/node-js-typescript-express-tutorial/
