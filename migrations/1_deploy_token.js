const USDToken = artifacts.require("./USDToken.sol");

module.exports = function(deployer) {
  deployer.deploy(USDToken);
};
