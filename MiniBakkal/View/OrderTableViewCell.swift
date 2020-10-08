//
//  OrderTableViewCell.swift
//  MiniBakkal
//
//  Created by onur on 7.10.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit
class OrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderProductName: UILabel!
    @IBOutlet weak var orderProductPrice: UILabel!
    @IBOutlet weak var finalOrderPiece: UILabel!
    var orderCounter = 1
    var stockCounter = 1
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusClicked(_ sender: Any) {
        stockCounter = Int(self.stockLabel.text!)!
        stockCounter -= 1
        stockLabel.text = "\(stockCounter)"
        
        if stockCounter == 0 {
            plusButton.isEnabled = false
        }
        
        
        orderCounter += 1
        
        minusButton.isEnabled = true
         
        
        finalOrderPiece.text = String(orderCounter)
        
        var chosenPrice = orderProductPrice.text!
        
        finalPrice += Double(chosenPrice)!
        
        NotificationCenter.default.post(name: NSNotification.Name("productAdded"), object: nil)
      
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        stockCounter += 1
        stockLabel.text = "\(stockCounter)"
        plusButton.isEnabled = true
        
        
         orderCounter -= 1
         finalOrderPiece.text = String(orderCounter)
        
        if orderCounter == 0 {
            minusButton.isEnabled = false
        }
        
        if orderCounter >= -1 {
                  
         finalOrderPiece.text = String(orderCounter)
         var chosenPrice = orderProductPrice.text!
         finalPrice -= Double(chosenPrice)!
         NotificationCenter.default.post(name: NSNotification.Name("productDeleted"), object: nil)
        }
        print(orderCounter)
            
    }
    

}
