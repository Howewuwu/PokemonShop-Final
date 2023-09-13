//
//  shoppingCartViewController.swift
//  PokemonShop
//
//  Created by Howe on 2023/9/8.
//

import UIKit

extension shoppingCartViewController: ShoppingCartCellDelegate {
    
    func didChangeProductQuantity(cell: shoppingCartCellTableViewCell, quantity: Int) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = viewModel.productsInCart()[indexPath.row]
        
        // 您可能需要確定商品的類型（type），以下僅為示例
        // 假設您可以透過商品名稱確定它的類型
        var type: Int = 0
        if viewModel.products(forType: 0).contains(where: { $0.name == product.name }) {
            type = 0
        } else if viewModel.products(forType: 1).contains(where: { $0.name == product.name }) {
            type = 1
        } else {
            type = 2
        }
        
        // 使用 updateCartQuantity 進行更新
        viewModel.updateCartQuantity(for: product, forType: type, cartQuantity: quantity)
        
        if tableView.sectionIndexMinimumDisplayRowCount == 0 {
            totalProductPriceLabel.text = "0"
        }
        // 刷新tableView以顯示更新
        tableView.reloadData()
    }
}




class shoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = ProductViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalProductPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsInCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCartCell", for: indexPath) as! shoppingCartCellTableViewCell
        let product = viewModel.productsInCart()[indexPath.row]
        
        
        if let index = viewModel.productType1.firstIndex(where: { $0.name == product.name }) {
            cell.productStepper.maximumValue = Double(viewModel.initialProductType1Storage[index])
        } else if let index = viewModel.productType2.firstIndex(where: { $0.name == product.name }) {
            cell.productStepper.maximumValue = Double(viewModel.initialProductType2Storage[index])
        } else if let index = viewModel.productType3.firstIndex(where: { $0.name == product.name }) {
            cell.productStepper.maximumValue = Double(viewModel.initialProductType3Storage[index])
        }
        

        cell.productImageView.image = product.image
        cell.productNameLabel.text = product.name
        cell.productQuantityLabel.text = "\(product.cartQuantity)"
        cell.productStepper.value = Double(product.cartQuantity)
        totalProductPriceLabel.text = "\(viewModel.totalProductPrice())"
        
        cell.delegate = self
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

