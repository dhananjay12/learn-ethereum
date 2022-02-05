## Simple contract with Truffle

Create a folder and run `npm init` and `truffle init`. Truffle will create couple of folders with sample files. 
One is a sample solidity contract and the other how to deploy it. `truffle-config.js` contains its configuration. 
Just run `truffle compile` and see the build directory.

We will be deploying to `Ganache`.
Add the following network configuration here:
```
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,       
      network_id: "*"
    }
  }
```

Open up `Ganache` and create a new project. Point your `truffle-config.js` file to this from the UI.
Now from the root folder of the project just run `truffle migrate`.
