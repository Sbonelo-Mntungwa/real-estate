// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract RealEstate {

    //PROPERTY FUNCTION
   function listProperty() external returns (uint256){}

   function updateProperty() external returns (uint256){}

   function buyproperty() external payable {}

   function getAllProperties() public view returns(Property[] memory){}

   function getProperty() external view returns(){}

   function getUserProperties() external view returns(Property[] memory){}

    //REVIEW FUNCTION
   function addReview() external{}

   function getProductReviews() external view returns(Review[] memory){}
}