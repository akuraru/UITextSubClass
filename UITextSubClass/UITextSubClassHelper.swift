import Foundation

public class UITextSubClassHelper {
    public static let UITextSubClassLocalize = "UITextSubClassLocalize"
    public static var alwaysUseMainBundle: Bool = false
    static var _bundle: Bundle?
    public static var bundle: Bundle {
        set { _bundle = newValue }
        get {
        if let _bundle = _bundle {
            return _bundle
        } else if alwaysUseMainBundle {
            return .main
        } else if let coreBundleURL = Bundle(for: self.self).url(forResource: "UITextSubClassLocalize", withExtension: "bundle") {
                return Bundle(url: coreBundleURL)!
            } else {
                return Bundle(for: self.self)
            }
        }
    }
    static func localizedString(with key: String) -> String {
        NSLocalizedString(key, tableName: UITextSubClassLocalize, bundle: bundle, value: key, comment: key)
    }
}

