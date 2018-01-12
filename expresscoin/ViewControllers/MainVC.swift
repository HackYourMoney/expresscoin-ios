//
//  MainVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 9..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CoinExchange {
    var exchange: Exchange?
    var coins: [Coin]
    
    init(exchange: Exchange, coins: [Coin]) {
        self.exchange = exchange
        self.coins = coins
    }
}

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var coinExchanges: [CoinExchange] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "EXPRESS COIN"
        
        tableView.delegate = self
        tableView.dataSource = self
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-add"), style: .plain, target: self, action: #selector(add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        tableView.hideBottonSeparator()
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension MainVC {
    @objc func add(){
        present(UINavigationController(rootViewController: EditCoinVC()), animated: true, completion: nil)
    }
    
    @objc func refresh(){
        
    }
}
