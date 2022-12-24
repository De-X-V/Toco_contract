const pF = artifacts.require("ProjectFunding");

module.exports = function (deployer) {
  deployer.deploy(pF, "0xd32Aa1518aAF1e60C5076EbeEEb3992f022878A4");
};
