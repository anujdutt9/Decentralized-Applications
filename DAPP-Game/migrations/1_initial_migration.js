var Migrations = artifacts.require("./RockPaperSicissors.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
