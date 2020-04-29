import XCTest
@testable import UITextSubClass

class UITextFieldWithDecimalPadTests: XCTestCase {
    func test_shouldBeReformat() {
        let decimalPad = UITextFieldWithDecimalPad(handler: .init(roundingMode: .down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: ""))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: "0"))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: "."))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: ".001"))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: ".0"))
        XCTAssertFalse(decimalPad.shouldBeReformat(text: ".0000"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: "1e4"))
        
        XCTAssertTrue(decimalPad.shouldBeReformat(text: "1e"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: "a"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: "1.2.3"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: ".0001"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: "1e-4"))
        XCTAssertTrue(decimalPad.shouldBeReformat(text: ".0011"))
    }
}
