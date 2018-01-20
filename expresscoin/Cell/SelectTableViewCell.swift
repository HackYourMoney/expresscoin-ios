//
//  SelectTableViewCell.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 20..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class SelectTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        name.text = nil
        code.text = nil
        accessoryType = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        code.text = nil
        accessoryType = .none
    }
}
