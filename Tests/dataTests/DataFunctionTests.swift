import XCTest

@testable import HaskellSwift

class DataFunctionTests: XCTestCase {
    //MARK: id
    func testid() {
        let a = 3
        XCTAssertTrue(a == id(a))
        //let b = {$0 + 1}
        //XCTAssertTrue(b == id(b))
    }

    //MARK: const 
    func testconst() {
        let f : Int -> Int = const(2)
        XCTAssertTrue(f(3) == 2)
        XCTAssertTrue(const(1, 2) == 1)
    }

    //MARK: flip
    func testflip() {
        let old = { (a: Int, b: Int) -> Int in a - b }
        let new = flip(old)
        XCTAssertTrue(old(3, 1) == new(1, 3))
    }

    //MARK: <<<
    func testdollar() {
        let f       = { $0 + 2}
        let result  = f <<< (3 + 2)
        print(result)
        XCTAssertTrue(result == 7)
    }

    //MARK: Function Composition
    //A->B->C|IntArray()
    func testDotABCIntArray() {
        let process : [Int] -> Int = last .. reverse
        let ints            = [1,2,3,4,5]
        XCTAssertTrue(process(ints) == 1)
    }

    //A->B->C|StringArray"
    func testDotABCStringArray() {
        let process : [String]->String = last .. initx .. reverse
        let words           = ["Very", "Good", "Person"]
        let result          = process(words)
        XCTAssertTrue(result == "Good")
    }

    //A->B->C|String
    func testDotABCString() {
        let fs              = head .. reverse  .. reverse
        let result          = fs("ABC")
        XCTAssertTrue(result == "A")
    }

    //A->B->C?
    func testDotABOptionalC() {
        let f0 : Int -> Int  = { x in x + 1 }
        let f1 : Int -> Int? = { x in x % 2 == 0 ? .Some(x + 1) : nil }
        let fs               = f1 .. f0
        XCTAssertTrue(fs(0) == nil)
        XCTAssertTrue(fs(1) == 3)
    }

    //A->B?->C
    func testDotAOptionalBC() {
        let f0 : Int -> Int? = { x in .Some(x) }
        let f1 : Int? -> Int = { x in x! + 1 }
        let fs               = f1 .. f0
        XCTAssertTrue(fs(1) == 2)
    }

    //A->B?->C?
    func testDotAOptionalBOptionalC() {
        let f0 : Int -> Int?  = { x in .Some(x+1) }
        let f1 : Int? -> Int? = { x in .Some(x! + 1) }
        let fs                = f1 .. f0
        XCTAssertTrue(fs(1) == 3)
    }

    //A?->B->C
    func testDotOptionalABC() {
        let f0 : Int? -> Int = { x in x ?? -1 }
        let f1 : Int -> Int  = { x in x + 1 }
        let fs               = f1 .. f0
        XCTAssertTrue(fs(1) == 2)
        XCTAssertTrue(fs(nil) == 0)
    }

    //A?->B->C?
    func testDotOptionalABOptionalC() {
        let f0 : Int? -> Int = { x in x ?? -1 }
        let f1 : Int -> Int? = { x in .Some(x + 1) }
        let fs               = f1 .. f0
        XCTAssertTrue(fs(1) == 2)
        XCTAssertTrue(fs(nil) == 0)
    }

//    //MARK: on
    func teston() {
        let g = { (b0: Int, b1: Int) -> Int in
            return b0*b1
        }
        let f = { $0 + 1 }
        let h = on(g, f)
        XCTAssertTrue(h(1,2) == 6)
    }

//    //MARK: <|
//    func testfunctorFunction() {
//        let f1 = { $0 + 1 }
//        let f = 2 <| f1
//        let result = f(5)
//        XCTAssertTrue(result == 3)
//    }
//
//    func testfunctorArray() {
//        let xs = [1, 2, 3]
//        let result = 2 <| xs
//        XCTAssertTrue(result == [2, 2, 2])
//    }
//
//    func testfunctorTuple() {
//        let t = ("5", 6)
//        let result = 2 <| t
//        XCTAssertTrue(result.0 == "5" && result.1 == 2)
//    }
//
//    //MARK: |>
//    func testflippedfunctorFunction() {
//        let f1 = { $0 + 1 }
//        let f = f1 |> 2
//        let result = f(5)
//        XCTAssertTrue(result == 3)
//    }
//
//    func testflippedfunctorArray() {
//        let xs = [1, 2, 3]
//        let result = xs |> 2
//        XCTAssertTrue(result == [2, 2, 2])
//    }
//
//    func testflippedfunctorTuple() {
//        let t = ("5", 6)
//        let result = t |> 2
//        XCTAssertTrue(result.0 == "5" && result.1 == 2)
//    }
}