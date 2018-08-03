// The code in this file is used to deploy the contract to Test Etherium Network
const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compile');

// Setup HD Wallet Provider
const provider = new HDWalletProvider(
  '12 word phrase from metamask',
  'https://rinkeby.infura.io/v3/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
);

const web3 = new Web3(provider);

const INITIAL_STRING = 'Hello World !!'

// Async Function
const deploy = async () => {
  const accounts = await web3.eth.getAccounts();
  console.log('Attempting to deploy from account: ', accounts[0]);
  const result = await new web3.eth.Contract(JSON.parse(interface)).deploy({ data: '0x' + bytecode, arguments: [INITIAL_STRING]}).send({ from: accounts[0], gas: '1000000' });

 // Log address of location where the contract got deployed
  console.log('Contract deployed to: ', result.options.address);
};
deploy();
