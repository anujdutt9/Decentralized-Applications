// First Solidity Contract

// Define Version of Solidity that we are using
// Compiler will make sure that it uses this version of Solidity 
pragma solidity ^0.4.17;

// Contract Definition Class
// Contrat: keyword
contract Inbox {
    // Storage Variable -> Instance Variable, exists for life of contract
    // Public: Accessible to anyone in the world
    // string: it'll always contain a string
    // public: who has access to see contents of this variable
    // Whenever we change the value of variable message, it'll get stored forever on blockchain
    // Whenever we create a variable with public, it creates a new function at backedn automatically which we can see on right as "variable name"
    string public message;
    
    // Constructor Funciton: Inbox
    // Gets invoked automatically when contract is deployed to blockchain
    function Inbox(string initialMessage) public {
        message = initialMessage;
    }
    
    // Function to set Message Variable Value
    // Takes as input a string into variable "newMessage"
    function setMessage(string newMessage) public {
        message = newMessage;
    }
    
}



// Common Function Types:

// 1. public: anyone can call this Function
// 2. private: Only this contract can call this Function
// 3. view: This function returns data and does not modify this contract's data
// 4. constant: This function returns data and does not modify contract's data
// 5. pure: This function will not modify or even read contract's data
// 6. payable: When someone calls this function, they might send ether along
