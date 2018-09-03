//
//  BlockchainController.swift
//  App
//
//  Created by Anuj Dutt on 9/2/18.
//

import Foundation
import Vapor
import HTTP

class BlockchainController {

    
    // Initialize Blockchain Service in Blockchain Controller
    private (set) var blockchainService: BlockchainService
    
    init() {
        self.blockchainService = BlockchainService()
    }
    
    func getBlockchain(req: Request) -> Blockchain{
        return self.blockchainService.getBlockchain()
    }
    
    // Function to Mine Blockchian
    func mine(req: Request, transaction: Transaction) -> Block{
        return self.blockchainService.getNextBlock(transactions: [transaction])
    }
    
    // Greet function Test
    // Future<>: Async Response
    func greet(req: Request) -> Future<String> {
        return Future.map(on: req) { () -> String in
            return "Welcome to Blockchain"
        }
    }
}
