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
    var currentPrice: Double?
    var currentValue: Double?
    var valueDiff:Double?
    
    var decimalPrice: String? {
        if let number = Formatters.price.number(from: price){
            return Formatters.price.string(from: number)
        }
        return nil
    }
    
    var valueDiffText: String {
        if let valueDiff = self.valueDiff {
            if valueDiff < 0.0 {
                return "▼ -\(valueDiff)%"
            }else if valueDiff == 0.0{
                return "0 +0.00%"
            }else {
                return "▲ +\(valueDiff)"
            }
        }
        return ""
    }
    
    init(exchange: String, name:String, price: String, amount: String) {
        self.exchange = exchange
        self.name = name
        self.price = price.replacingOccurrences(of: Formatters.price.groupingSeparator, with: "") // "1,000,000" -> "1000000"
        self.amount = amount.replacingOccurrences(of: Formatters.price.groupingSeparator, with: "")
    }
}
