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
    
    var exchangeTextField: UITextField!
    var coinNameTextField: UITextField!
    
    var priceTextField: UITextField!
    var amountTextField: UITextField!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
       
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
}

// MARK : UITableViewDataSource

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
            self.exchangeTextField = cell.textField
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
                self.coinNameTextField = cell.textField
                cell.accessoryType = .disclosureIndicator
                cell.textField.isEnabled = false
                
                return cell
            }else if indexPath.row == 1 {
                cell.label.text = "코인 가격"
                cell.textField.placeholder = "구매 당시 코인 가격을 입력하세요"
                
                if let price = coin?.price, let decimalPrice = Formatters.price.number(from: price){
                    cell.textField.text = Formatters.price.string(from: decimalPrice)
                }
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                self.priceTextField = cell.textField
                addDoneButtonToTextField(textField: priceTextField)
                
                return cell
            }else if indexPath.row == 2 {
                cell.label.text = "매수 가격"
                cell.textField.placeholder = "얼마를 구매하셨는지 입력하세요."
                if let amount = coin?.amount, let decimalAmount = Formatters.price.number(from: amount) {
                    cell.textField.text = Formatters.price.string(from: decimalAmount)
                }
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                self.amountTextField = cell.textField
                addDoneButtonToTextField(textField: amountTextField)
                
                return cell
            }
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteTableViewCell.reusableIdentifier, for: indexPath) as! DeleteTableViewCell
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension EditCoinVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0{
            // 거래소 선택
            self.navigationController?.pushViewController(SelectExchangeVC(textField: exchangeTextField), animated: true)
        }else if indexPath.section == 1 && indexPath.row == 0 {
            // 코인 선택
            self.navigationController?.pushViewController(SelectCoinVC(textField: coinNameTextField), animated: true)
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

// MARK: Keyboard Issue on iPhone SE size

extension EditCoinVC {
    @objc func keyboardWillShow(_ sender:Notification){
        if UIDevice().userInterfaceIdiom == .phone { // SE 이하일 땐
            if UIScreen.main.nativeBounds.height <= CGFloat(1136.0){
                self.view.frame.origin.y = -150
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender:Notification){
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height <= CGFloat(1136.0){
                self.view.frame.origin.y = 0
            }
        }
    }
}

// MARK: TextFieldDelegate - textField(:range:string:)->Bool

extension EditCoinVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = Formatters.price
        if let removeAllSeparator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "") {
            var beforeFormattedString = removeAllSeparator + string
            if formatter.number(from: string) != nil {
                if let formattedNumber = formatter.number(from: beforeFormattedString), let formattedString = formatter.string(from: formattedNumber) {
                    textField.text = formattedString
                    return false
                }
            }else {
                if string == ""{
                    let lastIndex = beforeFormattedString.index(beforeFormattedString.endIndex, offsetBy: -1)
                    beforeFormattedString = String(beforeFormattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeFormattedString), let formattedString = formatter.string(from: formattedNumber) {
                        textField.text = formattedString
                        return false
                    }
                }else {
                    return false
                }
            }
        }
        return true
    }
    
    func addDoneButtonToTextField(textField: UITextField){
        let toolbarDone = UIToolbar()
        toolbarDone.tintColor = UIColor.themeDark
        toolbarDone.sizeToFit()
        let flexBarBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtnDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneBtnPressed)) // 버튼 액션
        if textField == priceTextField {
            let barBtnNext = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextBtnPressed))
            toolbarDone.items = [barBtnNext,flexBarBtn, barBtnDone]
        }else if textField == amountTextField{
            toolbarDone.items = [flexBarBtn, barBtnDone]
        }
        textField.inputAccessoryView = toolbarDone
    }
    
}

// MARK: Target-Action

extension EditCoinVC{
    @objc func cancel(){
        view.endEditing(true) // 키보드가 같이 사라져야 한다.
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        let alert = UIAlertController(title: "Error", message: "모든 항목을 입력하지 않았습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        if let exchange = exchangeTextField.text, !exchange.isEmpty, let name = coinNameTextField.text, !name.isEmpty, let price = priceTextField.text,!price.isEmpty, let amount = amountTextField.text, !amount.isEmpty {
            if let coin = self.coin { // 코인이 존재한다면, 즉 수정하기 위해 들어왔을 때
                coin.exchange = exchange
                coin.name = name
                coin.price = price
                coin.amount = amount
                didUpdate!(coin)
            }else{ // 코인이 존재하지 않는다면, 즉 코인을 새로 추가하러 들어왔을 때
                let newCoin = Coin(exchange: exchange, name: name, price: price, amount: amount)
                didUpdate!(newCoin)
            }
            SVProgressHUD.showSuccess(withStatus: "Saved")
            SVProgressHUD.dismiss(withDelay: 1)
            view.endEditing(true)
        }else{
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    
    @objc func millionBtnPressed(){
        if let string = priceTextField.text, !string.isEmpty {
            textField(priceTextField, shouldChangeCharactersIn: NSRangeFromString(string), replacementString: "0000")
        }
    }
    
    @objc func nextBtnPressed(){
        if priceTextField.isFirstResponder {
            amountTextField.becomeFirstResponder()
        }
    }
    
    @objc func doneBtnPressed(){
        view.endEditing(true)
    }
}
