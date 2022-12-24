const Admin = artifacts.require("Administrator");

module.exports = function (deployer) {
  deployer.deploy(Admin);
};
