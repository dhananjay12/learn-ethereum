## Secret Messenger App

### Truffle

https://trufflesuite.com/tutorial/index.html

Install truffle globally

```
npm install -g truffle
```

and the project folder was created using `truffle init`. It will create the extra folders you see. Put your contracts in contract folder.

Configure the local ganache server in `truffle-config.js`:

```
  development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    }
```

Change the migration script according to your contract:
```
const Message = artifacts.require("Message");

module.exports = function (deployer) {
  deployer.deploy(Message);
};

```

Compile:
```
truffle compile
```

The result ABI will be generated in the `build` folder.

Deploy:
```
truffle deploy
```

Check the logs for `contract address` and use that in your index.html.

Now **you dont need remix at all**, and the contact ABI can be called directly from frontend using ajax call:
```
 $.getJSON("build/contracts/Message.json", function (result) {
            abi = result.abi
        });
```
You might want to check the server.js on how to server multiple folders fro express.

Run app:
```
node server.js
```

