//
//  MainVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 9..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CoinExchange {
    var exchange: String?
    var coins: [Coin]
    
    init(exchange: String, coins: [Coin]) {
        self.exchange = exchange
        self.coins = coins
    }
}

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var coinExchanges: [CoinExchange] = []
    var coins:[Coin] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "EXPRESS COIN"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CoinTableViewCell.reusableIdentifier, bundle:nil), forCellReuseIdentifier: CoinTableViewCell.reusableIdentifier)
        tableView.register(UINib(nibName: ExchangeHeaderView.reusableIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ExchangeHeaderView.reusableIdentifier)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-add"), style: .plain, target: self, action: #selector(add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        tableView.hideBottonSeparator()
    }
}

extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return coinExchanges.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinExchanges[section].coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reusableIdentifier, for: indexPath) as! CoinTableViewCell
        cell.coin = coinExchanges[indexPath.section].coins[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExchangeHeaderView.reusableIdentifier) as! ExchangeHeaderView
        let exchange = coinExchanges[section].exchange
        if exchange == "빗썸" {
            view.exchageLogo.image = #imageLiteral(resourceName: "bithumb")
        }else if exchange == "코인네스트"{
            view.exchageLogo.image = #imageLiteral(resourceName: "coinnest")
        }else if exchange == "코인원" {
            view.exchageLogo.image = #imageLiteral(resourceName: "coinone")
        }else if exchange == "업비트"{
            view.exchageLogo.image = #imageLiteral(resourceName: "upbit")
        }
        
        let count = coinExchanges[section].coins.count
        view.coinCount.text = "\(count)코인"
        
        return view
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let editCoinVC = EditCoinVC(coin: coins[indexPath.row])
        editCoinVC.didUpdate = { coin in
            self.coins[indexPath.row] = coin
            self.reload()
        }
        
        present(UINavigationController(rootViewController: editCoinVC), animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return coinExchanges[section].exchange
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(78.0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(38)
    }
}

extension MainVC {
    @objc func add(){
        let editCoinVC = EditCoinVC(coin: nil)
        
        editCoinVC.didUpdate = {(coin) in
            self.coins.append(coin)
            self.reload()
        }
        
        present(UINavigationController(rootViewController: editCoinVC), animated: true, completion: nil)
    }
    
    @objc func refresh(){
        
    }
    
    func reload(){
        coinExchanges.removeAll()
        for exchange in Resource.EXCHANGE {
            let coinExchange = CoinExchange(exchange: exchange, coins: coins.filter({$0.exchange == exchange}))
            if coinExchange.coins.count > 0 {
                self.coinExchanges.append(coinExchange)
            }
        }
        self.tableView.reloadData()
    }
}
