//
//  Coin.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

class Formatters {
    static let price: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}
class Coin: Codable {
    
    static let didDelete = Notification.Name(rawValue: "didDelete")
    
    var exchange:String
    var name:String
    var price: String
    var amount: String
    
    var decimalPrice: String? {
        if let number = Formatters.price.number(from: price){
            return Formatters.price.string(from: number)
        }
        return nil
    }
    
    init(exchange: String, name:String, price: String, amount: String) {
        self.exchange = exchange
        self.name = name
        self.price = price.replacingOccurrences(of: Formatters.price.groupingSeparator, with: "") // "1,000,000" -> "1000000"
        self.amount = amount.replacingOccurrences(of: Formatters.price.groupingSeparator, with: "")
    }
}
