// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import "hardhat/console.sol";
contract MyCoin {
	uint public constant totalSupply = 1000000000000000000000000000;
	mapping(address => uint256) balances;
    address public owner;
    uint public value;

	constructor(uint _value) {
		balances[msg.sender] = totalSupply;
        owner=msg.sender;
        value=_value;
	}
}

contract MyCoinDeployer {

    // contract deploy using CREAT OPCODE
    MyCoin public  Contract = new MyCoin(2300);
    
    // deterministic contract address by using CREAT2 OPCODE
    MyCoin public  Contract2 = new MyCoin{salt:bytes32(0)}(45660000);

    function details() view external returns(uint value, address owner,uint totlasupply, uint balance) {
        // console.log("value=",_address.value());
        // console.log("owner=",_address.owner());
        // console.log("totalsupply=",_address.totalSupply());

        value=Contract.value();
        owner=Contract.owner();
        totlasupply=Contract.totalSupply();
        balance=Contract.balances(address(this));

    }

    
}
