// Solidity Contract for a Game of Rock, Paper and Scissors.
pragma solidity ^0.4.17;

// Contract for Rock Paper Scissors Game
contract RockPaperSicissors{
  // Parameters of game
  // Owner Address
  address public game_owner;
  // Dealer Address
  address public game_dealer;
  // Player Address
  address public game_player;

  // Dealer's Fund
  uint public dealerFund;
  // Game Player's Fund
  uint public playerFund;

  bool ended;

  // Events that get fired on Changes.
  event GameState(string winner, uint amount);
  event GameEnded(address winner, uint amount);

  // For Metacoin, map address to uint type
  mapping (address => uint) balances;
  event Transfer(address indexed _from, address indexed _to, uint256 _value);

  // Create the Game
  // Assign Game Owner to do the Admin Stuff
  function game() public {
    game_owner = msg.sender;
  }

  // Function to set the Dealer values
  function setDealer(address dealer, uint fund) public returns (bool success){
    game_dealer = dealer;
    balances[game_dealer] = fund;
    return true;
  }

  // Function to set the Player Values
  function setPlayer(address player, uint fund) public returns (bool success){
    game_player = player;
    balances[game_player] = fund;
    return true;
  }

  // Compare Actions of Dealer and Player to decide who won the game
  // Actions: 0: Rock, 1: Paper, 2: Scissor
  function compareActions(uint dealerAction, uint playerAction, uint bettingAmount) public returns (string results){
    // If both the dealer and Player do the same action like both "rock", the game is a Tie
    if (dealerAction == playerAction){
      results = 'Its a Tie... Play Again !!';
      GameState(results, bettingAmount);
      return results;
    }

    // If the actions are different, find out who is the winner
    bool isPlayerWinner = false;

    // If dealer Action is a Rock
    if (dealerAction == 0){
      // If Player Action is a Paper
        if (playerAction == 1){
          results = 'Player Won the Game !!';
          isPlayerWinner = true;
        }
        // If Player Action is a Scissors
        else if (playerAction == 2){
          results = 'Dealer Won the Game !!';
          isPlayerWinner = false;
        }
    }
   // If dealer Action is a Paper
    else if (dealerAction == 1){
      // If Player Action is a Rock
        if (playerAction == 0){
          results = 'Dealer Won the Game !!';
          isPlayerWinner = false;
        }
        // If Player Action is a Scissors
        else if (playerAction == 2){
          results = 'Player Won the Game !!';
          isPlayerWinner = true;
        }
    }
    // If dealer Action is a Scissor
    else if (dealerAction == 2){
      // If Player Action is a Rock
        if (playerAction == 0){
          results = 'Player Won the Game !!';
          isPlayerWinner = true;
        }
        // If Player Action is a Paper
        else if (playerAction == 1){
          results = 'Dealer Won the Game !!';
          isPlayerWinner = false;
        }
    }

    // Update Game State
    GameState(results, bettingAmount);

    // If Someone won the game, send the coins from the losing person to the winning person
    if (isPlayerWinner){
      // If player won the match and dealer has the coins, send the coins to the player.
      // Returns TRUE
      if (sendCoin(game_dealer, game_player, bettingAmount)){
        //Continue Game
      }
      // else, if the dealer does not have enough coins to send to the Player, tell that the dealer is now Bankrupt
      else{
        //end the game
        ended = true;
        results = 'Dealer ran out of money !!';
        GameEnded(game_player, getEthBalance(game_player));
      }
    }
    // else, if the dealer won the game, do the opposite
    else{
      if (sendCoin(game_player, game_dealer, bettingAmount)){
        // continue game
      }
      else{
        if (sendCoin(game_player, game_dealer, bettingAmount)){
          // continue game
        }
        else{
          // game ended
          ended = true;
          results = 'Player ran out of money !!';
          GameEnded(game_dealer, getEthBalance(game_dealer));
        }
      }
    }
      return results;
  }


  // Function to Send or Recieve Game Coins using Smart Contract
  // Inputs: Sender Address, Receiver Address, Amount to be sent
  // Return: Is Amount Sufficient in Account of Sender ?? True/False
  function sendCoin(address sender, address receiver, uint amount) public returns(bool sufficient){
    // If not enough amount, return false
    if (balances[sender] < amount) return false;
    // If sender has balance avaialble, reduce it from his account
    balances[sender] -= amount;
    // Add the amount sent to the receiver's account
    balances[receiver] += amount;
    // Transfer the Amount from Sender to Receiver
    Transfer(sender, receiver, amount);
    return true;
  }

  // Function to get user's current Eth balance
  function getEthBalance(address addr) public view returns(uint){
    return convert(getBalance(addr),1);
  }

  // Function to Convert the Amount into Eth Balance using Conversion Rate
  function convert(uint amount, uint conversionRate) public pure returns(uint convertedAmount){
    return amount * conversionRate;
  }

  // Function to get the Balance for Current Account Address
  function getBalance(address addr) public view returns (uint){
    return balances[addr];
  }
}
