const EliteswapV2Router02 = artifacts.require("EliteswapV2Router02");

module.exports = async function (deployer, network, addresses) {
  let wethAddress;
  let factoryAddress;
  
  if (network === 'bsc_mainnet' || network === 'bsc_mainnet-fork') {
    wethAddress = await '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';
    factoryAddress = await '0x3Ce6feac2DC11a8799dC2a4B9434c5943E1c69EE';
  } else if (network === 'bsc_testnet' || network === 'bsc_testnet-fork') {
    wethAddress = await '0xaE8E19eFB41e7b96815649A6a60785e1fbA84C1e';
    factoryAddress = await '0x7E4a14EeF571ebbe2AE71659Cd7d7d963DB13Ea0';
  } else {
    throw new Error('No Elite Swap on this network')
  }
  
  await deployer.deploy(EliteswapV2Router02, factoryAddress, wethAddress);
};
