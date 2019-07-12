//
//  TableViewController.swift
//  Bitcoin
//
//  Created by VAROL AKSOY on 11.07.2019.
//  Copyright © 2019 VAROL AKSOY. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //TODO: Variables
    var coinArray : [String] = []
    var coinPrice : [Double] = []
    var coinMarketCap: [Double] = []
    var coinLastUpdate: [String] = []
    var coinChange1Hour: [Double] = []
    
    lazy var refresher : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.separatorStyle = .none
        self.retrieveCoinData()
        tableView.rowHeight = 100
        tableView.addSubview(refresher)
        
    }
    
    //TODO: refresh (pull check işlemi için)
    @objc func refresh(_ sender: Any) {

        DispatchQueue.main.async{
            self.retrieveCoinData()
            self.tableView.reloadData()

            self.refresher.endRefreshing()
            
        }
    }

    
    //TODO: JSON Parsing
    func retrieveCoinData(){
        let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=aa934023-af5f-4c34-b54c-3ef83e4a9ece")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let coinData = try decoder.decode(Welcome.self, from: data)
                self.coinPrice.removeAll(keepingCapacity: true)
                self.coinLastUpdate.removeAll(keepingCapacity: true)
                self.coinMarketCap.removeAll(keepingCapacity: true)
                self.coinChange1Hour.removeAll(keepingCapacity: true)

                for name in coinData.data {
                    self.coinArray.append(name.symbol)
                    self.coinPrice.append(Double(name.quote.USD.price))
                    self.coinMarketCap.append(Double(name.quote.USD.market_cap))
                    self.coinLastUpdate.append(name.quote.USD.last_updated)
                    self.coinChange1Hour.append(name.quote.USD.percent_change_1h)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let err {
                print("Error", err)
            }
            }.resume()
    }
    
    
    
    //TODO: TableView İşlemleri
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coinArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath) as! TableViewCell
        

        //double gelen veriyi para birimine dönüştürüyorum.
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "us_US")
        let coinPriceCurrency = currencyFormatter.string(from: NSNumber(value: self.coinPrice[indexPath.row]))!
        let coinMarketCap = currencyFormatter.string(from: NSNumber(value: self.coinMarketCap[indexPath.row]))!
        
        //tableview hücrelerine değerleri gönderiyorum.
        cell.coinLblSym.text = coinArray[indexPath.row]
        cell.coinLblPrice.text = coinPriceCurrency
        cell.coinLblMarketCap.text = "Market cap: \(coinMarketCap)"
        cell.coinLblLastUpdate.text = "Last update: \(coinLastUpdate[indexPath.row])"
        
        //change labelı değişime göre yeşil ya da kırmızı yapıyorum.
        if coinChange1Hour[indexPath.row] <= 0 {
            cell.coinLblChange1Hour.textColor = UIColor.red
            
        } else {
            cell.coinLblChange1Hour.textColor = UIColor(red: 0, green: 0.749, blue: 0.4588, alpha: 1.0) /* #00bf75 */

        }
        
        cell.coinLblChange1Hour.text = "% \(coinChange1Hour[indexPath.row])"
        
        return cell
    }
    
}
