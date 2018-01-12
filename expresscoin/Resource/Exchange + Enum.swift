import Foundation

enum Exchange:Int {
    case BITHUMB = 0
    case COINONE = 1
    case UPBIT = 2
    case COINNEST = 3
    
    static var count: Int {return Exchange.COINNEST.hashValue + 1}
}
