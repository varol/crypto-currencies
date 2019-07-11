//
//  TableViewController.swift
//  Bitcoin
//
//  Created by VAROL AKSOY on 11.07.2019.
//  Copyright © 2019 VAROL AKSOY. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var coinArray : [String] = []
    var coinPrice : [Double] = []
    var coinMarketCap: [Double] = []
    var coinLastUpdate: [String] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        self.retrieveCoinData()
        tableView.rowHeight = 100
        var refreshControl = UIRefreshControl()
        

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    
    @objc func refresh(_ sender: Any) {
        //  your code to refresh tableView
        
        retrieveCoinData()
        tableView.reloadData()
        refreshControl?.endRefreshing()
        
    }
    
    
        func retrieveCoinData(){
        let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=aa934023-af5f-4c34-b54c-3ef83e4a9ece")!
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let coinData = try decoder.decode(Welcome.self, from: data)
                print(coinData.data[0].quote.USD.price)
                
                
                for name in coinData.data {
                    print(name.name)
                    self.coinArray.append(name.symbol)
                    self.tableView.reloadData()
                    self.coinPrice.append(Double(name.quote.USD.price))
                    self.coinMarketCap.append(Double(name.quote.USD.market_cap))
                    self.coinLastUpdate.append(name.quote.USD.last_updated)
                }
                
                print(self.coinArray)
                self.refreshControl?.endRefreshing()
                self.refreshControl?.removeFromSuperview()
                self.refreshControl = nil
                
            } catch let err {
                print("Error", err)
            }
            }.resume()
        
        

    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coinArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath) as! TableViewCell
        cell.coinLblSym.text = coinArray[indexPath.row]
        cell.coinLblPrice.text = String(coinPrice[indexPath.row])
        cell.coinLblMarketCap.text = String(coinMarketCap[indexPath.row])
        cell.coinLblLastUpdate.text = String(coinLastUpdate[indexPath.row])
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    

}
