const cF = artifacts.require("ChangesFunding");

module.exports = function (deployer) {
  deployer.deploy(cF, "0xd32Aa1518aAF1e60C5076EbeEEb3992f022878A4");
};
