//
//  BlockchainService.swift
//  App
//
//  Created by Anuj Dutt on 9/2/18.
//

import Foundation

class BlockchainService{
    
    private (set) var blockchain: Blockchain!
    
    init() {
        self.blockchain = Blockchain(genesisBlock: Block())
    }
    
    func getBlockchain() -> Blockchain{
        return self.blockchain
    }
    
    func getNextBlock(transactions: [Transaction]) -> Block{
        let block = self.blockchain.getNextBlock(transactions: transactions)
        self.blockchain.addBlock(block)
        return block
    }
}
