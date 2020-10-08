
import Foundation

struct ProductList: Decodable {
    let id: String
    let name: String
    let price: Double
    let currency: String
    let imageUrl: String
    let stock: Int
   
}
