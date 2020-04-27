//
//  ViewController.swift
//  SwiftExample
//
//  Created by 金原有志 on 2020/04/27.
//

import UIKit
import UITextSubClass

class ViewController: UITableViewController {
    @IBOutlet weak var dateTextField: UITextFieldWithDatePicker!
    @IBOutlet weak var dateCountDownTextField: UITextFieldWithDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateTextField.pickerDelegate = self;
        self.dateTextField.pickerView.datePickerMode = .date
        
        self.dateCountDownTextField.pickerDelegate = self;
        self.dateCountDownTextField.pickerView.datePickerMode = .countDownTimer
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

