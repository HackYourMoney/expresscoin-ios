//
//  TextFieldTableViewCell.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = nil
        
        self.accessoryType = .none
        textField.textAlignment = .right
        textField.isEnabled = true
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.accessoryType = .none
        textField.textAlignment = .right
        textField.isEnabled = true
        label.text = nil
    }
}
