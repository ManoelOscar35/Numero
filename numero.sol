//SPDX-License-Identifier: MIT
pragma solidity >= 0.8.26;

library SafeMath {

    function sum(uint a, uint b) internal pure returns(uint) {
        uint c = a + b;
        require(c >= a, "Sum Overflow!");
        return c;
    }

    function sub(uint a, uint b) internal pure returns(uint) {
        require(b <= a, "Sub Underflow");
        uint c = a - b;
        return c;
    }

    function mul(uint a, uint b) internal pure returns(uint) {
        if(a == 0) {
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "Mul Overflow");
        return c;
    }

    function div(uint a, uint b) internal pure returns(uint) {
        uint c = a / b;
        return c;
    }

}

contract Ownable {
    address public owner;

    event OwnershipTransferred(address newOwner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    function transferOwnership(address payable newOwner) onlyOwner public {
        owner = newOwner;

        emit OwnershipTransferred(owner);
    }

}

contract Numero is Ownable {

    using SafeMath for uint;

    uint price = 25;

    event priceChanged(uint newPrice);

    function whatAbout(uint myNumber) public payable returns(string memory) {

        require(myNumber <= 10, unicode"O número precisa ser menor ou igual a 10!");
        require(msg.value == price * 1e15, "Wrong msg.value"); // 25 finney convertido para wei porque  25 finney não é uma unidade válida em Solidity 0.8.x. As unidades válidas de ether são wei, gwei, e ether.

        doublePrice();

        if(myNumber > 5) {
            return  unicode"O número é maior que 5";
        } else {
            return  unicode"O número é menor ou igual a 5";
        }

    }

    function doublePrice() private {
        price = price.mul(2);

        emit priceChanged(price);
    }

    function withDraw(uint myAmount) onlyOwner public {
        require(address(this).balance >= myAmount, "Insufficient funds.");

        payable(owner).transfer(myAmount);
    }
}