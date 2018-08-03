// This File contains the code to Compile the Solidity Contract code in order to return
// some Contract Bytecode and an ABI which is our Javascript interpretation layer about what the contract is.

// We cannot use require to load the Inbox.sol files as Node will think of that as a Javascript code and
// return with an Error.

// Build a Directory path from compile.js to Inbox.sol
// pathmodule provides Cross Platform compatibility
const path = require('path');

// File System Module to Read in the raw contents of the file
const fs = require('fs');

// Import Solidity Compiler
const solc = require('solc');

// Provide path to the Inbox.sol file in Contracts folder
const inboxPath = path.resolve(__dirname, 'contracts', 'Inbox.sol');

// Read in the Contents of the file i.e. raw source code from Inbox.sol
// Inputs: filePath, Encoding
const source = fs.readFileSync(inboxPath, 'utf8');

// Compile Statement using Solidity Compiler
// Compile Solidity Contract using solc
// Inputs: Raw Solidity Source Code and Number of Files
// Returns: Contract Info, Bytecode, Interface"ABI Layer data" etc.

// Console.log() to print to terminal
//console.log(solc.compile(source, 1));

// Adding "module.exports" so that the results of compiler are available to other Javascript files
// Since we only need the bytecode and Interface and not the rest of it, select only those from compiler output.
module.exports = solc.compile(source, 1).contracts[':Inbox'];
