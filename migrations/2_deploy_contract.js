const KeyGame = artifacts.require("./KeyGame.sol");

module.exports = function(deployer) {
  deployer.deploy(KeyGame);
};
