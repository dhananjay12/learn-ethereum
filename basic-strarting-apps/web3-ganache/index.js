/*##########################
##     CONFIGURATION      ##
##########################*/

//  -- Step 1: Set up the appropriate configuration
var Web3 = require("web3")
const EthereumTx = require('ethereumjs-tx').Transaction
var web3 = new Web3('HTTP://127.0.0.1:7545')

// -- Step 2: Set the sending and receiving addresses for the transaction.
var sendingAddress = 'ADDRESS FROM GANACHE GOES HERE'
var receivingAddress = 'ANOTHER ADDRESS FROM GANACHE GOES HERE'

// -- Step 3: Check the balances of each address
web3.eth.getBalance(sendingAddress).then(console.log)
web3.eth.getBalance(receivingAddress).then(console.log)

/*##########################
##  CREATE A TRANSACTION  ##
##########################*/

// -- Step 4: Set up the transaction using the transaction variables as shown
var rawTransaction = {
    nonce: web3.utils.toHex(1),
    to: receivingAddress,
    gasPrice: web3.utils.toHex(20000000),
    gasLimit: web3.utils.toHex(30000),
    value: web3.utils.toHex(100),
    data: web3.utils.toHex("")
}
//Data field is blank because we are making txn just between Expernally owned accounts.

// -- Step 5: View the raw transaction
rawTransaction

// -- Step 6: Check the new account balances (they should be the same)
web3.eth.getBalance(sendingAddress).then(console.log)
web3.eth.getBalance(receivingAddress).then(console.log)

// Note: They haven't changed because they need to be signed...

/*##########################
##  Sign the Transaction  ##
##########################*/

// -- Step 7: Sign the transaction with the Hex value of the private key of the sender
var privateKeySender = 'PRIVATE KEY OF SENDER GOES HERE'
var privateKeySenderHex = new Buffer.from(privateKeySender, 'hex')
var transaction = new EthereumTx(rawTransaction)
transaction.sign(privateKeySenderHex)

/*#########################################
##  Send the transaction to the network  ##
#########################################*/

// -- Step 8: Send the serialized signed transaction to the Ethereum network.
var serializedTransaction = transaction.serialize();
web3.eth.sendSignedTransaction(serializedTransaction);