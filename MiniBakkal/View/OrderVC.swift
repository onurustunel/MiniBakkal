//
//  OrderVC.swift
//  MiniBakkal
//
//  Created by onur on 6.10.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit
var finalPrice =  0.0

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var finalPriceLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        priceCalculate()
        
         NotificationCenter.default.addObserver(self, selector: #selector(priceCalculate), name: NSNotification.Name(rawValue: "refreshPrice"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(priceIncreased), name: NSNotification.Name(rawValue: "productAdded"), object: nil)
             
        NotificationCenter.default.addObserver(self, selector: #selector(priceDecreased), name: NSNotification.Name(rawValue: "productDeleted"), object: nil)
        
    }
    
    @objc func priceCalculate() {
        orderTableView.reloadData()
     
        if allOrderArray.count >= 1 {
            finalPrice = 0.0
        for index in 0...allOrderArray.count - 1 {
           
            let price = allOrderArray[index].price * Double(allOrderArray[index].piece)
            finalPrice +=  price
            
        }
            // Ondalıklık kısmın son iki hanesini alıyorum.
            finalPriceLabel.text = String(format: "%.2f", finalPrice)
            
        }

      }
    
    @objc func priceIncreased() {
        // ürün eklerse eklediği ürünün fiyatını Toplam fiyata ekliyorum.
          finalPriceLabel.text = String(format: "%.2f", finalPrice)
    }
    
    @objc func priceDecreased() {
         // ürün çıkarırsa çıkardığı ürünün fiyatını Toplam fiyattan çıkarıyorum.
             finalPriceLabel.text = String(format: "%.2f", finalPrice)
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allOrderArray.count
        
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = orderTableView  .dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        let url = URL(string: allOrderArray[indexPath.row].imageUrl)

                     DispatchQueue.global().async {
                         let data = try? Data(contentsOf: url!)
                         DispatchQueue.main.async {
                          orderCell.orderImage.image = UIImage(data: data!)
                         }
                     }

        orderCell.orderProductName.text  = allOrderArray[indexPath.row].name
        orderCell.orderProductPrice.text = "\(allOrderArray[indexPath.row].price)"
        orderCell.finalOrderPiece.text = "\(allOrderArray[indexPath.row].piece)"
        orderCell.stockLabel.text = "\(allOrderArray[indexPath.row].stock)"
        
        if orderCell.stockLabel.text == "0" {
            orderCell.plusButton.isEnabled = false
        }
        
        
        return orderCell
        
      }
  
    @IBAction func kapatClicked(_ sender: Any) {
        performSegue(withIdentifier: "toProductVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
         
        if editingStyle == .delete {
           // sil
            allOrderArray.remove(at: indexPath.row)
            orderTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            orderTableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name("refreshPrice"), object: nil)
        }
       
        
        if allOrderArray.count == 0 {
            performSegue(withIdentifier: "fromOrderVC", sender: nil)
        }
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
    
        // Burada tableView'den toplu silme işlemi yapılması gerekiyor.
    }
    
    
}
