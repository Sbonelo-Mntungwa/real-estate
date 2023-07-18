// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract RealEstate {
    //STRUCTS
    struct Property {
        uint256 propertyId;
        address owner;
        uint256 price;
        string propertyTitle;
        string category;
        string images;
        string properyAddress;
        string description;
        address[] reviewers;
        string[] reviewer;
    }

    struct Review {
        address reviewer;
        uint256 productId;
        uint256 rating;
        string comment;
        uint256 likes;
    }

    struct Product {
        uint256 productId;
        uint256 totalRating;
        uint256 numReviews;
    }

    //MAPPING
    mapping(uint256 => Property) private properties;
    mapping(uint256 => Review[]) private reviews;
    mapping(address => uint256[]) private userReviews;
    mapping(uint256 => Product) private products;

    //VARIABLES
    uint256 public propertyIndex;
    uint256 public reviewsCounter;

    //EVENTS
    event PropertyListed(
        uint256 indexed id,
        address indexed owner,
        uint256 price
    );

    event PropertySold(
        uint256 indexed id,
        address indexed oldOwner,
        address indexed newOwner,
        uint256 price
    );

    event PropertyResold(
        uint256 indexed id,
        address indexed oldOwner,
        address indexed newOwner,
        uint256 price
    );

    event ReviewAdded(
        uint256 indexed productId,
        address indexed reviewer,
        uint256 rating,
        string comment
    );

    event ReviewLiked(
        uint256 indexed productId,
        uint256 indexed reviewIndex,
        address indexed liker,
        uint256 likes
    );

    //FUNCTIONS
    function listProperty(
        address owner,
        uint256 price,
        string memory _propertyTitle,
        string memory _category,
        string memory _images,
        string memory _propertyAddress,
        string memory _description
    ) external returns (uint256) {
        require(price > 0, "Price must be greater than 0.");

        uint256 productId = propertyIndex++;

        Property storage property = properties[productId];
        property.propertyId = productId;
        property.owner = owner;
        property.price = price;
        property.propertyTitle = _propertyTitle;
        property.category = _category;
        property.images = _images;
        property.properyAddress = _propertyAddress;
        property.description = _description;

        emit PropertyListed(productId, owner, price); //trigger event

        return productId;
    }

    function updateProperty(
        address owner,
        uint256 productId,
        string memory _propertyTitle,
        string memory _category,
        string memory _images,
        string memory _propertyAddress,
        string memory _description
    ) external returns (uint256) {
        Property storage property = properties[productId];

        require(property.owner == owner, "You are not the owner");

        property.propertyTitle = _propertyTitle;
        property.category = _category;
        property.images = _images;
        property.properyAddress = _propertyAddress;
        property.description = _description;

        return productId;
    }

    function updatePrice(
        address owner,
        uint256 productId,
        uint256 price
    ) external returns (string memory) {
        Property storage property = properties[productId];

        require(property.owner == owner, "You are not the owner");

        property.price = price;

        return "Your property price is updated";
    }

    function buyProperty(uint256 id, address buyer) external payable {
        uint256 amount = msg.value;

        require(amount >= properties[id].price, "Insufficient funds");

        Property storage property = properties[id];

        (bool sent, ) = payable(property.owner).call{value: amount}("");

        if (sent) {
            property.owner = buyer;
            emit PropertySold(id, property.owner, buyer, amount);
        }
    }

    function getAllProperties() public view returns (Property[] memory) {
        uint256 itemCount = propertyIndex;
        uint256 currentIndex = 0;

        Property[] memory items = new Property[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;

            Property storage currentItem = properties[currentId];
            items[currentIndex] = currentItem;
            currentIndex += 1;
        }

        return items;
    }

    function getProperty(
        uint256 id
    )
        external
        view
        returns (
            uint256,
            address,
            uint256,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        Property memory property = properties[id];
        return (
            property.propertyId,
            property.owner,
            property.price,
            property.propertyTitle,
            property.category,
            property.images,
            property.properyAddress,
            property.description
        );
    }

    function getUserProperties(
        address user
    ) external view returns (Property[] memory) {
        uint256 totalItemCount = propertyIndex;
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (properties[i + 1].owner == user) {
                itemCount += 1;
            }
        }

        Property[] memory items = new Property[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (properties[i + 1].owner == user) {
                uint256 currentId = i + 1;
                Property storage currentItem = properties[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function addReview() external {}

    function getProductReviews() external view returns (Review[] memory) {}

    function getUserReviews() external view returns (Review[] memory) {}

    function likeReivew() external {}

    function getHighestRatedProduct() external view returns (uint256) {}
}
