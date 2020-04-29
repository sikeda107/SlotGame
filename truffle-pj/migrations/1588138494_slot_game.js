const SlotGame = artifacts.require('SlotGame');
module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(SlotGame, { gas: 2000000 });
};
