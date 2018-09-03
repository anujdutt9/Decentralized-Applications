// Basic Blockchain Layout

import Cocoa

// protocol for smart contracts
protocol SmartContract{
    func apply(transaction: Transaction)
}

class TransactionTypeSmartContract: SmartContract{
    func apply(transaction: Transaction) {
        var fees = 0.0
        
        switch transaction.transactionType {
            case .domestic:
                fees = 0.02
            case .international:
                fees = 0.05
        }
        
        transaction.fees = transaction.amount * fees
        transaction.amount -= transaction.fees
    }
}

// Type of Transactions
enum TransactionType: String, Codable{
    case domestic
    case international
}

// Transaction Class
// Codable: means it can be serialized into json objects
class Transaction: Codable{

    // Transaction from/to/amount
    var from: String!
    var to: String!
    var amount: Double
    var fees: Double = 0.0
    var transactionType: TransactionType

    // Initializer for values
    init(from: String, to: String, amount: Double, transactionType: TransactionType) {
        self.from = from
        self.to = to
        self.amount = amount
        self.transactionType = transactionType
    }
}


// Block Class
class Block: Codable{

    // Position of block in blockchain
    var index: Int = 0

    // Block-1 hash is empty
    var previousHash: String = ""

    // Current Block Hash
    var hash: String!

    // current block nonce value
    var nonce: Int

    // Transactions in a block could be an array
    // list of transaction objects
    private (set) var transactions: [Transaction] = [Transaction]()

    var key: String! {
        get {
            // convert list of transaction objects to JSON format
            let transactionsData = try! JSONEncoder().encode(self.transactions)
            // convert JSON formatted transactions to String
            let transactionsJSONString = String(bytes: transactionsData, encoding: .utf8)
            // Returns the key for the current block: depends on the index of block, prev. hash of block, nonce value of block and transaction in json format
            return String(self.index) + self.previousHash + String(self.nonce) + transactionsJSONString!
        }
    }

    // Function to add new transaction to array
    func addTransaction(transaction: Transaction){
        self.transactions.append(transaction)
    }

    init() {
        self.nonce = 0
    }
}


// Blockchain Class
class Blockchain: Codable {
    
    // Initially has a array of blocks
    private (set) var blocks: [Block] = [Block]()
    
    // On calling blockchain, it creates the genesis block and adds to new blockchain
    init(genesisBlock: Block) {
        addBlock(genesisBlock)
    }
    
    // Create a list of smart contracts
    private (set) var smartContracts: [SmartContract] = [TransactionTypeSmartContract()]
    
    private enum codingKeys: CodingKey{
        case blocks
    }
    
    func addBlock(_ block: Block){
        // if it's a new blockchain i.e. no blocks exist, initialize the previous hash with a value
        if self.blocks.isEmpty{
            block.previousHash = "00000000000000000000"
            block.hash = generateHash(for: block)
        }
        self.blocks.append(block)
    }
    
    // Function to get next block in Blockchain
    func getNextBlock(transactions: [Transaction]) -> Block{
        let block = Block()
        transactions.forEach { (transaction) in
            block.addTransaction(transaction: transaction)
        }
        
        let previousBlock = getPreviousBlock()
        block.index = self.blocks.count
        // previous hash is the hash of previous block
        block.previousHash = previousBlock.hash
        // generate new hash for current block
        block.hash = generateHash(for: block)
        return block
    }
    
    func getPreviousBlock() -> Block{
        return self.blocks[self.blocks.count - 1]
    }
    
    // Function to generate hash value
    func generateHash(for block: Block) -> String{
        var hash = block.key.sha1Hash()
        
        // While loop keeps the hash generating till we have a hash with "00" as prefix
        while(!hash.hasPrefix("00")){
            block.nonce += 1
            hash = block.key.sha1Hash()
            print(hash)
        }
        return hash
    }
}

// SHA1 Hash Function to generate hash using internal functions
extension String{
    
    func sha1Hash() -> String{
        let task = Process()
        task.launchPath = "/usr/bin/shasum"
        task.arguments = []
        
        let inputPipe = Pipe()
        inputPipe.fileHandleForWriting.write(self.data(using: String.Encoding.utf8)!)
        inputPipe.fileHandleForWriting.closeFile()
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardInput = inputPipe
        task.launch()
        
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let hash = String(data: data, encoding: String.Encoding.utf8)!
        return hash.replacingOccurrences(of: "  -\n", with: "")
    }
}



// First block: genesis block, contains the reward for miners
let genesisBlock = Block()
// Initialize new blockchain
let newBlockchain = Blockchain(genesisBlock: genesisBlock)
// Create Sample Transaction
let transxn = Transaction(from: "Mary", to: "John", amount: 10, transactionType: .domestic)
print("-----------------------------------------------------")
let block = newBlockchain.getNextBlock(transactions: [transxn])
// Add the new block to blockchain
//newBlockchain.addBlock(block)
//print("Number of Blocks in Blockchain: \(newBlockchain.blocks.count)")
let data = try! JSONEncoder().encode(newBlockchain)
let blockchainJSON = String(data: data, encoding: .utf8)
print(blockchainJSON!)
