//
//  CoinTableViewCell.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceDiffLabel: UILabel!
    
    var coin: Coin? {
        didSet{
            nameLabel.text = coin?.name
            priceLabel.text = coin?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.text = nil
        nameLabel.text = nil
        priceDiffLabel.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceLabel.text = nil
        nameLabel.text = nil
        priceDiffLabel.text = nil
        
    }
}
