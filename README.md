# MultiSig Vault

A decentralized Multi-Signature Wallet built with Solidity, React, Vite, and Ethers.js.

This project allows multiple wallet owners to collectively manage funds. Transactions must receive a predefined number of approvals before execution, providing additional security compared to a traditional single-signer wallet.

## Live Demo

🔗 Live Application: https://your-site-url.vercel.app

### Current Deployment Configuration

- Network: Ethereum Sepolia
- Owners: 3
- Approval Threshold: 2 of 3
- Contract Address: 0x954f2FBC0fA38E3fa940E551EF5396C132cE1286
- Owner-restricted actions require one of the configured owner wallets

## Features

* Connect wallet using MetaMask
* Deposit ETH into the vault
* Create transaction proposals
* Approve pending transactions
* Execute transactions once the approval threshold is reached
* Real-time blockchain interaction via Ethers.js
* Responsive React frontend
* Deployed on Ethereum Sepolia Testnet

## Smart Contract

The MultiSig contract supports:

* Multiple wallet owners
* Configurable approval threshold
* Transaction submission
* Transaction approval tracking
* Secure execution after required approvals
* Contract balance tracking

### Core Functions

```solidity
deposit()
submitTransaction(address recipient, uint256 amount)
approveTransaction(uint256 txid)
executeTransaction(uint256 txid)
```

## Tech Stack

### Frontend

* React
* Vite
* Ethers.js v6
* Tailwind CSS

### Blockchain

* Solidity
* Ethereum Sepolia Testnet
* MetaMask

## Project Structure

```text
src/
├── components/
├── context/
│   └── WalletContext.jsx
├── pages/
├── abi.js
├── App.jsx
└── main.jsx
```

## Getting Started

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/multisig-vault.git
cd multisig-vault
```

### Install Dependencies

```bash
npm install
```

### Run Development Server

```bash
npm run dev
```

### Build For Production

```bash
npm run build
```

## Deployment

The frontend can be deployed using:

* Vercel
* Netlify
* GitHub Pages

## Future Improvements

* Transaction history
* Event indexing
* Owner management
* Threshold updates through governance
* Better transaction filtering
* Contract verification on Etherscan

## Disclaimer

This project was built for educational and portfolio purposes and has not been audited. It should not be used to manage significant funds in production environments.

## License

This project is licensed under the MIT License.
Copyright (c) 2026 Khushbu Sharma
