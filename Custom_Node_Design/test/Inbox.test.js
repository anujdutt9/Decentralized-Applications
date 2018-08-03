// This file contains the Javascript code to test out the Solidity contract that is being compiled by the
// compile.js script. This script helps to automatically test the Solidity Contract for a range of different Inputs
// instead of entering them in one by one and testing for them using Remix.

// Import libraries
const assert = require('assert');

// Import Ganache-cli: Local Etherium Test Network
const ganache = require('ganache-cli');

// Import Web3
/// Web3: a Constructor function
const Web3 = require('web3');

// Web3: we use constructor function to make instances of Web3 library
// Provider: Communication layer b/w Web3 and Etherium layer; Communication means for communication between Web3 and Ganache.
// Providers are exchangeable

// Create instance of Web3 and tell it to connect to ganache or any other test network using the provider
const web3 = new Web3(ganache.provider());

// Get Bytecode and Interface ABI after Solidity Contract Compilation from "compile.js" file
const {interface, bytecode} = require('../compile');

let accounts;
let inbox;
const INITIAL_STRING = 'Hello World !!'

// Get list of accounts created automatically using Gnache Network
// Freely send/recieve data in Unlicked accounts
 beforeEach(async () => {
   // Get a list of all Unlocked accounts made by Gnache for Testing
   // "eth" module of web3 library.
   // Every function in Web3 Returns a Promise
   // Runs and waits for Web3 to return the list of accounts and then assigns the values to
   accounts = await web3.eth.getAccounts();

   // Use one of those accounts to deploy the contract
   // For deploying the contract, we need to get it's bytecode from compiler that wre got from "compile.js" file

   // await: As this will take some time to execute
   // web3.eth.Contract(): Access Contract property; allows to interact with existing contracts on blockchain or to deploy new contracts
   // Contract(ABI): first argument to Construct is the "ABI", interface between solidity and javascript.
   // JSON.parse(interface): Compilation of Solidity contract gives us a JSON object, so parse through it for our values

   // .deploy(): Tells Web3 that we want to deploy a new contract.
   // .deploy(data: type of data we want to pass, arguments: the value for "initialMessage")

   // .send(): Takes the contract and deplys to the network.
   // .send(from: account of person, gas: how much to spend?)
   inbox = await new web3.eth.Contract(JSON.parse(interface)).deploy({ data: bytecode, arguments: [INITIAL_STRING]}).send({ from: accounts[0], gas: '1000000' });
 });


// --------------------- Test Functions ----------------------------
describe('Inbox', () => {
  // TEST-1: Test to Check that our contract has been deployed or not
  it('deploys a contract', () => {
    // assert.ok(): checks if a valid values exists or not
    // Address: contains the address of wherever the compiled contract was deployed to
    assert.ok(inbox.options.address);
  });

  // TEST-2: Test to check that there is a default message for "initialMessage" in the contract
  // Here, default message is the one we sent as arguments while deploying this contract on Blockchain.
  // async await syntax to wait till the blockchain network responds
  it('has a default message', async () => {
    // Get the default message passed to the contract during deployment
    const message = await inbox.methods.message().call();
    // Check if the default message passed was equal to the string provided
    assert.equal(message, INITIAL_STRING);
  });

  // TEST-3: Test to see if we are able to set a value to the message variable in contract
  it('can change the message', async () => {
    // Attempt to change the message using "setMessage"
    // To set a Message, a transaction is called and we need to pay some gas on the network
    // Define who is going to pay for transaction inside "send(account)".
    await inbox.methods.setMessage('Welcome to Etherium Programming...').send({ from: accounts[0] });
    // Make a call to get the message value that has just been set
    const message = await inbox.methods.message().call();
    // Check if the new message that is set is actually set or not.
    assert.equal(message, 'Welcome to Etherium Programming...');
  });
});
// ------------------------------------------------------------------

// Testing the Contract using Mocha Framework
// Mocha: General Purpose Test running framework (Javascript/Etherium etc.)
// -------------- Test code for Mocha Test Framework ----------------
// class Car{
//   park(){
//     return 'stopped';
//   }
//
//   drive(){
//     return 'vroom';
//   }
// }
//
// // Initialize it here so that the "it" can also access it's value
// let car;
//
// // Instead of declaring the car as Instance everytime in "it", declare it here for once.
// beforeEach(() => {
//   // Make instance of class Car
//   car = new Car();
// });
//
// // Make a call using "describe" function
// describe('Car Class Test', () =>{
//   // "it" test statements
//   it('can park', () => {
//     // Test Setup and Assertion Logic
//     // Make instance of class Car
//     //const car = new Car();
//
//     // See if two values are equal, the one returned and the string
//     assert.equal(car.park(), 'stopped');
//   });
//
//   // Test the drive function
//   it('can drive', () => {
//     //const car = new Car();
//
//     assert.equal(car.drive(), 'vroom');
//   })
// });
