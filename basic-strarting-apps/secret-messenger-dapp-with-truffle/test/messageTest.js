const messageDefintion = artifacts.require("message")

contract("message", accounts =>{
 
    var owner = accounts[0]
    var contractInstance 

    beforeEach(async function () { 
        contractInstance = await messageDefintion.new()
    })

    describe('message basic test', () => { 
        it('has empty myMessage at start', async function () { 
            assert.equal(await contractInstance.getMessage(), '')
        })

        it('set myMessage and check', async function () { 
            await contractInstance.setMessage("test")
            assert.equal(await contractInstance.getMessage(), "test")
        })
    })

});