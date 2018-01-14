import Foundation

enum Exchange:Int {
    case BITHUMB = 0
    case COINONE = 1
    case UPBIT = 2
    case COINNEST = 3
    
    static var count: Int {return Exchange.COINNEST.hashValue + 1}
}


struct Resource {
    static let COIN:[String] = ["비트코인", "이더리움", "리플", "이오스", "에이다", "퀀텀"]
    static let EXCHANGE:[String] = ["빗썸", "코인원", "코인네스트", "업비트"]
}
