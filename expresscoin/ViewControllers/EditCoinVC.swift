//
//  EditCoinVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class EditCoinVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Add Coin"
    
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        tableView.hideBottonSeparator()
    
        tableView.register(UINib(nibName: TextFieldTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.reusableIdentifier)
        
        tableView.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.reusableIdentifier)
    }
}

extension EditCoinVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 2
        }else if section == 2{
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reusableIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.label.text = "거래소"
            cell.textField.placeholder = "거래소를 선택하세요."
            cell.accessoryType = .disclosureIndicator
            cell.textField.isEnabled = false
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reusableIdentifier, for: indexPath) as! TextFieldTableViewCell
            if indexPath.row == 0 {
                cell.label.text = "코인 가격"
                cell.textField.placeholder = "구매 당시 코인 가격을 입력하세요"
                cell.accessoryType = .none
                cell.textField.keyboardType = .numberPad
                cell.textField.isEnabled = true
                return cell
            }else if indexPath.row == 1 {
                cell.label.text = "매수 가격"
                cell.textField.placeholder = "얼마를 구매하셨는지 입력하세요."
                cell.accessoryType = .none
                cell.textField.keyboardType = .numberPad
                cell.textField.isEnabled = true
                return cell
            }
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteTableViewCell.reusableIdentifier, for: indexPath) as! DeleteTableViewCell
            return cell
        }
        
        return UITableViewCell()
    }
}

extension EditCoinVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "EXCHANGE"
        }else if section == 1 {
            return "PRICE"
        }
        return ""
    }
}

extension EditCoinVC {
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        
    }
}
