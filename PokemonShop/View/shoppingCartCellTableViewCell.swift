//
//  shoppingCartCellTableViewCell.swift
//  PokemonShop
//
//  Created by Howe on 2023/9/8.
//

import UIKit



protocol ShoppingCartCellDelegate: AnyObject {
    func didChangeProductQuantity(cell: shoppingCartCellTableViewCell, quantity: Int)
}


class shoppingCartCellTableViewCell: UITableViewCell {
    
    weak var delegate: ShoppingCartCellDelegate?
    
    @IBOutlet weak var productStepper: UIStepper!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    
    
    
    
    @IBAction func productQuantityChange(_ sender: UIStepper) {
        
        delegate?.didChangeProductQuantity(cell: self, quantity: Int(sender.value))
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
