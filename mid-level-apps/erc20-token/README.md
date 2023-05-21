# ERC20 and DEX Contract

This project provides two smart contracts, one that implements a ERC20 token and another that allows users to sell/transfer their tokens. This project includes automated testing and a slim frontend for interacting with these contracts.

Try running some of the following tasks:

* To test the contract run `npx hardhat test`
* To deploy the contract to your localhost network do the following:
    * `npx hardhat node`
    * `npx hardhat run --network localhost ./script/deploy.js`

## Using the Frontend

1. Install the [Liveserver Extension](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) in VSCode.
2. Open [base.html](frontend/base.html)
3. Click the button that says "Go Live" in the bottom right hand corner of your VSCode.
4. Import any accounts you need into MetaMask and change your MetaMask network to "Hardhat".
5. Interact with the contract!