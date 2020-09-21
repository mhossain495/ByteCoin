//
//  ViewController.swift
//  ByteCoin


import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    var coinManager = CoinManager()
    
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
}

//MARK: - UIPickerViewDelegate

// extension of ViewController to add Protocol conformance
extension ViewController: UIPickerViewDelegate {
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
    
}

//MARK: - CoinManagerDelegate

// extension of ViewController to add Protocol conformance
extension ViewController: CoinManagerDelegate {
    
    func didGetPrice(price: Double) {
        
        // NumberFormatter object to convert values to decimal points with comma separator
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = numberFormatter.string(from: NSNumber(value: price))
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
