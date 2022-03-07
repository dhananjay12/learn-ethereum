## Hardhat

Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software. 

https://hardhat.org/getting-started/

https://theprimeagen.github.io/web3-smart-contracts/


## Run

### Start local Ethereum node
```
npx hardhat node
```

### Deploy a Contract on local node

```
npx hardhat run scripts/deploy-counter.ts --network localhost
```

### Start FE (if applicable)

```
npx webpack serve
```
Check http://localhost:8080/

## Setup if Starting from scratch

### Project typical dependecies 

Dont have to do in the projects, just to keep 
```
npm install -D @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai
npm install -D ts-node typescript
npm install -D chai @types/node @types/mocha @types/chai
npm install -D webpack webpack-cli ts-loader html-webpack-plugin dotenv
npm install webpack-dev-server --save-dev

```

### Other typical Files

* Hardhat config file - `hardhat.config.ts`
```
import "@nomiclabs/hardhat-waffle";
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.10",
  networks: {
    hardhat: {
      chainId: 1337
    }
  }
};
```
* `tsconfig.json`
```
{
    "compilerOptions": {
        "resolveJsonModule": true,
        "esModuleInterop": true
    }
}
```
* `webpack.config.js`
```
const dotenv = require("dotenv");
dotenv.config();

const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const webpack = require("webpack");

module.exports = {
    entry: "./src/index.ts", // bundle"s entry point
    output: {
        path: path.resolve(__dirname, "dist"), // output directory
        filename: "[name].js", // name of the generated bundle
    },
    resolve: {
        extensions: [".js", ".ts", ".json"],
    },

    mode: "development",

    module: {
        rules: [
            {
                test: /\.ts$/,
                loader: "ts-loader",
                exclude: /node_modules/,
            },

            {
                test: /\.css$/i,
                use: ["style-loader", "css-loader"],
            },
        ],
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "./src/index.html",
            inject: "body",
        }),
        new webpack.DefinePlugin({
            //Replace with your contract address directly or via a .env file and putting CONTRACT_ADDRESS='soemthing' there
            'process.env.CONTRACT_ADDRESS': JSON.stringify(process.env.CONTRACT_ADDRESS), 
            'process.env.DEBUG': JSON.stringify(process.env.DEBUG),
        }),
    ],

    watch: true,

    devServer: {
        historyApiFallback: true,
        static: './'
    }
};
```

