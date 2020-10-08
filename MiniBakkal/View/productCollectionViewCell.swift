//
//  productCollectionViewCell.swift
//  MiniBakkal
//
//  Created by onur on 4.10.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit

class productCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var totalPieceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var URLImage = ""
    var counter = 0
    var stockCounter = -1
    
    
    @IBAction func plusClicked(_ sender: UIButton) {
        // Arttır
       
        stockCounter = Int(self.stockLabel.text!)!
        stockCounter -= 1
        
        if stockCounter == 0 {
            plusButton.isEnabled = false
            print("stok bitti")
        }
        
        totalPieceLabel.isHidden = false
        minusButton.isHidden = false
        counter += 1
      
        totalPieceLabel.text = "\(counter)"
        stockLabel.text =  "\(stockCounter)"
        
        chosenProductCounter += 1
        addData()
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
      
        }
    
    
    @IBAction func minusClicked(_ sender: Any) {
        // Azalt
        
        stockCounter += 1
               
               if stockCounter == 0 {
                   plusButton.isEnabled = true
                   print("stok eklendi")
               }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
         counter -= 1
         totalPieceLabel.text = "\(counter)"
     
        plusButton.isEnabled = true
        
        if counter == 0 {
            totalPieceLabel.isHidden = true
            minusButton.isHidden = true
             totalPieceLabel.text = "\(counter)"
        }
       
        chosenProductCounter -= 1
        stockLabel.text =  "\(stockCounter)"
      //  addData()
         print(" sipariş adedi \(chosenProductCounter)")
       
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
    }
    
    func addData() {
        
        let addProduct = selectedProducts(productName: productName.text!, productPrice: Double(productPrice.text!)!, productPiece: Int(totalPieceLabel.text!)!, productImageUrl: URLImage, productStock: Int(stockLabel.text!)!, productCurrency: currencyLabel.text!)
        
         // Burada butonlara her tıklamada addProduct'ları diziye ekliyorum. Fakat bu sefer müşterinin farklı tıklamalarında oluşacak seneryolarda sepete gittiğimizde ürünlerin tekrarlandığını görüyorum. Bu tekrarlanma sorununu aşmak için  <selectedProducts, Int> dictionarylerini kullanarak diziye ekledim. Fakat tekrarlama sorununu çözmedi. Bu yüzden daha fazla ürün gösterilmemesi için eksi butonuna tıklandığında addData() fonksiyonunu çalıştırmadım.
        
        // Not: Bu sorunu çözmek için çok fazla araştırma yaptım fakat hiçbirisi işime yaramadı. Çözüm için ne yapmam gerektiğini söyleyebilirseniz çok sevinirim.
       
        // mail : ustunel.onur@gmail.com
        
        allOrderArray.append(addProduct)
        
      //  results.append([onurustunel : counter])
        
    }
     
}
