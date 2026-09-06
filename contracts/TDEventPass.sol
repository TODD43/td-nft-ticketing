// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TDEventPass {
    string public name = "TD Event Pass";
    string public symbol = "TDPASS";
    address public owner;
    uint256 public nextTokenId;
    uint256 public mintPrice;
    uint256 public maxSupply;
    string public baseURI;

    mapping(uint256 => address) private _ownerOf;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _approved;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Minted(address indexed to, uint256 indexed tokenId);

    modifier onlyOwner(){ require(msg.sender == owner, "not owner"); _; }

    constructor(uint256 _mintPrice, uint256 _maxSupply, string memory _baseURI){
        owner = msg.sender;
        mintPrice = _mintPrice;
        maxSupply = _maxSupply;
        baseURI = _baseURI;
    }

    function ownerOf(uint256 id) public view returns(address){
        require(_ownerOf[id] != address(0), "nonexistent");
        return _ownerOf[id];
    }

    function balanceOf(address user) external view returns(uint256){
        require(user != address(0), "zero");
        return _balances[user];
    }

    function tokenURI(uint256 id) external view returns(string memory){
        require(_ownerOf[id] != address(0), "nonexistent");
        return string.concat(baseURI, _toString(id), ".json");
    }

    function mint() external payable returns(uint256 id){
        require(msg.value == mintPrice, "wrong price");
        require(nextTokenId < maxSupply, "sold out");
        id = nextTokenId++;
        _ownerOf[id] = msg.sender;
        _balances[msg.sender]++;
        emit Transfer(address(0), msg.sender, id);
        emit Minted(msg.sender, id);
    }

    function approve(address to, uint256 id) external {
        require(msg.sender == ownerOf(id), "not token owner");
        _approved[id] = to;
    }

    function transferFrom(address from, address to, uint256 id) public {
        require(_ownerOf[id] == from, "wrong owner");
        require(msg.sender == from || msg.sender == _approved[id], "not approved");
        require(to != address(0), "zero");
        _approved[id] = address(0);
        _ownerOf[id] = to;
        _balances[from]--;
        _balances[to]++;
        emit Transfer(from, to, id);
    }

    function setBaseURI(string calldata uri) external onlyOwner { baseURI = uri; }
    function setMintPrice(uint256 price) external onlyOwner { mintPrice = price; }
    function withdraw(address payable to) external onlyOwner {
        require(to != address(0), "zero");
        to.transfer(address(this).balance);
    }

    function _toString(uint256 value) internal pure returns(string memory){
        if(value == 0) return "0";
        uint256 temp=value;
        uint256 digits;
        while(temp!=0){digits++;temp/=10;}
        bytes memory buffer=new bytes(digits);
        while(value!=0){digits--;buffer[digits]=bytes1(uint8(48+uint256(value%10)));value/=10;}
        return string(buffer);
    }
}
