const pF = artifacts.require("ProjectFunding");

module.exports = function (deployer) {
  deployer.deploy(pF, "0x1F4E5a28bc415b7941391C6c26F8fd14d83b6c46");
};
