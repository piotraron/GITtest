// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Tickket is ERC721A, Ownable {
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public mintRate = 0 ether;
    string public _baseTokenURI;
    bool public _mintActive = false;
    // Mapping from token ID to owner addresss
    // string public baseURI = "ipfs://bafybeieyetlp2c2vubffzjjap7utuz5jwo2k5b5kupvezfchc5tnfg4fh4/";
    // string public baseURI = "https://ikzttp.mypinata.cloud/ipfs/QmQFkLSQysj94s5GvTHPyzTxrawwtjgiiYS2TBLgrvw8CW/";

    constructor() ERC721A("testedbyS", "friday") {}

    function _startTokenId()
        internal
        pure
        override(ERC721A)
        returns (uint256 startId)
    {
        return 1;
    }

    
    //MINT - Provide quantity of tokens to mint
    function mint(uint256 quantity) external payable onlyOwner {
        require(
            totalSupply() + quantity <= MAX_SUPPLY,
            "Not enough tokens left"
        );
        require(msg.value >= (mintRate * quantity), "Not enough ether sent");
        _safeMint(msg.sender, quantity);


    }

    //AIRDROP MINT - Provide array of addresses to mint to ["0x..","0x..."]
    function bulkMintAndDrop(address[] calldata _to)
        external
        payable
        onlyOwner
    {
        require(
            totalSupply() + _to.length <= MAX_SUPPLY,
            "Not enough tokens left"
        );
        require(msg.value >= (mintRate * _to.length), "Not enough ether sent");
        for (uint256 i = 0; i < _to.length; i++) {
            _safeMint(_to[i], 1);
        }
    }

    //PRIZE AIRDROP - Provide array of addresses to drop ["0x..","0x..."] and reward value
    function prizeDrop(address[] calldata _to, uint256 reward)
        external
        onlyOwner
    {
        for (uint256 i = 0; i < _to.length; i++) {
            _prizeTransfer(_to[i], reward);
        }
    }

    //PRIZE TRANSFER - Provide address and amount to transfer
    function _prizeTransfer(address _address, uint256 _amount) private {
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "Transfer Failed");
    }

    //METADATA - View base TokenURI
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    //METADATA - Set base TokenURI
    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    
    


    //WITHDRAW - Backup contract funds withdrawal
    function withdraw() external onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed.");
    }

    //
    function setMintRate(uint256 _mintRate) public onlyOwner {
        mintRate = _mintRate;
    }

    //CALCULATE RAFFLE
    /////////////////////////////
    uint256 s_minNR = 1;
    uint256 m_minNR = 1;
    uint256 b_minNR = 1;


    uint256[] SMOL_Numbers;
    uint256[] MID_Numbers;
    uint256[] TOP_Numbers;

    mapping (uint256 => address ) public SMOL_Prize_Winner_Addy;
    mapping (uint256 => address ) public MID_Prize_Winner_Addy;
    mapping (uint256 => address ) public TOP_Prize_Winner_Addy;
    

    uint256 add = 50;


    function raffle() external onlyOwner {

        if (s_minNR < MAX_SUPPLY) {

            
            for (uint256 i = 0; i < 5; i++) {
                uint256 s_maxNR = s_minNR + 99;
                uint256 s_winner = s_maxNR;
                s_winner = s_winner - add;
                s_minNR = s_minNR + 100;
                address s_winnerAddy1 = ownerOf(s_winner);
                // transfer money to winner 1
                SMOL_Prize_Winner_Addy[s_winner] = s_winnerAddy1;
                uint256 s_winnerTwo = s_winner + 10;
                address s_winnerAddy2 = ownerOf(s_winnerTwo);
                // transfer money to winner 2
                SMOL_Prize_Winner_Addy[s_winnerTwo] = s_winnerAddy2;

                SMOL_Numbers.push(s_winner);
                SMOL_Numbers.push(s_winnerTwo);
            
            }

            // //1000 roll
            // uint256 m_maxNR = m_minNR + 499;
            // uint256 m_winner = m_maxNR;

  
            
            // m_winner = m_winner - add;
            // m_minNR = m_minNR + 500;
            // // middle.push(MiddleRaffle(raffleNR,m_winner));
            // middleR.push(m_winner);

        
        }
    }

function SMALL_REWARD_WINNING_NUMBERS() public view returns (uint256[] memory){
    uint256[] memory _numbers = new uint256[](SMOL_Numbers.length);

    for(uint256 i = 0; i<SMOL_Numbers.length;i++){
        _numbers[i]=SMOL_Numbers[i];
    }
    return(_numbers);
   
    
}




}

