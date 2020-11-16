const EliteswapV2Router02 = artifacts.require("EliteswapV2Router02");

// addresses[0]: 0x2D942Bc34754DD9A1aB2Da986fC545A0dAFF2cfB (Eliteswap: Deployer 2)

module.exports = async function (deployer, network, addresses) {
  let wethAddress;
  let factoryAddress;
  
  if (network === 'mainnet' || network === 'mainnet-fork') {
    wethAddress = await '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2';
    factoryAddress = await '0x81c27D1A0a6413c6A6d6d8e54B0A9C869d16771C';
  } else if (network === 'ropsten' || network === 'ropsten-fork') {
    wethAddress = await '0xc778417E063141139Fce010982780140Aa0cD5Ab';
    factoryAddress = await '0xb4e0d45B7f7314e540285C2dd300576B2a26195e';
  } else {
    throw new Error('No Elite Swap on this network')
  }
  
  await deployer.deploy(EliteswapV2Router02, factoryAddress, wethAddress);
};
