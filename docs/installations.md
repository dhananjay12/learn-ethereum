## Install

### Geth

https://geth.ethereum.org/docs/install-and-build/installing-geth

```
brew tap ethereum/ethereum
brew install ethereum
```

### Ganache

https://www.trufflesuite.com/ganache

### Truffle

https://www.trufflesuite.com/truffle
```
npm install truffle -g
```

### Metamask
A Dapp browser is a web browser connected to an Ethereum node


### Private Node MacOS
Truffle and Ganache are emulators. Although they have the same interface, they work differently internally. You can 
actually create real Ethereum nodes locally.

```
mkdir -p ethereum-tutorial && cd ethereum-tutorial
mkdir -p private && cd private

```
Puppeth is a command-line tool that's installed with Geth and that provides features to create and monitor your 
own Ethereum network.
```
➜  private puppeth
+-----------------------------------------------------------+
| Welcome to puppeth, your Ethereum private network manager |
|                                                           |
| This tool lets you create a new Ethereum network down to  |
| the genesis block, bootnodes, miners and ethstats servers |
| without the hassle that it would normally entail.         |
|                                                           |
| Puppeth uses SSH to dial in to remote servers, and builds |
| its network components out of Docker containers using the |
| docker-compose toolset.                                   |
+-----------------------------------------------------------+

Please specify a network name to administer (no spaces, hyphens or capital letters please)
> myfirstchain

Sweet, you can set this via --network=myfirstchain next time!

INFO [11-09|02:10:09.488] Administering Ethereum network           name=myfirstchain
WARN [11-09|02:10:09.490] No previous configurations found         path=/Users/dhananjay/.puppeth/myfirstchain

What would you like to do? (default = stats)
 1. Show network stats
 2. Configure new genesis
 3. Track new remote server
 4. Deploy network components
> 2

What would you like to do? (default = create)
 1. Create new genesis from scratch
 2. Import already existing genesis
> 1

Which consensus engine to use? (default = clique)
 1. Ethash - proof-of-work
 2. Clique - proof-of-authority
> 1

Which accounts should be pre-funded? (advisable at least one)
> 0x

Should the precompile-addresses (0x1 .. 0xff) be pre-funded with 1 wei? (advisable yes)
> 

Specify your chain/network ID if you want an explicit one (default = random)
> 4224
INFO [11-09|02:10:59.239] Configured new genesis block 

What would you like to do? (default = stats)
 1. Show network stats
 2. Manage existing genesis
 3. Track new remote server
 4. Deploy network components
> 2

 1. Modify existing configurations
 2. Export genesis configurations
 3. Remove genesis configuration
> 2

Which folder to save the genesis specs into? (default = current)
  Will create myfirstchain.json, myfirstchain-aleth.json, myfirstchain-harmony.json, myfirstchain-parity.json
> 
INFO [11-09|02:11:30.470] Saved native genesis chain spec          path=myfirstchain.json
INFO [11-09|02:11:30.472] Saved genesis chain spec                 client=aleth path=myfirstchain-aleth.json
INFO [11-09|02:11:30.473] Saved genesis chain spec                 client=parity path=myfirstchain-parity.json
INFO [11-09|02:11:30.475] Saved genesis chain spec                 client=harmony path=myfirstchain-harmony.json

What would you like to do? (default = stats)
 1. Show network stats
 2. Manage existing genesis
 3. Track new remote server
 4. Deploy network components
```
Use `ctrl+c` or `ctrl+d` to exit. Check `myfirstchain.json`.

#### Initialise the genesis block
From the `private` directory
```
geth --datadir ~/ethereum-tutorial/private init myfirstchain.json
```
You will see `geth` and `keystore` directory created. `Geth` will store the blockchain instance data, and `keystore` will
store all of our accounts. You wont have anything in keystore yet.

#### Creating accounts
Lets create 3 accounts, 1 for mining, and 2 for buyer and seller. Make sure you remember all the password, or just use the 
same one for all.
```
geth --datadir . account new
```
You will have different address for each one. Private key of each one is stored in keystore
```
➜ ls keystore/
```
Also the list of account are also on the node
```
➜  geth --datadir . account list
```
#### Start Blockchain
Full docs - https://geth.ethereum.org/docs/interface/command-line-options

Create a `startnode.sh` in the private folder.
```
vi startnode.sh
```
```
geth --networkid 4224 --mine --miner.threads 1 --datadir "~/ethereum-tutorial/private" \
--nodiscover --http --http.port "8545" --port "30303" --http.corsdomain "*" --nat "any" \
--http.api eth,web3,personal,net --unlock 0 --allow-insecure-unlock --password ~/ethereum-tutorial/private/password.sec \
--ipcpath "~/Library/Ethereum/geth.ipc"
```

Create another file named `password.sec` in `private` folder with your password.
```
vi password.sec
```
Make this script executable and then run
```
chmod +x startnode.sh
sh startnode.sh
```
Wait for all the DAGs to get generated. In the middle you may see mining taking place. If there is no transaction what is 
it mining? Mining is not only for transaction, it is also to generate Ether. In our case this goes to the first account.
So remember, blocks will be there even without any transaction. This happens even in main network.

#### Connect to running geth

In a new terminal
```
geth attach
```
You will enter into the Geth Javascript console. Here, you can run JavaScript code.

Queries:
```
eth.accounts
eth.getBalance(eth.accounts[0])
```
The balance is shown in Wei. To convert this in Ether:
```
web3.fromWei(eth.getBalance(eth.accounts[0]), "ether")
```
You can use 
```
> eth.coinbase
"0xd6056aa3915a695921c1b440f40f0faf4f666f07"
```
Here coinbase means, the main address for mining rewards, so the first account that is minig. The coinbase.com is named
after this concept.
To Start or Stop mining
```
miner.stop()
miner.start()
```
This could return null/true.

Send some transactions:
Lets send from coinbase account to account 1. Lets say 10 ether.
```
eth.sendTransaction({from: eth.coinbase, to: eth.accounts[1], value: web3.toWei(10, "ether")})
```
Above will return a hash. In the second console you will see that hash and getting mined.
To check the balance of eth in account 1 run:
```
web3.fromWei(eth.getBalance(eth.accounts[1]), "ether")
```

To quit geth console, use - `exit`.
