import UIKit

public protocol UITextFieldWithPickerDelegate: AnyObject {
    func savePicker(textField: UITextFieldWithPicker)
    func textField(_ textFiled: UITextFieldWithPicker, beginEditingWith viewController: UIViewController)
}

public class UITextFieldWithPicker: UITextField {
        public let pickerView: UIPickerView
    public var dataSource: [String] = [] {
        didSet {
            updateText()
        }
    }
    
    let kToolBarHeight = 44
    let kPickerHeight = 216
    let kPopOverHeight = 44 + 216
    let kWeight = 320
    
        let toolbar: UIToolbar
        public weak var pickerDelegate: UITextFieldWithPickerDelegate?
        var popoverController: UIViewController?
        
        public required init?(coder: NSCoder) {
            pickerView = UIPickerView()
            toolbar = UIToolbar()
            super.init(coder: coder)

            pickerView.frame = pickerFrame()
            pickerView.autoresizingMask = []
            pickerView.delegate = self
            pickerView.dataSource = self

            toolbar.isTranslucent = true
            toolbar.sizeToFit()
            
                 let cancelButton = UIBarButtonItem(
                    title: UITextSubClassHelper.localizedString(with: "Cancel"),
                    style: .plain,
                    target: self,
                    action: #selector(cancelPicker)
            )
            
                 let centerSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                 let doneButton = UIBarButtonItem(
                    title: UITextSubClassHelper.localizedString(with: "Done"),
                    style: .done,
                    target: self,
                    action: #selector(donePicker)
            )
            toolbar.items = [cancelButton, centerSpace, doneButton]
            toolbar.frame = CGRect(x: 0, y: 0, width: kWeight, height: kToolBarHeight)
            
            delegate = self
            inputView = pickerView
            inputAccessoryView = toolbar
        }
        func pickerFrame() -> CGRect { CGRect(x: 0, y: kToolBarHeight, width: kWeight, height: kPickerHeight) }
    func dismissPickerView() {
            if let popoverController = popoverController {
               popoverController.dismiss(animated: true)
            } else {
                resignFirstResponder()
            }
        }
        @objc func donePicker() {
            text = selectedValue()
            pickerDelegate?.savePicker(textField: self)
                dismissPickerView()
        }
        public func updateText() {
            text = selectedValue()
        }
        func selectedValue() -> String {
            if !dataSource.isEmpty {
                return dataSource[pickerView.selectedRow(inComponent: 0)]
            } else {
                return ""
            }
    }
      
        @objc func cancelPicker() {
            dismissPickerView()
        }
}

extension UITextFieldWithPicker: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if UI_USER_INTERFACE_IDIOM() == .pad {
                     let popoverController = UIViewController()
            popoverController.view.addSubview(pickerView)
            popoverController.view.addSubview(toolbar)
            
            popoverController.modalPresentationStyle = .popover
            popoverController.popoverPresentationController?.sourceView = self
            popoverController.popoverPresentationController?.sourceRect = self.frame
            popoverController.preferredContentSize = CGSize(width: kWeight, height: kPopOverHeight)
            
            self.pickerDelegate?.textField(self, beginEditingWith:popoverController)
                     self.popoverController = popoverController
                     return false
                 } else {
                     return true
                 }
        }
}

extension UITextFieldWithPicker: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource.count
    }
    
}

extension UITextFieldWithPicker: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !dataSource.isEmpty {
            text = dataSource[row]
        }
    }
}

