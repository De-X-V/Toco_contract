const pF = artifacts.require("ProjectFunding");

module.exports = function (deployer) {
  deployer.deploy(pF, "0x30eDdf84A2bdE0F26457a727775C826892D11ef9");
};
