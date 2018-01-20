//
//  SelectExchangeVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class SelectExchangeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let textField: UITextField
    let coin: Coin?
    
    init(textField: UITextField, coin: Coin?) {
        self.textField = textField
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    var exchanges:[String] {
        return Resource.EXCHANGE
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

extension SelectExchangeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reusableIdentifier, for: indexPath) as! SelectTableViewCell
        // 재활용을 하기 때문에 반드시 .none을 default로 해주어야 한다. 안그러면 마크표시가 안지워짐
        let exchange = exchanges[indexPath.row].split(separator: "-")
        let name = String(exchange[0])
        let code = String(exchange[1])
        cell.name.text = name
        cell.code.text = code
        if let exchange = textField.text {
            if exchange == name{
                cell.accessoryType = .checkmark
            }
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
}

extension SelectExchangeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exchange = exchanges[indexPath.row].split(separator: "-")
        let name = String(exchange[0])
        if let exchange = textField.text {
            if exchange != name {
                textField.text = name
                if let coin = coin {
                    coin.exchange = name
                }
            }
        }else { // 없는 상태에서 셀을 선택한 것 -> 즉 처음 거래소를 선택한 것.
            textField.text = name
        }
        tableView.reloadData()
    }
}
