// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyToken is ERC20, ERC20Burnable {
    address private owner;

    constructor(address initialOwner)
        ERC20("Bixplorer.com", "BXE")
    {
        owner = initialOwner;
        _mint(initialOwner, 200_000_000_000 ether);
    }

    function withdraw(address token, address to) public {
        require(msg.sender == owner, "You're not the owner"); 
        if (token == address(0)) {
            uint256 balance = address(this).balance;
            require(balance > 0, "Insufficient balance");
            payable(to).transfer(balance);
        } else {
            IERC20 erc20Token = IERC20(token);
            uint256 balance = erc20Token.balanceOf(address(this));
            require(balance > 0, "Insufficient balance");
            erc20Token.transfer(to, balance);
        }
    }
}