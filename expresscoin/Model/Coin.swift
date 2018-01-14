//
//  Coin.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

class Coin {
    var exchange:String
    var name:String
    
    init(exchange: String, name:String) {
        self.exchange = exchange
        self.name = name
    }
}
