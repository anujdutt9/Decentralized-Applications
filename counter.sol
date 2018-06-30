// Solidity Contract for a basic Counter to add and Subtract a "1" from the number

// Instruct the compiler about how to treat the source code
// Here that is versiono of the language
pragma solidity ^0.4.16;

// Create the Contract Function
contract HelloWorld{
    
    // Define Global Variable Counter of Type uint256 i.e. 256 bit unsigned integer
    uint256 counter = 5;
    
    // Function to Increase Counter by One
    // Public Modifier
    function add() public{
        counter ++;
    }
    
    // Function to Subtract the Counter Value by One
    // Public Modifier
    function sub() public{
        counter --;
    }
    
    // Function to Output the Value of Counter on Performing Operations
    // Function returns the value of counter of type uint256
    function getCounter() public constant returns (uint256){
        return counter;
    }
}
