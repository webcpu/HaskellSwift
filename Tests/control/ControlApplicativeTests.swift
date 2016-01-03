import XCTest

@testable import HaskellSwift

class ControlApplicativeTests: XCTestCase {
    //MARK: fst
    func testpure() {
        //let a = 3
     //   XCTAssertTrue(pure(3) == 3)
    }

    //MARK: - Applicative []
    //MARK: <*>
    func testaparray() {
        let add1 = { (x: Int) -> Int in
            return x + 1
        }

        let r0 = [add1] <*> [1]
        XCTAssertTrue(r0 == [2])
    }

    //MARK: *>
    func testdiscardFirstarray() {
        let xs = [1,2,3]
        let ys = [4,5,6]
        let result =  xs *> ys
        XCTAssertTrue(result == ys)
    }

    //MARK: <*
    func testdiscardSecondarray() {
        let xs = [1,2,3]
        let ys = [4,5,6]
        let result =  xs <* ys
        XCTAssertTrue(result == xs)
    }

    //MARK: - Applicative Maybe
    //MARK: <*>
    func testapMaybe() {
        let add1 = { (x: Int) -> Int in
            return x + 1
        }
        
        let f  = Just(add1)
        let a  = Just(2)
        let r0 = f <*> a
        
        XCTAssertTrue(r0 == Just(3))
    }

    //MARK: *>
    func testdiscardFirstMaybe() {
        let x = Optional<Int>.Some(2)
        let y = Optional<Int>.Some(3)
        let result =  x *> y
        XCTAssertTrue(result == y)
    }

    //MARK: <*
    func testdiscardSecondMaybe() {
        let x = Optional<Int>.Some(2)
        let y = Optional<Int>.Some(3)
        let result =  x <* y
        XCTAssertTrue(result == x)
    }

    //MARK: - Applicative Either
    func testapEither() {
        let add1 = { (x: Int) -> Int in
            return x + 1
        }
        
        let f  = Either<String, Int->Int>.Right(add1)
        let a  = Either<String, Int>.Right(2)
        let r0 = f <*> a
        
        XCTAssertTrue(fromRight(r0) == 3)
    }

    //MARK: *>
    func testdiscardFirstEither() {
        let x = Either<String, Int>.Right(2)
        let y = Either<String, String>.Right("batman")
        let result =  x *> y
        XCTAssertTrue(fromRight(result) == fromRight(y))
    }

    //MARK: <*
    func testdiscardSecondEither() {
        let x = Either<String, Int>.Right(2)
        let y = Either<String, String>.Right("batman")
        let result =  x <* y
        XCTAssertTrue(fromRight(result) == fromRight(x))
    }
}