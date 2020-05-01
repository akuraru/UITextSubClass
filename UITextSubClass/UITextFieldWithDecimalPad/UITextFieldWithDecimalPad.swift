import UIKit

public class UITextFieldWithDecimalPad: UITextField {
    public var value: NSDecimalNumber {
        get { format(number: .init(string: text)) }
        set { text = format(number: newValue).stringValue }
    }
    public var handler: NSDecimalNumberHandler

    public required init?(coder: NSCoder) {
        handler = .default
        super.init(coder: coder)
        setup()
    }

    public init(handler: NSDecimalNumberHandler) {
        self.handler = handler
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        value = .zero
        keyboardType = .decimalPad
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    @objc func editingChanged(_ sender: UITextField) {
        guard shouldBeReformat(text: text ?? "") else {
            return
        }
        text = format(number: .init(string: text)).stringValue
        undoManager?.removeAllActions()
    }
    func shouldBeReformat(text: String) -> Bool {
        let phoneNumberRegex = "^([1-9]\\d*|0)?(\\.(\\d+)?)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        if predicate.evaluate(with: text) {
            let number = NSDecimalNumber(string: text)
            let formatNumber = format(number: number)
            if number == formatNumber {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    func format(number: NSDecimalNumber) -> NSDecimalNumber {
        number.adding(.zero, withBehavior: handler)
    }
}
