// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MultiSig {
    address[] public owners;
    uint256 public threshold;

    struct Transaction {
        address recipient;
        uint256 amount;
        uint256 approvalCount;
        bool executed;
    }

    Transaction[] public allTransactions;

    mapping(uint256 => mapping(address => bool)) public approvals;
    mapping(address => bool) public isOwner;

    constructor(
        address[] memory _owners,
        uint256 _threshold
    ) payable {
        require(_owners.length > 0, "No owners provided");
        require(
            _threshold > 0 &&
            _threshold <= _owners.length,
            "Invalid threshold"
        );

        for (uint256 i = 0; i < _owners.length; i++) {
            require(
                _owners[i] != address(0),
                "Invalid owner"
            );

            require(
                !isOwner[_owners[i]],
                "Duplicate owner"
            );

            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }

        threshold = _threshold;
    }

    function deposit() public payable {
        require(
            msg.value > 0,
            "Amount must be greater than 0"
        );
    }

    function submitTransaction(
        address _recipient,
        uint256 _amount
    ) public {
        require(
            isOwner[msg.sender],
            "Not owner"
        );

        require(
            _recipient != address(0),
            "Invalid recipient"
        );

        require(
            _amount > 0,
            "Amount must be greater than 0"
        );

        allTransactions.push(
            Transaction(
                _recipient,
                _amount,
                0,
                false
            )
        );
    }

    function approveTransaction(
        uint256 txid
    ) public {
        require(
            isOwner[msg.sender],
            "Not owner"
        );

        require(
            txid < allTransactions.length,
            "Invalid transaction"
        );

        require(
            !approvals[txid][msg.sender],
            "Already approved"
        );

        require(
            !allTransactions[txid].executed,
            "Transaction already executed"
        );

        approvals[txid][msg.sender] = true;
        allTransactions[txid].approvalCount++;
    }

    function executeTransaction(
        uint256 txid
    ) public {
        require(
            txid < allTransactions.length,
            "Invalid transaction"
        );

        require(
            allTransactions[txid].approvalCount >= threshold,
            "Not enough approvals"
        );

        require(
            !allTransactions[txid].executed,
            "Transaction already executed"
        );

        require(
            address(this).balance >=
                allTransactions[txid].amount,
            "Insufficient balance"
        );

        allTransactions[txid].executed = true;

        (bool success, ) = payable(
            allTransactions[txid].recipient
        ).call{
            value: allTransactions[txid].amount
        }("");

        require(
            success,
            "Transfer failed"
        );
    }

    function getOwnersCount()
        public
        view
        returns (uint256)
    {
        return owners.length;
    }

    function getTransactionCount()
        public
        view
        returns (uint256)
    {
        return allTransactions.length;
    }

    function getContractBalance()
        public
        view
        returns (uint256)
    {   
        return address(this).balance;
    }


}