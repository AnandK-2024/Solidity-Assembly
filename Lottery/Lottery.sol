// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AngleExplainsBase {
    uint private secretNumber;
    mapping(address =>  uint) public guesses;
    
    bytes32 public secretWord;
    // obviously this doesn't make sense
    // but it will be fun to write it in assembly :D
    function getSecretNumber() external view returns(uint) {
        return secretNumber;
    }
    // this should only be set by an admin
    // no access control because we want to keep it simple in assembly
    function setSecretNumber(uint number) external {
        secretNumber = number;
    }
    // a user can add a guess
    function addGuess(uint _guess) external {
        guesses[msg.sender] = _guess;
    }
    // yes i know... it doesn't make sense because you can change guesses for any user
    // it's just to teach you how to parse arrays in assembly
    function addMultipleGuesses(address[] memory _users, uint[] memory _guesses) external {
        for (uint i = 0; i < _users.length; i++) {
            guesses[_users[i]] = _guesses[i];
        }
    }
    // this is useless since the `secretWord` is not used anywhere
    // but this will teach us how to hash a string in assembly. Really cool! :)
    function hashSecretWord(string memory _str) external {
        secretWord = keccak256(abi.encodePacked(_str));
    }
}


contract Assembly{
    uint256 private SecretNumber;
    mapping(address=>uint ) public guesses;
    bytes32 SecretWord;


    function getSecretNumber() external view returns(uint){
        assembly{
        //    let secretNumber:=sload(0)
            let secretNumber:=sload(SecretNumber.slot)
            mstore(0x40,secretNumber)
            return (0x40,32)

        }
    } 


    function SetSecretNumber(uint _number) external{
        assembly{
            let ptr:=SecretNumber.slot
            sstore(ptr,_number)
        }
    }

    function addGuess(uint _guess) external {
        assembly{
            let ptr := mload(0x40)
           mstore(ptr, caller())
           mstore(add(ptr, 0x20), guesses.slot)
           let slot := keccak256(ptr, 0x40)
           sstore(slot, _guess)
        }
    }


    function hashSecretWord(string memory _str) external returns(bytes32) {
        assembly{
            let strSize:=mload(_str)
            // mstore(0x40,strSize)
            let strAdd:=add(strSize,32)
            let hash:=keccak256(strAdd,strSize)
            mstore(0x00,hash)
            sstore(SecretWord.slot,hash)
            return(0x00,32)
        }
    }



    function addMultipleGuesses(address[] memory _users, uint[] memory _guesses) external returns(uint) {
        assembly{
            let userSize:=mload(_users)
            let gussesSize:=mload(_guesses)
            if iszero(eq(userSize,gussesSize)){
                revert(0,0)
            }
            for {let i} lt(i,userSize){i:=add(i,1)}{
                
            }
        }
                }

}