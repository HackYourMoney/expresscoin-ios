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
    
    var textField: UITextField
    
    init(textField: UITextField) {
        self.textField = textField
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

extension SelectExchangeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resource.EXCHANGE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Resource.EXCHANGE[indexPath.row]
        if let exchange = textField.text {
            if exchange == Resource.EXCHANGE[indexPath.row]{
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
        if let exchange = textField.text {
            if exchange != Resource.EXCHANGE[indexPath.row] {
                textField.text = Resource.EXCHANGE[indexPath.row]
            }
        }else { // 없는 상태에서 셀을 선택한 것 -> 즉 처음 거래소를 선택한 것.
            textField.text = Resource.EXCHANGE[indexPath.row]
        }
        tableView.reloadData()
    }
}
