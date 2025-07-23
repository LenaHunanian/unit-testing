//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        // TODO: Implement test
        let result = try calculator.divide(10, 5)
        XCTAssertEqual(2, result)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        // TODO: Implement test
        XCTAssertThrowsError(try calculator.divide(10, 0)){error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .divisionByZero)
        }
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        // TODO: Implement test
        XCTAssertFalse(calculator.isGreaterThanTen(5))
        XCTAssertFalse(calculator.isGreaterThanTen(10))
        XCTAssertTrue(calculator.isGreaterThanTen(15))
        
    }

    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        // TODO: Implement test
        XCTAssertNotNil(calculator.safeSquareRoot(10))
        XCTAssertEqual(calculator.safeSquareRoot(25), 5)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        // TODO: Implement test
        XCTAssertNil(calculator.safeSquareRoot(-5))
    }
}
