import XCTest

@testable import HaskellSwift

class DataMaybeTests: XCTestCase {
    //MARK: Nothing
    func testNothing() {
        XCTAssertTrue(Nothing() == nil)
    }
    
    //MARK: Just
    func testJust() {
        let x = Just(3)
        XCTAssertTrue(x! == 3)
    }

    //MARK: maybe
    func testmaybe() {
        let f = { (b: Int) -> Int in
            b + 2
        }
        let r0 = maybe(1, f, 3)
        XCTAssertTrue(r0 == 5)
        let r1 = maybe(1, f, nil)
        XCTAssertTrue(r1 == 1)
    }

    //MARK: isJust
    func testisJust() {
        let a: Int? = 3
        XCTAssertTrue(isJust(a))
        let b: Int? = nil
        XCTAssertFalse(isJust(b))
    }

    //MARK: isNothing
    func testisNothing() {
        let a: Int? = 3
        XCTAssertFalse(isNothing(a))
        let b: Int? = nil
        XCTAssertTrue(isNothing(b))
    }

    //MARK: fromJust
    func testfromJust() {
        let a: Int? = 3
        XCTAssertTrue(fromJust(a) == 3)
    }

    //MARK: fromMaybe
    func testfromMaybe() {
        let a0: Int? = 3
        let a1: Int? = nil
        let b: Int = 2
        XCTAssertTrue(fromMaybe(b, a0) == 3)
        XCTAssertTrue(fromMaybe(b, a1) == 2)
    }

    //MARK: listToMaybe
    func testlistToMaybe() {
        let xs0 = [1,2,3]
        let xs1 = [Int]()
        let r0  = listToMaybe(xs0)
        let r1  = listToMaybe(xs1)
        XCTAssertTrue(r0! == 1)
        XCTAssertTrue(r1 == nil)
    }

    //MARK: catMaybes
    func testcatMaybes() {
        let xs: [Int?] = [0, 1, 2, nil, 3, 4, nil, 5]
        let result = catMaybes(xs)
        XCTAssertTrue(result == [0, 1, 2, 3, 4, 5])
    }

    //MARK: mapMaybe
    func testmapMaybe() {
        let xs: [Int] = [0, 1, 2, 3, 4, 5]
        let f = { (x: Int) -> Int? in
            return x % 2 == 0 ? x / 2 : nil
        }
        let result = mapMaybe(f, xs)
        XCTAssertTrue(result == [0, 1, 2])
    }
}