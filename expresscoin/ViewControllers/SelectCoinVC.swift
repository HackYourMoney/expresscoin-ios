//
//  SelectCoinVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 14..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class SelectCoinVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var coins = ["비트코인", "이더리움", "리플", "이오스", "에이다", "퀀텀"]
    var coin:Coin
    
    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.hideBottonSeparator()

    }
}

extension SelectCoinVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = coins[indexPath.row]
        if let name = coin.name {
            if name == coins[indexPath.row] {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
}

extension SelectCoinVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let name = coin.name {
            if name != coins[indexPath.row]{
                coin.name = coins[indexPath.row]
            }
        }else {
            coin.name = coins[indexPath.row]
        }
        
        tableView.reloadData()
    }
}
