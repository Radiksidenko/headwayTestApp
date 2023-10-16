//
//  StoreKitManager.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 15.10.2023.
//

import StoreKit

class StoreKitManager: ObservableObject {
    
    @MainActor
    func fetchSubscriptions() async -> [Product] {
        
        let purchasedSubscriptions = try? await Product.products(
            for: MockStoreKit.subscriptionsIds
        ).filter { $0.type == .autoRenewable }
        
        return purchasedSubscriptions ?? []
    }
    
    @MainActor
    func fetchProductsNonConsumable() async -> [Product] {
        
        let nonConsumableProducts = try? await Product.products(
            for: MockStoreKit.nonConsumableProductsIds
        ).filter { $0.type == .nonConsumable }
        
        return nonConsumableProducts ?? []
    }
    
    @MainActor
    func fetchPurchasedProducts() async -> [Product] {
        var nonconsumables: [Product] = []
        let nonConsumableProducts = await fetchProductsNonConsumable()
        
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                if transaction.productType == .nonConsumable {
                    if let product = nonConsumableProducts.first(where: { $0.id == transaction.productID }) {
                        nonconsumables.append(product)
                    }
                }
            }
            else {
                
            }
        }
        
        return nonconsumables
    }
    
    @MainActor
    func fetchPurchasedSubscriptions() async -> [Product] {
        var purchasedSubscriptions: [Product] = []
        let allSubscriptions = await fetchSubscriptions()
        
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                if transaction.productType == .autoRenewable {
                    if let subscription = allSubscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                }
            }
        }
        
        return purchasedSubscriptions
    }
    
    @MainActor
    func fetchOneProduct(id: String) async -> Product? {
        do {
            let products = try await Product.products(for: [id])
            return products.first
        }
        catch {
            return nil
        }
    }
    
    @MainActor
    @discardableResult
    private func checkResult(_ result: VerificationResult<Transaction>) async -> Transaction? {
        switch result {
        case .verified(let transaction):
            await transaction.finish()
            return transaction
            
        case .unverified(_, _):
            return nil
        }
    }
    
    func purchase(product: Product, quantity: Int = 1) async -> Transaction? {
        do {
            let result = try await product.purchase(options: [//TODO: Edit
                .quantity(quantity)
            ])
            
            switch result {
            case .success(let result):
                return await checkResult(result)
                
            case .userCancelled:
                print("userCancelled")
                
            case .pending:
                print("pending.")
                
            @unknown default:
                break
            }
        }
        catch {
            return nil
        }
        
        return nil
    }
    
    func isPurchased(productID: String) async -> Bool {
        
        guard let result = await Transaction.latest(for: productID) else {
            return false
        }
        
        switch result {
        case .verified(let transaction):
            return transaction.revocationDate == nil && !transaction.isUpgraded
            
        case .unverified(_, _):
            return false
        }
    }
}
