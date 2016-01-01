import XCTest

@testable import HaskellSwift

//class LogTests: XCTestCase , XCTestCaseProvider {

class DataEitherTests: XCTestCase {
    //MARK: Left
    func testisLeft() {
        let e0 = Either<String, Int>.Left("foo")
        let e1 = Either<String, Int>.Right(5)
        XCTAssertTrue(isLeft(e0))
        XCTAssertFalse(isLeft(e1))
    }

    //MARK: Right
    func testisRight() {
        let e0 = Either<String, Int>.Left("foo")
        let e1 = Either<String, Int>.Right(5)
        XCTAssertFalse(isRight(e0))
        XCTAssertTrue(isRight(e1))
    }

    //MARK: fromLeft
    func testfromLeft() {
        let e = Either<String, Int>.Left("foo")
        let value = fromLeft(e)
        XCTAssertTrue(value == "foo")
    }

    //MARK: fromRight
    func testfromRight() {
        let e = Either<String, Int>.Right(5)
        let value = fromRight(e)
        XCTAssertTrue(value == 5)
    }

    //MARK: either
    func testeither() {
        let e0 = Either<String, Int>.Left("foo")
        let e1 = Either<String, Int>.Right(5)
        let leftHandler = { (x: String) -> Bool in
            return x == "foo"
        }
        let rightHandler = { (x: Int) -> Bool in
            return x == 5
        }
        let r0 = either(leftHandler, rightHandler, e0)
        let r1 = either(leftHandler, rightHandler, e1)

        XCTAssertTrue(r0)
        XCTAssertTrue(r1)
    }
}