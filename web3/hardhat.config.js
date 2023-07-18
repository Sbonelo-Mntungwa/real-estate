/** @type import('hardhat/config').HardhatUserConfig */

const PRIVATE_KEY = "8253bea878610ebbc46313692cf65bb687dadf02b3e0ee6766063ed7c5295d77";
const RPC_URL = "https://rpc.ankr.com/polygon_mumbai";

module.exports = {
  defaultNetwork: "polygon_mumbai",
  networks: {
    hardhat: {
      chainId: 80001,
    },
    polygon_mumbai:{
      url: RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    },
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
