# TD NFT Ticketing

Professional portfolio demonstration of an EVM-compatible NFT event-pass system developed by Todd Adrian.

## Overview

TD NFT Ticketing demonstrates how event organizers can issue blockchain-based event passes with unique token IDs and metadata references.

### Features

- Event pass minting
- Unique token IDs
- Ownership tracking
- Token metadata URI
- Wallet-based minting
- Configurable mint price
- Configurable maximum supply
- Organizer withdrawal controls

## Technology

- Solidity 0.8.24
- EVM-compatible blockchain
- ethers.js 6
- MetaMask

## Repository structure

```text
contracts/
└── TDEventPass.sol

frontend/
└── index.html
```

## Deployment

1. Open Remix: https://remix.ethereum.org/
2. Create or open `contracts/TDEventPass.sol`.
3. Compile using Solidity `0.8.24`.
4. Connect MetaMask to an EVM testnet.
5. Deploy `TDEventPass` with:
   - `mintPrice`
   - `maxSupply`
   - `baseURI`
6. Copy the deployed contract address.
7. Enter the address in the frontend.
8. Serve the frontend over HTTP.

Example local server:

```bash
python3 -m http.server 4173
```

Then open `http://localhost:4173`.

## Portfolio status

This is a technical demonstration/testnet project, not a production-ready ticketing system. Production deployment should include standards-compliance testing, security review, event check-in design, refund rules, transfer policy, metadata strategy and appropriate legal/compliance review.

## Author

**Todd Adrian**  
GitHub: https://github.com/TODD43
