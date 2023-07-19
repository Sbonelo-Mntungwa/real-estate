import React, { useContext, createContext } from "react";
import {
  useAddress,
  useContract,
  useMetamask,
  useContractWrite,
} from "@thirdweb-dev/react";
const StateContext = createContext();

export const StateContextProvider = ({ children }) => {
  const { contract } = useContract(
    "0x0730361Cde99726437E3567b9e493Ff7e51Fa46f"
  );

  const address = useAddress();
  const connect = useMetamask();
  const realEstate = "Real Estate dapp";

  const { mutateAsync: listProperty, isLoading } = useContractWrite(
    contract,
    "listProperty"
  );

  const createPropertyFunction = async (form) => {
    const {
      propertyTitle,
      description,
      category,
      price,
      images,
      propertyAddress,
    } = form;

    try {
      const data = await listProperty({
        args: [
          address,
          price,
          propertyTitle,
          category,
          images,
          propertyAddress,
          description,
        ],
      });
      console.info("contract call successs", data);
    } catch (err) {
      console.error("contract call failure", err);
    }
  };

  return (
    <StateContext.Provider
      value={{ address, connect, contract, realEstate, createPropertyFunction }}
    >
      {children}
    </StateContext.Provider>
  );
};

export const useStateContext = () => useContext(StateContext);
