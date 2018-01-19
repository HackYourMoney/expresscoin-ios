//
//  ExchangeHeaderView.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ExchangeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var exchageLogo: UIImageView!
    @IBOutlet weak var coinCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let background = UIView(frame: self.bounds)
        background.backgroundColor = .white
        backgroundView = background
        exchageLogo.image = nil
        coinCount.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exchageLogo.image = nil
        coinCount.text = nil
    }
}
