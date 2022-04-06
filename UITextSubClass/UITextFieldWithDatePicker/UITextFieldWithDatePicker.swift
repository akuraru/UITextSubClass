import UIKit

public protocol UITextFieldWithDatePickerDelegate: AnyObject {
    func savePicker(textField: UITextFieldWithDatePicker)
    func textField(_ textFiled: UITextFieldWithDatePicker, beginEditingWith viewController: UIViewController)
}

public class UITextFieldWithDatePicker: UITextField, UITextFieldDelegate {
    public let pickerView: UIDatePicker
    public var dateFormatter: DateFormatter
    public weak var pickerDelegate: UITextFieldWithDatePickerDelegate?
    let toolbar: UIToolbar
    var popoverController: UIViewController?

    let kToolBarHeight = 44
    let kPickerHeight = 216
    let kPopOverHeight = 44 + 216
    let kWeight = 320

    public required init?(coder: NSCoder) {
        pickerView = UIDatePicker()
        toolbar = UIToolbar()
        dateFormatter = DateFormatter()
        super.init(coder: coder)

        pickerView.frame = pickerFrame()
        pickerView.autoresizingMask = []
        pickerView.minuteInterval = 0
        pickerView.timeZone = TimeZone.current
        pickerView.date = Date()
        pickerView.datePickerMode = .date
        pickerView.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)

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

        dateFormatter.dateFormat = dateFormatString()

        delegate = self
        inputView = pickerView
        inputAccessoryView = toolbar
    }
    public func pickerFrame() -> CGRect { CGRect(x: 0, y: kToolBarHeight, width: kWeight, height: kPickerHeight) }
    public func dismissPickerView() {
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
    public func inputedDate() -> Date? { text.flatMap(dateFormatter.date(from:)) }
    func selectedValue() -> String {
        // countdown is special case
        if pickerView.datePickerMode == .countDownTimer {
            return string(from: pickerView.countDownDuration)
        }
        return dateFormatter.string(from: pickerView.date)
    }
    func string(from interval: TimeInterval) -> String {
        let calendar = Calendar.current
        let fromDate = Date()
        let toDate = Date(timeInterval: interval, since: fromDate)
        let components: Set<Calendar.Component> = [.month, .day, .hour, .minute]
        let conversionInfo = calendar.dateComponents(components, from: fromDate, to: toDate)
        var mutableString = String()
        if 0 < conversionInfo.hour ?? 0 {
            let hour = UITextSubClassHelper.localizedString(with: "%d hour")
            mutableString = mutableString.appendingFormat(hour, conversionInfo.hour!)
        }
        if 0 < conversionInfo.minute ?? 0 {
            let minue = UITextSubClassHelper.localizedString(with: "%d min")
            mutableString = mutableString.appendingFormat(minue, conversionInfo.minute!)
        }

        return mutableString
    }

    @objc func cancelPicker() {
        dismissPickerView()
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let popoverController = UIViewController()
            popoverController.view.addSubview(pickerView)
            popoverController.view.addSubview(toolbar)

            popoverController.modalPresentationStyle = .popover
            popoverController.popoverPresentationController?.sourceView = self
            popoverController.popoverPresentationController?.sourceRect = self.bounds
            popoverController.preferredContentSize = CGSize(width: kWeight, height: kPopOverHeight)

            self.pickerDelegate?.textField(self, beginEditingWith: popoverController)
            self.popoverController = popoverController
            return false
        } else {
            return true
        }
    }

    func dateFormatString() -> String {
        switch pickerView.datePickerMode {
        case .date:
            return DateFormatter.dateFormat(fromTemplate: "yyyyMd", options: 0, locale: .current)!
        case .time:
            return DateFormatter.dateFormat(fromTemplate: "HHmm", options: 0, locale: .current)!
        case .dateAndTime:
            return DateFormatter.dateFormat(fromTemplate: "yyyyMd HHmm", options: 0, locale: .current)!
        default:
            return ""
        }
    }

    @objc func pickerValueChanged(_ sender: UIDatePicker) {
        text = selectedValue()
    }
}
