//
//  ProductViewModel.swift
//  PokemonShop
//
//  Created by Howe on 2023/9/9.
//

import UIKit

class ProductViewModel {
    
     var productType1: [Product] = []
     var productType2: [Product] = []
     var productType3: [Product] = []
    
    
    var initialProductType1Storage: [Int] = []
    var initialProductType2Storage: [Int] = []
    var initialProductType3Storage: [Int] = []
    
    
    
    init() {
        loadProductData()
    }
    
    func loadProductData() {
        
        productType1 = [
            Product(name: "寶貝球", image: UIImage(named: "poke-ball-0")!, price: 800.0, cartQuantity: 0, storage: 20),
            Product(name: "超級球", image: UIImage(named: "great-ball-1")!, price: 1000.0, cartQuantity: 0, storage: 10),
            Product(name: "高級球", image: UIImage(named: "ultra-ball-2")!, price: 1200.0, cartQuantity: 0, storage: 10),
            Product(name: "究極球", image: UIImage(named: "beast-ball-3")!, price: 2000.0, cartQuantity: 0, storage: 10),
            Product(name: "大師球", image: UIImage(named: "master-ball-4")!, price: 9999.9, cartQuantity: 0, storage: 1)
        ]
        
        initialProductType1Storage = productType1.map { $0.storage }
        
        productType2 = [
            Product(name: "解毒藥", image: UIImage(named: "antidote-medicine-0")!, price: 500.0, cartQuantity: 0, storage: 10),
            Product(name: "解眠藥", image: UIImage(named: "awakening-medicine-1")!, price: 500.0, cartQuantity: 0, storage: 10),
            Product(name: "灼傷藥", image: UIImage(named: "burn-heal-medicine-2")!, price: 500.0, cartQuantity: 0, storage: 10),
            Product(name: "萬靈藥", image: UIImage(named: "full-heal-medicine-3")!, price: 1000.0, cartQuantity: 0, storage: 10),
            Product(name: "全復藥", image: UIImage(named: "full-restore-medicine-4")!, price: 1000.0, cartQuantity: 0, storage: 10)
        ]
        
        initialProductType2Storage = productType2.map { $0.storage }
        
        productType3 = [
            Product(name: "招式機01", image: UIImage(named: "tm-normal-machines-0")!, price: 1000, cartQuantity: 0, storage: 10),
            Product(name: "招式機02", image: UIImage(named: "tm-normal-machines-1")!, price: 1000, cartQuantity: 0, storage: 10),
            Product(name: "招式機03", image: UIImage(named: "tm-psychic-machines-2")!, price: 1000, cartQuantity: 0, storage: 10),
            Product(name: "招式機04", image: UIImage(named: "tm-psychic-machines-3")!, price: 1000, cartQuantity: 0, storage: 10),
            Product(name: "招式機05", image: UIImage(named: "tm-dragon-machines-4")!, price: 1000, cartQuantity: 0, storage: 10)
        ]
        
        initialProductType3Storage = productType3.map { $0.storage }
        
    }
    
    
    func products(forType type: Int) -> [Product] {
        switch type {
        case 0:
            return productType1
        case 1:
            return productType2
        case 2:
            return productType3
        default:
            return []
        }
    }
    
    
    
    func product(at index: Int, forType type: Int) -> Product {
        return products(forType: type)[index]
    }
    
    
    
    func updateCartQuantity(for product: Product, forType type: Int, cartQuantity: Int) {
        switch type {
        case 0:
            if let index = productType1.firstIndex(where: { $0.name == product.name }) {
                let changeInQuantity = cartQuantity - productType1[index].cartQuantity
                productType1[index].cartQuantity = cartQuantity
                productType1[index].storage -= changeInQuantity
                
                print("\(productType1[index].name):"+"storage:\(productType1[index].storage)")
            }
        case 1:
            if let index = productType2.firstIndex(where: { $0.name == product.name }) {
                let changeInQuantity = cartQuantity - productType2[index].cartQuantity
                productType2[index].cartQuantity = cartQuantity
                productType2[index].storage -= changeInQuantity
                
                print("\(productType2[index].name):"+"storage:\(productType2[index].storage)")
            }
        case 2:
            if let index = productType3.firstIndex(where: { $0.name == product.name }) {
                let changeInQuantity = cartQuantity - productType3[index].cartQuantity
                productType3[index].cartQuantity = cartQuantity
                productType3[index].storage -= changeInQuantity
                
                print("\(productType3[index].name):"+"storage:\(productType3[index].storage)")
            }
        default:
            break
        }
        
        // 當更新完成後發送通知
        NotificationCenter.default.post(name: Notification.Name("ProductQuantityUpdated"), object: nil)
        
    }
    
    
    func updateProductQuantity(at index: Int, quantity: Int) {
        // 從 viewModel 調用方法以獲取商品列表
        var products = productsInCart()
        
        // 更新該商品的數量
        products[index].cartQuantity = quantity
        
        // 如果需要保存這些更改，您可能還需要將更新後的商品列表重新賦值回去
        // 注意：這僅僅是一個示例，具體的實現取決於您的 viewModel 結構
        
    }
    
    
    
    
    func totalProductPrice() -> Double {
        let allProducts = productType1 + productType2 + productType3
        return allProducts.reduce(0) { $0 + $1.price * Double($1.cartQuantity) }
    }
    
    
    
    func resetProductCart() {
        for index in 0..<productType1.count {
            productType1[index].cartQuantity = 0
            productType1[index].storage = initialProductType1Storage[index]
        }
        
        for index in 0..<productType2.count {
            productType2[index].cartQuantity = 0
            productType2[index].storage = initialProductType2Storage[index]
        }
        
        for index in 0..<productType3.count {
            productType3[index].cartQuantity = 0
            productType3[index].storage = initialProductType3Storage[index]
        }
    }
    
    
    
    
    func productsInCart() -> [Product] {
        return (productType1 + productType2 + productType3).filter { $0.cartQuantity > 0 }
    }
    
    
    
    func fetchInitStorage (Index Type: Int) -> [Int]{
        switch Type {
        case 0 :
            return initialProductType1Storage
        case 1 :
            return initialProductType2Storage
        case 2 :
            return initialProductType3Storage
        default :
            return []
        }
    }
    
    


    
    
    
    
}
