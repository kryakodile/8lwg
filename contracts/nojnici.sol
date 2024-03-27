// SPDX-License-Identifier: GPL-3.0.
pragma solidity ^0.8.0;   

contract nojnici {
    uint public constant ROCK = 1;    
    uint public constant PAPER = 2;
    uint public constant SCISSORS = 3;
    event Draw(address player, uint amount);    
    event Win(address player, uint amount);
    event Loss(address player, uint amount);
    function play(uint _playerChoice) external payable {        
        require(_playerChoice >= 1 && _playerChoice <= 3, "eroor");
        uint houseChoice = uint(blockhash(block.number - 1)) % 3 + 1;
        if (_playerChoice == houseChoice) {
                payable(msg.sender).transfer(msg.value * 2); // Возврат ставки            
                emit Draw(msg.sender, msg.value); }
        else if ((_playerChoice == ROCK && houseChoice == SCISSORS) || (_playerChoice == PAPER && houseChoice == ROCK) || (_playerChoice == SCISSORS && houseChoice == PAPER)) {           
                    payable(msg.sender).transfer(msg.value * 3); // Выигрыш
                    emit Win(msg.sender, msg.value * 2);        
                    } else {
            emit Loss(msg.sender, msg.value); // Проигрыш       
            }
    }
}
