import XCTest

@testable import HaskellSwift

class DataTupleTests: XCTestCase {
    //MARK: fst
    func testfst() {
        let t = (1, "2")
        XCTAssertTrue(fst(t) == t.0)
    }

    //MARK: snd
    func testsnd() {
        let t = (1, "2")
        XCTAssertTrue(snd(t) == t.1)
    }

    //MARK: curry
    func testcurry() {
        let add = { (a: Int, b: Int) -> Int in
            return a + b
        }

        let curriedAdd = curry(add, 1)
        XCTAssertTrue(curriedAdd(2) == add(1, 2))


    }

    func testuncurry() {
        let curriedAdd = { (a: Int) -> Int -> Int in
            return { (b: Int) -> Int in
                return a + b
            }
        }

        let add = uncurry(curriedAdd)
        XCTAssertTrue(curriedAdd(1)(2) == add(1, 2))
    }

    func testcurryuncurry() {
        let add = { (a: Int, b: Int) -> Int in
            return a + b
        }

        let curriedAdd = { (a: Int) -> Int -> Int in
            return { (b: Int) -> Int in
                return a + b
            }
        }

        XCTAssertTrue(curry(add, 1)(2) == curriedAdd(1)(2))
    }

    //MARK swap
    func testswap() {
        let old = (1, "2")
        let new = swap(old)
        XCTAssertTrue(old.0 == new.1 && old.1 == new.0)
    }
}