//
//  ViewController.swift
//  SwiftExample
//
//  Created by 金原有志 on 2020/04/27.
//

import UIKit
import UITextSubClass

class ViewController: UITableViewController {
    @IBOutlet weak var decimalPad: UITextFieldWithDecimalPad!
    @IBOutlet weak var dateTextField: UITextFieldWithDatePicker!
    @IBOutlet weak var dateCountDownTextField: UITextFieldWithDatePicker!
    @IBOutlet weak var pickerTextField: UITextFieldWithPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        decimalPad.handler = .init(roundingMode: .down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        
        self.dateTextField.pickerDelegate = self;
        self.dateTextField.pickerView.datePickerMode = .date
        
        self.dateCountDownTextField.pickerDelegate = self;
        self.dateCountDownTextField.pickerView.datePickerMode = .countDownTimer
        
        self.pickerTextField.pickerDelegate = self
        self.pickerTextField.dataSource = ["foo", "biz", "bar"]
    }
}

extension ViewController: UITextFieldWithDatePickerDelegate {
    func textField(_ textFiled: UITextFieldWithDatePicker, beginEditingWith viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func savePicker(textField: UITextFieldWithDatePicker) {
        print(textField.pickerView.date)
    }
}

extension ViewController: UITextFieldWithPickerDelegate {
    func textField(_ textFiled: UITextFieldWithPicker, beginEditingWith viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func savePicker(textField: UITextFieldWithPicker) {
        print(textField.pickerView)
    }
}
