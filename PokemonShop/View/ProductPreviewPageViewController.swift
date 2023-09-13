//
//  ProductPreviewPageViewController.swift
//  PokemonShop
//
//  Created by Howe on 2023/9/8.
//

import UIKit


class ProductPreviewPageViewController: UIViewController {
    
    private var viewModel = ProductViewModel()
    
    var segmentedIndex = 0
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet var productNameLabels: [UILabel]!
    
    @IBOutlet var productImageViews: [UIImageView]!
    
    @IBOutlet var productSteppers: [UIStepper]!
    
    @IBOutlet var productPriceLabels: [UILabel]!
    
    @IBOutlet var productCartQuantityLabels: [UILabel]!
    
    @IBOutlet weak var totalProductPriceLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: Notification.Name("ProductQuantityUpdated"), object: nil)
        
        
        
    }
    
    @objc func updateUI() {
        updata() // 這將刷新您的UI以反映新的商品狀態
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func productCartQuantityChange(_ sender: UIStepper) {
        let productIndex = sender.tag
        var currentProduct = viewModel.product(at: productIndex, forType: segmentedIndex)
        viewModel.updateCartQuantity(for: currentProduct, forType: segmentedIndex, cartQuantity: Int(sender.value))
        
        
        currentProduct = viewModel.product(at: productIndex, forType: segmentedIndex)
        
        
        print("\(currentProduct.storage)")
        if currentProduct.storage == 0 {
            showAlert()
        }
        
        
        productCartQuantityLabels[productIndex].text = "\(Int(sender.value))"
        totalProductPriceLabel.text = String(viewModel.totalProductPrice())
    }
    
    
    
    
    
    
    
    @IBAction func resetProductPrice(_ sender: UIButton) {
        viewModel.resetProductCart()
        updata()
    }
    
    
    
    
    
    @IBAction func purchase(_ sender: UIButton) {
        let alertController = UIAlertController(title: "購買確認", message: "確定要購買這些商品嗎？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { (action) in
            print("確定按鈕被按下")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        segmentedIndex = segmentedControl.selectedSegmentIndex
        updata()
        
    }
    
    
    
    
    func updata() {
        let currentProducts = viewModel.products(forType: segmentedIndex)
        for e in 0..<currentProducts.count {
            productSteppers[e].minimumValue = 0
            productSteppers[e].maximumValue = Double(viewModel.fetchInitStorage(Index: segmentedIndex)[e])
            productImageViews[e].image = currentProducts[e].image
            productNameLabels[e].text = currentProducts[e].name
            productPriceLabels[e].text = String(currentProducts[e].price)
            productCartQuantityLabels[e].text = String(currentProducts[e].cartQuantity)
            productSteppers[e].value = Double(currentProducts[e].cartQuantity) // 這行確保 stepper 的值也是正確的
        }
        totalProductPriceLabel.text = String(viewModel.totalProductPrice())
    }
    
    
    
    
    
    
    
    
    func initUI() {
        let currentProducts = viewModel.products(forType: segmentedIndex)
        
        for e in 0..<currentProducts.count {
            productSteppers[e].tag = e
            productSteppers[e].minimumValue = 0
            productSteppers[e].maximumValue = Double(viewModel.fetchInitStorage(Index: segmentedIndex)[e])
            productCartQuantityLabels[e].text = "\(currentProducts[e].cartQuantity)"
            productImageViews[e].image = currentProducts[e].image
            productNameLabels[e].text = currentProducts[e].name
            productPriceLabels[e].text = String(currentProducts[e].price)
        }
        totalProductPriceLabel.text = String(viewModel.totalProductPrice())
        segmentedControl.selectedSegmentIndex = segmentedIndex
    }
    
    
    
    
    func showAlert () {
        let alertController = UIAlertController(title: "提示", message: "現為目前商品庫存總量", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { (action) in
            print("確定按鈕被按下")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tocart" {
            if let destinationVC = segue.destination as? shoppingCartViewController {
                destinationVC.viewModel = self.viewModel
            }
        }
    }
    
    
    
    
    
}
