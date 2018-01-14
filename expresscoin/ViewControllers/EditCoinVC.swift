//
//  EditCoinVC.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import SVProgressHUD

class EditCoinVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var coinPriceTextField: UITextField?
    var buyPriceTextField: UITextField?
    
    var didUpdate:((Coin)->())?
    var coin:Coin?
    
    init(coin: Coin?) {
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
        
        title = "Add Coin"
        
        // COIN ADD
        if coin == nil {
            coin = Coin()
        }
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        tableView.hideBottonSeparator()
    
        tableView.register(UINib(nibName: TextFieldTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.reusableIdentifier)
        
        tableView.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.reusableIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coinPriceTextField?.becomeFirstResponder() // 가장 먼저 포커싱
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
            return 3
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
            
            if coin != nil{
                cell.textField.text = coin?.exchange
            }
            
            cell.accessoryType = .disclosureIndicator
            cell.textField.isEnabled = false
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reusableIdentifier, for: indexPath) as! TextFieldTableViewCell
            if indexPath.row == 0 {
                cell.label.text = "코인"
                if coin?.name != nil {
                    cell.textField.text = coin?.name
                }else{
                    cell.textField.placeholder = "코인을 선택하세요"
                }
                cell.accessoryType = .disclosureIndicator
                cell.textField.isEnabled = false
                
                return cell
            }else if indexPath.row == 1 {
                cell.label.text = "코인 가격"
                cell.textField.placeholder = "구매 당시 코인 가격을 입력하세요"
                cell.accessoryType = .none
                cell.textField.keyboardType = .numberPad
                cell.textField.isEnabled = true
                
                self.coinPriceTextField = cell.textField
                
                return cell
            }else if indexPath.row == 2 {
                cell.label.text = "매수 가격"
                cell.textField.placeholder = "얼마를 구매하셨는지 입력하세요."
                cell.accessoryType = .none
                cell.textField.keyboardType = .numberPad
                cell.textField.isEnabled = true
                
                self.buyPriceTextField = cell.textField
                
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
        
        if indexPath.section == 0 && indexPath.row == 0{
            // 거래소 선택
            self.navigationController?.pushViewController(SelectExchangeVC(coin: coin!), animated: true)
        }else if indexPath.section == 1 && indexPath.row == 0 {
            // 코인 선택
            self.navigationController?.pushViewController(SelectCoinVC(coin: coin!), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "EXCHANGE"
        }else if section == 1 {
            return "COIN"
        }
        return nil
    }
}

extension EditCoinVC {
    @objc func cancel(){
        view.endEditing(true) // 키보드가 같이 사라져야 한다.
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        buyPriceTextField?.resignFirstResponder()
        SVProgressHUD.showSuccess(withStatus: "Saved")
        SVProgressHUD.dismiss(withDelay: 1)
    }
}
