import Foundation
import UIKit

public class UITextViewWithPlaceholder: UITextView {
    public weak var placeholder: UILabel!

    public func updatePlaceholderLabel() {
        if text.isEmpty {
            placeholder.alpha = 1
        } else {
            placeholder.alpha = 0
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setupPlaceholder() {
        placeholder.lineBreakMode = .byWordWrapping
        placeholder.numberOfLines = 0
        placeholder.backgroundColor = .clear
        placeholder.alpha = 1
        placeholder.textColor = .lightGray
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            self.topAnchor.constraint(equalTo: placeholder.topAnchor, constant: -8),
            self.leftAnchor.constraint(equalTo: placeholder.leftAnchor, constant: -8),
            self.rightAnchor.constraint(equalTo: placeholder.rightAnchor, constant: -8),
        ])

        NotificationCenter.default.addObserver(
            self, selector: #selector(textChanged(_:)), name: UITextView.textDidChangeNotification, object: nil)

        NotificationCenter.default.addObserver(
            self, selector: #selector(lostFocus(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }

    public required init?(coder: NSCoder) {
        let placeholder = UILabel()
        self.placeholder = placeholder
        super.init(coder: coder)
        addSubview(placeholder)
        setupPlaceholder()
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        let placeholder = UILabel()
        self.placeholder = placeholder
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholder)
        setupPlaceholder()
    }

    @objc func textChanged(_ notification: NSNotification) {
        updatePlaceholderLabel()
    }

    @objc func lostFocus(_ notification: NSNotification) {
        updatePlaceholderLabel()
    }

    public override var font: UIFont? {
        didSet {
            placeholder.font = font
            updatePlaceholderLabel()
        }
    }
}
