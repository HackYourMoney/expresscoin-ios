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
    
    init(textField: UITextField, coin: Coin?) {
        self.textField = textField
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
        return Resource.COIN.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Resource.COIN[indexPath.row]
        if let name = textField.text {
            if name == Resource.COIN[indexPath.row] {
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
        if let name = textField.text {
            if name != Resource.COIN[indexPath.row]{
                textField.text = Resource.COIN[indexPath.row]
                if let coin = coin {
                    coin.name = Resource.COIN[indexPath.row]
                }
            }
        }else {
            textField.text = Resource.COIN[indexPath.row]
        }
        
        tableView.reloadData()
    }
}
