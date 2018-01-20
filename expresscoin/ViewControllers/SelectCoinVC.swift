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
    
    let textField: UITextField
    let coin: Coin?
    let exchange: String
    
    init(textField: UITextField, coin: Coin?, exchange: String) {
        self.textField = textField
        self.coin = coin
        self.exchange = exchange
        super.init(nibName: nil, bundle: nil)
    }
    
    var coins:[String] {
        if let coins = Resource.Data[exchange]{
            return coins
        }
        return []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: SelectTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: SelectTableViewCell.reusableIdentifier)
        
        tableView.hideBottonSeparator()

    }
}

extension SelectCoinVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reusableIdentifier, for: indexPath) as! SelectTableViewCell
        
        cell.name.text = coins[indexPath.row]
        if let name = textField.text {
            if name == coins[indexPath.row]{
                cell.accessoryType = .checkmark
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
        if let name = textField.text {
            if name != coins[indexPath.row]{
                textField.text = coins[indexPath.row]
                if let coin = coin { // 코인이 존재한다면 -> 코인을 수정하러 들어왔다는 뜻
                    coin.name = coins[indexPath.row]
                }
            }
        }else {
            textField.text = coins[indexPath.row]
        }
        
        tableView.reloadData()
    }
}
