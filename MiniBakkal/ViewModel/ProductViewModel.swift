import Foundation

struct ProductListViewModel {
    let allProductList: [ProductList]
    //Burada CollectionView içersinde oluşturulacak hücrelerin sayısını döndürüyorum
    func numberOfRowsInSection() -> Int {
        
         return self.allProductList.count
     }
     
     func productAtIndex(_ index: Int) -> ProductViewModel {
         let product = self.allProductList[index]
         return ProductViewModel(product)
        
     }
}

struct ProductViewModel {
    let myProduct: ProductList
    
    init(_ product: ProductList) {
        self.myProduct = product
    }
 
    
    var name: String {
        return self.myProduct.name
        
    }
    
    var currency : String {
           return self.myProduct.currency
           
       }
 
    var price: Double {
        return  self.myProduct.price
    }

    var imageUrl: String {
        return self.myProduct.imageUrl
        
    }
    var stock: Int {
        return self.myProduct.stock
    }

    
} 



