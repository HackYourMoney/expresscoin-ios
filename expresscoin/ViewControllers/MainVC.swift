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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDelete(_:)), name: Coin.didDelete, object: nil)
        
        loadCoin()
    }
}

// MARK: Data Save

extension MainVC {
    func saveCoin(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(coins), forKey: "coins")
        loadCoin()
    }
    
    func loadCoin(){
        if let data = UserDefaults.standard.object(forKey: "coins") as? Data {
            coins = try! PropertyListDecoder().decode([Coin].self, from: data)
            
            coinExchanges.removeAll()
            
            for exchangeData in Resource.EXCHANGE {
                let exchange = String(exchangeData.split(separator: "-")[0])
                let coinExchange = CoinExchange(exchange: exchange, coins: coins.filter({$0.exchange == exchange}))
                if coinExchange.coins.count > 0 {
                    self.coinExchanges.append(coinExchange)
                }
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource

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

// MARK: UITableViewDelegate

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let editCoinVC = EditCoinVC(coin: coinExchanges[indexPath.section].coins[indexPath.row])
        editCoinVC.didUpdate = { coin in
            self.coins[indexPath.row] = coin
            self.saveCoin()
        }
        
        present(UINavigationController(rootViewController: editCoinVC), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(38)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let coin = coinExchanges[indexPath.section].coins[indexPath.row]
            let index = coins.index(where: {
                $0.name == coin.name && $0.exchange == coin.exchange
            })
            if let index = index {
                coins.remove(at: index)
                saveCoin()
            }
        }
    }
}

// MARK: Data

extension MainVC {
    @objc func add(){
        let editCoinVC = EditCoinVC(coin: nil)
        
        editCoinVC.didUpdate = {(coin) in
            self.coins.append(coin)
            self.saveCoin()
        }
        
        present(UINavigationController(rootViewController: editCoinVC), animated: true, completion: nil)
    }
    
    @objc func refresh(){
        // Refresh
    }
    
    @objc func didDelete(_ notification: Notification) {
        guard let coinToDelete = notification.object as? Coin else {return}
        coins.forEach {print($0.name)}
        let index = coins.index(where: {$0.name == coinToDelete.name})
        if let index = index {
            coins.remove(at: index)
        }
        saveCoin()
    }
}
