import XCTest

@testable import HaskellSwift

//class LogTests: XCTestCase , XCTestCaseProvider {

class DataFunctorTests: XCTestCase {
    //MARK: fmap
    func testfmap() {
        let f1 = { $0 + 1 }
        let f2 = { $0 * 2 }
        let result = fmap(f1, f2)(1)
        XCTAssertTrue(result == 3)
    }

    //MARK: <^>
    func testfmapOperator() {
        let f1 = { $0 + 1 }
        let f2 = { $0 * 2 }
        let f  = f1 <^> f2
        let result = f(1)
        XCTAssertTrue(result == 3)
    }

    //MARK: <|
    func testfunctorFunction() {
        let f1 = { $0 + 1 }
        let f = 2 <| f1
        let result = f(5)
        XCTAssertTrue(result == 3)
    }

    func testfunctorArray() {
        let xs = [1, 2, 3]
        let result = 2 <| xs
        XCTAssertTrue(result == [2, 2, 2])
    }

    func testfunctorTuple() {
        let t = ("5", 6)
        let result = 2 <| t
        XCTAssertTrue(result.0 == "5" && result.1 == 2)
    }

    //MARK: |>
    func testflippedfunctorFunction() {
        let f1 = { $0 + 1 }
        let f = f1 |> 2
        let result = f(5)
        XCTAssertTrue(result == 3)
    }

    func testflippedfunctorArray() {
        let xs = [1, 2, 3]
        let result = xs |> 2
        XCTAssertTrue(result == [2, 2, 2])
    }

    func testflippedfunctorTuple() {
        let t = ("5", 6)
        let result = t |> 2
        XCTAssertTrue(result.0 == "5" && result.1 == 2)
    }
}