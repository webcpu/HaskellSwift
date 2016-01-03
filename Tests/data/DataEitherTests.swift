import XCTest

@testable import HaskellSwift

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

    typealias SI    = Either<String, Int>
    //MARK: lefts
    func testlefts() {
        let es          = [SI.Left("foo"), SI.Right(3), SI.Left("bar"), SI.Right(7), SI.Left("baz")]
        let xs          = lefts(es)
        XCTAssertTrue( xs == ["foo", "bar", "baz"])
    }

    //MARK: rights
    func testrights() {
        let es          = [SI.Left("foo"), SI.Right(3), SI.Left("bar"), SI.Right(7), SI.Left("baz")]
        let xs          = rights(es)
        XCTAssertTrue( xs == [3, 7])
    }

    //MARK: partitionEithers
    func testpartitionEithers() {
        let es          = [SI.Left("foo"), SI.Right(3), SI.Left("bar"), SI.Right(7), SI.Left("baz")]
        let (ls, rs)    = partitionEithers(es)
        XCTAssertTrue( ls == ["foo", "bar", "baz"])
        XCTAssertTrue( rs == [3, 7])
    }
}