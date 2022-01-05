## Secret Messenger App

App is a basic html and valina JS, served using nodejs.

### Accounts setup

Start Ganache which will be our local ethereum network to test.

Install Metamask and import couple of accounts from Gananche to it. Although one is enough, but we will be using one to deploy the contract. The other will be used by iur webapp.

### Deploy Contract

Using [remix](https://remix.ethereum.org/) compile and deploy the following contract. In enviorment use `Injected Web3` which will open up Metamask. Select the account and deploy.

Contract to deploy - [message.sol](./contracts/message.sol)

After you compile, copy the ABI from remix UI, or just use this: 
```
[
	{
		"inputs": [],
		"name": "getMessage",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "x",
				"type": "string"
			}
		],
		"name": "setMessage",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
```

It has 2 methods `setMessage` and `getMessage`.

This is what we will copy in our JS  `abi` variable. 

Also, after you deploy your contract from remix to ganache, you need to copy the 
deployed contract address and put in `contactAddress` variable in JS.

### Run App

Run:
```
node server.js
```
and open http://localhost:3000/

It will attemp to find metamask and ask you to connect with an account. Choose any of the imported one.

`GET` button will fetch the `myMessage` value from the deployed contract. 
`SET` button will set a new value to it.

Switch between remix and the app to see the value and Ganache UI to see the transactions.

Other links:

Metamask docs - https://docs.metamask.io/guide/getting-started.html