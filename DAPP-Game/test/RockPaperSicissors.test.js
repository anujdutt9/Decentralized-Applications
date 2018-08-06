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


// Get list of Accounts
// web3.eth.accounts

// Set Dealer and Player
// RockPaperScissors.deployed().then(function(temp){temp.setDealer(web3.eth.accounts[0], 1000).then(console.log);})
// RockPaperScissors.deployed().then(function(temp){temp.setPlayer(web3.eth.accounts[1], 1000).then(console.log);})


// Get Player and Dealer Initial Balance
// RockPaperScissors.deployed().then(function(temp){temp.getBalanceInEth(web3.eth.accounts[0]).then(console.log);})
// RockPaperScissors.deployed().then(function(temp){temp.getBalanceInEth(web3.eth.accounts[1]).then(console.log);})


// Start Game by calling function with option for dealer and player (Rock: 0, Paper: 1, Scissors: 2) with betting amount
// RockPaperScissors.deployed().then(function(temp){temp.compare(0, 1, 500).then(console.log);})

// Play the game until either of the parties is bankrupted.
￼
