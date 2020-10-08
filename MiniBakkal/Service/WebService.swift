
import Foundation

class Webservice {
    // Burada API 'den veriyi çekebilmem için gerekli fonksitonu WebService altında yazıyorum.
    
    func downloadProducts(url: URL, completion: @escaping ([ProductList]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                print("hata oluştu")
                
            } else if let data = data {
                
                
                let allProducts = try? JSONDecoder().decode([ProductList].self, from: data)
               
                if let allProducts = allProducts {
                    completion(allProducts)
                    
                }
            }
            
        }.resume()
        
    }
    
}
