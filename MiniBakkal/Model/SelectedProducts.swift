//
//  SelectedProducts.swift
//  MiniBakkal
//
//  Created by onur on 6.10.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import Foundation

class selectedProducts : Hashable  {
    // Burada <selectedProducts, Int> şeklinde bir dictionary oluşturmaya çalıştığım için Hashable protokolünü kullanmam gerekti. Bu Dictionary'i oluşturmak istememin sebebi de Sipariş ekranında oluşan ürün tekrarlarını engellemekti. Fakat sonuçta işe yaramadı.
 
    var name : String
    var price : Double
    var piece : Int
    var imageUrl : String
    var stock : Int
    var currency : String
    var hashValue: Int {
          return self.piece
        
      }
    
    init(productName: String, productPrice : Double, productPiece : Int, productImageUrl : String, productStock : Int, productCurrency: String ) {
        name = productName
        price = productPrice
        piece = productPiece
        imageUrl = productImageUrl
        stock = productStock
        currency = productCurrency

    }
}

func ==(product1: selectedProducts, product2: selectedProducts) -> Bool {
    return product1.piece == product2.piece
}

