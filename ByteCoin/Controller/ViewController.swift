//
//  ViewController.swift
//  ByteCoin


import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    
    
    
    var coinManager = CoinManager()
    
    // Number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // Number of rows or items in picker based on array count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // Set values of picker equal to values in array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // Called when user selects a row in user interface
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        
        // Set current ViewController as dataSource and delegate
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    
    func didGetPrice(price: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", price)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}




