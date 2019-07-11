//
//  TableViewCell.swift
//  Bitcoin
//
//  Created by VAROL AKSOY on 11.07.2019.
//  Copyright © 2019 VAROL AKSOY. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var coinLblPrice: UILabel!
    
    @IBOutlet weak var coinLblSym: UILabel!
    @IBOutlet weak var coinLblMarketCap: UILabel!
    @IBOutlet weak var coinLblLastUpdate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
