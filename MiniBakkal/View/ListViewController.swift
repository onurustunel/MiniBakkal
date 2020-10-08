import UIKit
var chosenProductCounter = 0
var stocklar = 0
var allOrderArray = [selectedProducts]()
var results = [[selectedProducts: Int]]()
// Çok fazla değişken olmadığı için basitleştirmek amacıyla burda bazı değişkenleri  Global olaran tanımladım.


class ListViewController: UIViewController,  UICollectionViewDelegate,  UICollectionViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var totalProductLabel: UILabel!
    private var showingProductListViewModel: ProductListViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        chosenProductCounter = 0
        totalProductLabel.text = "\(chosenProductCounter)"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getProductData()
        allOrderArray.removeAll()
        finalPrice = 0.0
        productCollectionView.delegate  =  self
        productCollectionView.dataSource = self
        totalProductLabel.text = "\(chosenProductCounter)"
        
       NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
       totalProductLabel.text = String(chosenProductCounter)
       
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.showingProductListViewModel == nil ? 0 : self.showingProductListViewModel.numberOfRowsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Çektiğimiz verileri Hücre içerisindeki yerlerine koyuyoruz.
        
        let productCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCollectionViewCell
        
        let chosenProductViewModel = self.showingProductListViewModel.productAtIndex(indexPath.row)
        productCell.productPrice.text = "\(chosenProductViewModel.price)"
        productCell.productName.text = chosenProductViewModel.name
        productCell.stockLabel.text = "\( chosenProductViewModel.stock)"
        productCell.URLImage = chosenProductViewModel.imageUrl
        stocklar = chosenProductViewModel.stock
        
        let url = URL(string: chosenProductViewModel.imageUrl)
               DispatchQueue.global().async {
                   let data = try? Data(contentsOf: url!)
                   DispatchQueue.main.async {
                    productCell.productImage.image = UIImage(data: data!)
                   }
               }
        productCell.currencyLabel.text = chosenProductViewModel.currency
       
    return productCell
        }

    @objc func getData() {
         totalProductLabel.text = String(chosenProductCounter)
        stocklar -= 1
      
    }
    // Yazdığımız WebService ile veriyi çekiyoruz.
    private func getProductData() {
    
              let url1 = URL(string: "https://desolate-shelf-18786.herokuapp.com/list")!
              
              Webservice().downloadProducts(url: url1) { (stuff) in
                  if let stuff = stuff {
                      self.showingProductListViewModel = ProductListViewModel(allProductList: stuff)
                      DispatchQueue.main.async {
                          self.productCollectionView.reloadData()
                      }
                    
                  }
                
              }
        
    }
    

    @IBAction func orderClicked(_ sender: Any) {
        // Sepet boş ise farklı bir ekrana yönlendiriyorum.
        if chosenProductCounter == 0 {
             performSegue(withIdentifier: "fromListVC", sender: nil)
        } else {
        // Sepette ürün varsa da siparişi onaylayabileceği ekrana yönlendiriyorum.
        performSegue(withIdentifier: "toOrderVC", sender: nil)
        }
        
    }
    
    
}

