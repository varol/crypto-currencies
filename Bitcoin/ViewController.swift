//
//  ViewController.swift
//  Bitcoin
//
//  Created by VAROL AKSOY on 10.07.2019.
//  Copyright © 2019 VAROL AKSOY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var coinArray : [String] = []
    var coinPrice : [Double] = []
    var coinMarketCap: [Double] = []
    var coinLastUpdate: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        coinPicker.delegate = self
        coinPicker.dataSource = self
        
        
        

            self.retrieveCoinData()
            self.coinPicker.reloadAllComponents()
        
        
    }
    
    

    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var lblCoinName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblMarketCap: UILabel!
    
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
                    self.coinArray.append(name.name)
                    self.coinPrice.append(Double(name.quote.USD.price))
                    self.coinMarketCap.append(Double(name.quote.USD.market_cap))
                    self.coinLastUpdate.append(name.quote.USD.last_updated)
                }
                
                print(self.coinArray)
                self.coinPicker.reloadAllComponents()
                
            } catch let err {
                print("Error", err)
            }
            }.resume()

    
    
    }

    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinArray[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblCoinName.text = coinArray[row]
        let price = coinPrice[row]
        lblPrice.text = "\(price) Dollar"

        
        lblMarketCap.text = String(coinMarketCap[row]) + " Dollar (marketcap)"
        lblLastUpdate.text = coinLastUpdate[row]
    }
    
    
}
