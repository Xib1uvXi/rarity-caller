const RarityCaller = artifacts.require("RarityCaller");

module.exports = function (deployer) {
  deployer.deploy(RarityCaller);
};