//
//  UITextFieldWithNumberPad.swift
//  UITextSubClass
//
//  Created by akuraru on 2018/06/12.
//

import Foundation
import UIKit

@objc class UITextFieldWithNumberPad: UITextField {
    private var _value: Int = 0
    public let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)

    public var value: Int {
        get {
            return _value
        }
        set(v) {
            _value = v
            text = String(v)
        }
    }

    func setup() {
        value = 0
        addTarget(self, action: #selector(UITextFieldWithNumberPad.didChangeText), for: .editingChanged)
    }

    @objc func didChangeText() {
        let value = Int(text ?? "")
        if let value = value {
            _value = value
        } else {
            self.value = _value
        }
    }

    override var inputAccessoryView: UIView? {
        get {
            let toolbar = UIToolbar()
            toolbar.isTranslucent = true
            toolbar.sizeToFit()

            let centerSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

            toolbar.items = [centerSpace, doneButton]

            return toolbar
        }
        set {
        }
    }

    override var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set {
        }
    }

    override var undoManager: UndoManager? {
        return nil
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
