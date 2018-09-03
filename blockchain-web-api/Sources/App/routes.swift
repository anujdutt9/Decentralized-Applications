import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Make instance of BlockchainController class
    let blockchainController = BlockchainController()
    // Access Greet function using router
    router.get("hello", use: blockchainController.greet)
    router.get("blockchain", use: blockchainController.getBlockchain)
    router.post(Transaction.self, at: "mine", use: blockchainController.mine)
}
