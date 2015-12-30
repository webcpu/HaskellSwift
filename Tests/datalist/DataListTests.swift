import XCTest

@testable import HaskellSwift

//class LogTests: XCTestCase , XCTestCaseProvider {

class DataListTests: XCTestCase {
    //var allTests : [(String, () -> ")] {
    //return [
    //("testError", testError)
    //]
    //}

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

    func testNotBool() {
        XCTAssertTrue(not(true) == false)
        XCTAssertTrue(not(false))
    }

    //++
    func testPlusPlusIntArray() {
        let list1           = [1, 2, 3]
        let list2           = [4, 5, 6]
        let result          = list1 ++ list2
        XCTAssertTrue(result == [1, 2, 3, 4, 5, 6])
    }

    func testPlusPlusStringArray() {
        let list1           = ["Hello"]
        let list2           = ["world", "Haskell!"]
        let result          = list1 ++ list2
        XCTAssertTrue(result == ["Hello", "world", "Haskell!"])
    }

    func testPlusPlusString() {
        let list1           = "Hello"
        let list2           = "world"
        let result          = list1 ++ list2
        XCTAssertTrue(result == "Helloworld")
    }

    func testHeadIntArray() {
        XCTAssertTrue(head([1]) == 1)
        XCTAssertTrue(head([1,2,3]) == 1)
    }

    func testHeadStringArray() {
        let result0 = head(["World"])
        XCTAssertTrue(result0 == "World")
        let result1 = head(files)
        XCTAssertTrue(result1 == "README.md")
    }

    func testHeadString() {
        let result = head("World")
        XCTAssertTrue(result == "W")
        XCTAssertTrue(head("W") == "W")
    }

    func testLastIntArray() {
        let result0 = last([1])
        XCTAssertTrue(result0 == 1)
        let result1 = last([1,2,3])
        XCTAssertTrue(result1 == 3)
    }

    func testLastStringArray() {
        let result0 = last(["World"])
        XCTAssertTrue(result0 == "World")
        XCTAssertTrue(last(files) == files[files.count - 1])
    }

    func testLastString() {
        let result = last("World")
        XCTAssertTrue(result == "d")
        XCTAssertTrue(last("W") == "W")
    }
    //tail
    func testTailIntArray() {
        XCTAssertTrue(tail([1]) == [Int]())
        XCTAssertTrue(tail([1,2,3]) == [2,3])
    }

    func testTailStringArray() {
        XCTAssertTrue(tail(["World"]) == [String]())
        let XCTAssertTrueedFiles = Array(files[1..<(files.count)])
        XCTAssertTrue(tail(files) == XCTAssertTrueedFiles)
    }

    func testTailString() {
        let result = tail("World")
        XCTAssertTrue(result == "orld")
        XCTAssertTrue(tail("W") == "")
    }

    //initx
    func testInitxIntArray() {
        XCTAssertTrue(initx([1]) == [Int]())
        XCTAssertTrue(initx([1,2]) == [1])
    }

    func testInitxStringArray() {
        XCTAssertTrue(initx(["World"]) == [String]())
        XCTAssertTrue(initx(files) == Array(files[0..<(files.count - 1)]))
    }

    func testInitxString() {
        XCTAssertTrue(initx("1") == String())
        XCTAssertTrue(initx("WHO") == "WH")
    }

    //uncons
    func testUncosIntArray() {
        XCTAssertTrue(uncons([Int]()) == nil)
        let t0 = uncons([1])
        XCTAssertTrue(t0!.0 == 1)
        XCTAssertTrue(t0!.1 == [])

        let t1 = uncons([1,2])
        XCTAssertTrue(t1!.0 == 1)
        XCTAssertTrue(t1!.1 == [2])
    }

    func testUncosStringArray() {
        XCTAssertTrue(uncons([String]()) == nil)
        let t0 = uncons(["World"])
        XCTAssertTrue(t0!.0 == "World")
        XCTAssertTrue(t0!.1 == [String]())
    }

    func testUncosString() {
        XCTAssertTrue(uncons(String()) == nil)
        let t0 = uncons("a")
        XCTAssertTrue(t0!.0 == "a")
        XCTAssertTrue(t0!.1 == "")

        let t1 = uncons("ab")
        XCTAssertTrue(t1!.0 == "a")
        XCTAssertTrue(t1!.1 == "b" as String)
    }

    //null
    func testNullIntArray() {
        XCTAssertTrue(null([1]) == false)
        XCTAssertTrue(null([Int]()))
    }

    func testNullStringArray() {
        XCTAssertTrue(null(["World"]) == false)
        XCTAssertTrue(null([String]()))
        XCTAssertTrue(null(files) == false)
    }

    func testNullString() {
        XCTAssertTrue(null("World") == false)
        XCTAssertTrue(null(""))
    }

    //length
    func testLengthIntArray() {
        XCTAssertTrue(length([1]) == 1)
        XCTAssertTrue(length([1,2]) == 2)
    }

    func testLengthStringArray() {
        XCTAssertTrue(length(["World"]) == 1)
        XCTAssertTrue(length(files) == files.count)
    }

    func testLengthString() {
        XCTAssertTrue(length("World") == 5)
        XCTAssertTrue(length("") == 0)
    }

    let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]

    //map
    func testMapStringArray() {
        let uppercaseFiles  = ["README.MD", "HASKELL.SWIFT", "HASKELLTESTS.SWIFT", "HASKELLSWIFT.SWIFT"]

        let toUppercase     = { (x: String) in x.uppercaseString }
        let toUppercases    = { xs in map(toUppercase, xs) }
        let uppercases      = toUppercases(files)
        XCTAssertTrue(uppercases == uppercaseFiles)
    }

    func testMapIntArray1() {
        let countLength     = { (x: String) in x.characters.count }
        let countLengths     = { xs in map(countLength, xs) }
        let lengths         = countLengths(files)
        XCTAssertTrue(lengths == files.map({ (x: String) in x.characters.count }))
    }

    func testMapIntArray2() {
        let countLength     = { (x: String) in x.characters.count }
        let countLengths     = { xs in map(countLength, xs) }
        let lengths         = countLengths(files)
        XCTAssertTrue(lengths == files.map({ (x: String) in x.characters.count }))
    }

    func testMapStringString() {
        let toUppercase     = { (x: Character) in  String(x).capitalizedString.characters.first! }
        let toUppercases    = { xs in map(toUppercase, xs) }
        let uppercaseString = toUppercases("haskell")
        XCTAssertTrue(uppercaseString == "HASKELL")
    }

    func testMapStringUInt32Array() {
        let toUppercase     = { (x: Character) -> UInt32 in
            let scalars = String(x).capitalizedString.unicodeScalars
            return scalars[scalars.startIndex].value
        }
        let toUppercases    = { (xs : String) -> [UInt32] in map(toUppercase, xs) }
        let uppercaseString = toUppercases("haskell")
        XCTAssertTrue(uppercaseString == [72,65,83,75,69,76,76])
    }

    func testMapStringBoolArray() {
        let isUppercase = { (x: Character) -> Bool in return ("A"..."Z").contains(x) }
        let checkUppercases = { (xs: String) -> [Bool] in map(isUppercase, xs) }
        let uppercases = checkUppercases("Haskell")
        XCTAssertTrue(uppercases == [true, false, false, false, false, false, false])
    }

    //reverse
    func testReverseIntArray() {
        XCTAssertTrue(reverse([3]) == [3])
        XCTAssertTrue(reverse([1,2]) == [2,1])
    }

    func testReverseStringArray() {
        let reversedFiles = ["HaskellSwift.swift","HaskellTests.swift","Haskell.swift","README.md"]
        XCTAssertTrue(reverse(["Hello"]) == ["Hello"])
        XCTAssertTrue(reverse(files) == reversedFiles)
    }

    func testReverseString() {
        XCTAssertTrue(reverse("World") == "dlroW")
        XCTAssertTrue(reverse("") == "")
    }

    //intersperse
    func testIntersperseIntArray() {
        XCTAssertTrue(intersperse(1, []) == [])
        XCTAssertTrue(intersperse(1, [3]) == [3])
        XCTAssertTrue(intersperse(10, [1,2,3]) == [1,10,2,10,3])
    }

    func testIntersperseStringArray(){
        let list = ["File", "Edit", "View"]
        XCTAssertTrue(intersperse(".", []) == [])
        XCTAssertTrue(intersperse("+", ["Fine"]) == ["Fine"])
        XCTAssertTrue(intersperse(".", list) == ["File",".","Edit",".","View"])
    }

    func testIntersperseString() {
        XCTAssertTrue(intersperse("+", "") == "")
        XCTAssertTrue(intersperse("+", "A") == "A")
        XCTAssertTrue(intersperse("+", "ABC") == "A+B+C")
    }

    //intercalate
    func testIntercalateStringArray(){
        let list = ["File", "Edit", "View"]
        XCTAssertTrue(intercalate(".", []) == "")
        XCTAssertTrue(intercalate("+", ["Fine"]) == "Fine")
        XCTAssertTrue(intercalate(".", list) == "File.Edit.View")
    }

    //transpose
    func testTransposeIntArray() {
        XCTAssertTrue(transpose([[1,2,3],[4,5,6],[7,8,9]]) == [[1,4,7],[2,5,8],[3,6,9]])
        XCTAssertTrue(transpose([[1],[4,5],[7,8,9]]) == [[1,4,7],[5,8],[9]])
    }

    func testTransposeStringArray(){
        let list = ["ABCD","abcd"]
        XCTAssertTrue(transpose(list) == ["Aa","Bb","Cc","Dd"])
    }

    //subsequences
    func testsubsequenceIntArray() {
        var emptySequence = [[Int]]()
        emptySequence.append([Int]())
        XCTAssertTrue(subsequences([Int]()) == emptySequence)

        XCTAssertTrue(subsequences([1,2,3]) == [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]])
    }

    func testSubsequenceStringArray(){
        var emptySequence = [[String]]()
        emptySequence.append([String]())
        XCTAssertTrue(subsequences([String]()) == emptySequence)

        let list = ["ABCD","abcd"]
        XCTAssertTrue(subsequences(list) == [[],["ABCD"],["abcd"],["ABCD","abcd"]])
    }

    func testSubsequenceString() {
        var emptySequence = [String]()
        emptySequence.append(String())
        XCTAssertTrue(subsequences(String()) == emptySequence)

        let list         = "ABCD"
        let XCTAssertTrueedList = ["","A","B","AB","C","AC","BC","ABC","D","AD","BD","ABD","CD","ACD","BCD","ABCD"]
        XCTAssertTrue(subsequences(list) == XCTAssertTrueedList)
    }

    //permutations
    func testPermutationIntArray() {
        var emptySequence = [[Int]]()
        emptySequence.append([Int]())
        XCTAssertTrue(permutations([Int]()) == emptySequence)

        XCTAssertTrue(permutations([1,2,3]) == [[1,2,3], [2,1,3], [2,3,1], [1,3,2], [3,1,2], [3,2,1]])
    }

    func testPermutationStringArray(){
        var emptySequence = [[String]]()
        emptySequence.append([String]())
        XCTAssertTrue(permutations([String]()) == emptySequence)

        let list = ["IT", "IS", "BAD"]
        XCTAssertTrue(permutations(list) == [["IT","IS","BAD"], ["IS","IT","BAD"], ["IS","BAD","IT"], ["IT","BAD","IS"], ["BAD","IT","IS"], ["BAD","IS","IT"]])
    }

    func testPermutationString() {
        XCTAssertTrue(permutations(String()) == [""])
        XCTAssertTrue(permutations("abc") == ["abc", "bac", "bca", "acb", "cab", "cba"])
    }

    //foldl
    func testFoldlIntArray() {
        let adds        = { (x: Int,y: Int) in x+y }
        let result      = foldl(adds, 0, [1, 2, 3])
        let XCTAssertTrueed    = 6
        XCTAssertTrue(result == XCTAssertTrueed)
        let product = {(x: Int, y: Int) in x*y}
        XCTAssertTrue(foldl(product, 1, [1,2,3,4,5]) == 120)
    }

    func testFoldlStringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds = { (x: String, y: String) in x + y }
        let result = foldl(adds, "", letters)
        XCTAssertTrue(result == "World")
    }

    func testFoldlString() {
        let insert = { (x: String, y: Character) in String(y) + x }
        XCTAssertTrue(foldl(insert, "", "World") == "dlroW")
    }
    //foldl1
    func testFoldl1IntArray() {
        let adds     = { (x: Int,y: Int) in x+y }
        XCTAssertTrue(foldl1(adds, [1, 2, 3]) == 6)

        let product = {(x: Int, y: Int) in x*y}
        XCTAssertTrue(foldl1(product, [1,2,3,4,5]) == 120)
    }

    func testFoldl1StringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds = { (x: String, y: String) in x + y }
        let result = foldl1(adds, letters)
        XCTAssertTrue(result == "World")
    }

    func testFoldl1String() {
        let insert = { (x: String, y: Character) in String(y) + x }
        XCTAssertTrue(foldl1(insert, "World") == "dlroW")
    }

    //foldr
    func testFoldrIntArray() {
        let adds     = { (a: Int,b: Int) in a+b }
        XCTAssertTrue(foldr(adds, 0, [1, 2, 3]) == 6)

        let multiply = {(a: Int, b: Int) in a*b}
        XCTAssertTrue(foldr(multiply, 1, [1,2,3,4,5]) == 120)
    }

    func testFoldrStringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds = { (a: String, b: String) in b + a }
        let result = foldr(adds, "", letters)
        XCTAssertTrue(result == "dlroW")
    }

    func testFoldrString() {
        let insert = { (a: Character, b: String) in String(a) + b }
        XCTAssertTrue(foldr(insert, "", "World") == "World")
    }

    //foldr1
    func testFoldr1IntArray() {
        let adds     = { (a: Int,b: Int) in a+b }
        XCTAssertTrue(foldr1(adds, [1, 2, 3]) == 6)

        let multiply = {(a: Int, b: Int) in a*b}
        XCTAssertTrue(foldr1(multiply, [1,2,3,4,5]) == 120)
    }

    func testFoldr1StringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds = { (a: String, b: String) in b + a }
        let result = foldr1(adds, letters)
        XCTAssertTrue(result == "dlroW")
    }

    func testFoldr1String() {
        let insert = { (a: Character, b: String) in String(a) + b }
        XCTAssertTrue(foldr1(insert, "World") == "World")
    }

    //        //reduce() {
    //            func testIntArray() {
    //                let adds             = { (initial: String, x: Int) -> String in initial + String(x) }
    //                let result          = reduce(adds, "", [1,2,3,4])
    //                XCTAssertTrue(result == "1234")
    //            }
    //
    //            func testStringArray 1() {
    //                let adds             = { (initial: String, x: String) -> String in initial + x }
    //                let concat          = { xs in reduce(adds, "", xs) }
    //                let result          = concat(["Hello", "World", "!"])
    //                XCTAssertTrue(result == "HelloWorld!")
    //            }
    //
    //            func testStringArray 2() {
    //                let adds             = { (initial: String, x: String) -> String in initial + x }
    //                let concat          = { (xs : [String]) in reduce(adds, "", xs) }
    //                let result          = concat(["C", "a", "t", "!"] )
    //                XCTAssertTrue(result == "Cat!")
    //            }
    //
    //            func testString() {
    //                let adds             = { (initial: String, x: Character) -> String in initial + String(x) }
    //                let xs : [Character] = ["C", "a", "t", "!"]
    //                let result           = reduce(adds, "", xs)
    //                XCTAssertTrue(result == "Cat!")
    //            }
    //        }

    //concat
    func testConcatIntArraysArray() {
        var ints = [[1, 2, 3], [4, 5, 6]]
        XCTAssertTrue(concat(ints) == [1, 2, 3, 4, 5, 6])
        ints = [[Int]]()
        XCTAssertTrue(concat(ints) == [[Int]]())
    }

    func testConcatStringArraysArray() {
        let strings = [["a", "b", "c"], ["d", "e", "f"]]
        XCTAssertTrue(concat(strings) == ["a", "b", "c", "d", "e", "f"])
    }

    func testConcatStringArrays() {
        let strings = ["Hello", "World"]
        XCTAssertTrue(concat(strings) == "HelloWorld")
        let emptyString = [String]()
        XCTAssertTrue(concat(emptyString) == String())
    }

    func testConcatCharacterArray() {
        let strings = ["H", "e", "l", "l", "o"]
        XCTAssertTrue(concat(strings) == "Hello")
        let emptyString = [Character]()
        XCTAssertTrue(concat(emptyString) == String())
    }

    //concatMap
    func testconcatMapIntArraysArray() {
        let ints = [1, 2]
        XCTAssertTrue(concatMap({x in [x, x*x]}, ints) == [1, 1, 2, 4])
    }

    func testconcatMapStringArraysArray() {
        let strings = ["a", "b"]
        XCTAssertTrue(concatMap( {x in [x + "0", x + "1", x + "2"]}, strings) == ["a0", "a1", "a2", "b0", "b1", "b2"])
    }

    func testconcatMapStringArrays() {
        let strings = ["Hello", "World"]
        let f       = { (s: String) in  [s.uppercaseString, "1"] }
        let r0      = concatMap(f, strings)
        XCTAssertTrue(r0 == ["HELLO", "1", "WORLD", "1"])

        let emptyString = [String]()
        XCTAssertTrue(concat(emptyString) == String())
    }

    func testconcatMapCharacterArray() {
        let chars : [Character] = ["H", "e", "l", "l", "o"]
        let f       = { (x: Character) in String(x) + "1" }
        let r0      = concatMap(f, chars)
        XCTAssertTrue(r0 == "H1e1l1l1o1")

        let emptyString = [Character]()
        XCTAssertTrue(concat(emptyString) == String())
    }

    //and
    func testandBoolArray() {
        XCTAssertTrue(and([false, false]) == false)
        XCTAssertTrue(and([true, false]) == false)
        XCTAssertTrue(and([true, true]))
        XCTAssertTrue(and([false, true]) == false)
    }

    //or
    func testorBoolArray() {
        XCTAssertTrue(or([true,true]))
        XCTAssertTrue(or([false,true]))
        XCTAssertFalse(or([false,false]))
        XCTAssertTrue(or([true, false]))
    }

    //any
    func testanyIntArray() {
        let ints = [1,3,7]
        XCTAssertTrue(any({ x in x < 10}, ints))
        XCTAssertFalse(any({ x in x > 10}, ints))
    }

    func testanyStringArray() {
        let words = ["Hello", "World"]
        XCTAssertTrue(any({ x in head(x) == "H"}, words))
        XCTAssertFalse(any({ x in last(x) == "t"}, words))
    }

    func testanyString() {
        let word = "Hello"
        XCTAssertTrue(any({ x in x == "H"}, word))
        XCTAssertFalse(any({ x in x == "t"}, word))
    }

    //all
    func testallIntArray() {
        let ints = [1,3,7]
        XCTAssertTrue(all({ x in x < 10}, ints))
        XCTAssertFalse(all({ x in x > 10}, ints))
        XCTAssertTrue(all({ x in x > 10}, [Int]()))
    }

    func testallStringArray() {
        let words = ["Hello", "World"]
        XCTAssertTrue(all({ x in head(x) < "z"}, words))
        XCTAssertFalse(all({ x in last(x) < "a"}, words))
        XCTAssertTrue(all({ x in last(x) < "a"}, [String]()))
    }

    func testallString() {
        let word = "Hello"
        XCTAssertTrue(all({ x in x < "z"}, word))
        XCTAssertFalse(all({ x in x == "t"}, word))
        XCTAssertTrue(all({ x in x == "t"}, ""))
    }

    //sum
    func testsumCGFloatArray() {
        let list : [CGFloat] = [1.0, 2.0, 3.0]
        let result = sum(list)
        XCTAssertEqualWithAccuracy(result, 6.0, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(sum([CGFloat]()), 0.0, accuracy: 0.00001)
    }

    func testsumDoubleArray() {
        let list : [Double] = [1.1, 2.2, 3.3]
        let result          = sum(list)
        XCTAssertEqualWithAccuracy(result, 6.6, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(sum([Double]()), 0.0, accuracy: 0.00001)
    }

    func testsumFloatArray() {
        let list : [Float]  = [1.1, 2.2, 3.3]
        let result          = sum(list)
        XCTAssertEqualWithAccuracy(result, Float(6.6), accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(sum([Float]()), 0.0, accuracy: 0.00001)
    }

    func testsumIntArray() {
        let list : [Int]    = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == Int(6))
        XCTAssertTrue(sum([Int]()) == 0)
    }

    func testsumInt16Array() {
        let list : [Int16]  = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == Int16(6))
        XCTAssertTrue(sum([Int16]()) == 0)
    }

    func testsumInt32Array() {
        let list : [Int32]  = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == Int32(6))
        XCTAssertTrue(sum([Int32]()) == 0)
    }

    func testsumInt64Array() {
        let list : [Int64]  = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == Int64(6))
        XCTAssertTrue(sum([Int64]()) == 0)
    }

    func testsumInt8Array() {
        let list : [Int8]   = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == Int8(6))
        XCTAssertTrue(sum([Int8]()) == 0)
    }

    func testsumUIntArray() {
        let list : [UInt]   = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == UInt(6))
        XCTAssertTrue(sum([UInt]()) == 0)
    }

    func testsumUInt16Array() {
        let list : [UInt16] = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == UInt16(6))
        XCTAssertTrue(sum([UInt16]()) == 0)
    }

    func testsumUInt32Array() {
        let list : [UInt32] = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == UInt32(6))
        XCTAssertTrue(sum([UInt32]()) == 0)
    }

    func testsumUInt64Array() {
        let list : [UInt64] = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == UInt64(6))
        XCTAssertTrue(sum([UInt64]()) == 0)
    }

    func testsumUInt8Array() {
        let list : [UInt8]  = [1, 2, 3]
        let result          = sum(list)
        XCTAssertTrue(result == UInt8(6))
        XCTAssertTrue(sum([UInt8]()) == 0)
    }

    //product
    func testproductCGFloatArray() {
        let list : [CGFloat] = [1.0, 2.0, 3.0]
        let result = product(list)
        XCTAssertEqualWithAccuracy(result, 6.0, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(product([CGFloat]()), 1.0, accuracy: 0.00001)
    }

    func testproductDoubleArray() {
        let list : [Double] = [1.1, 2.2, 3.3]
        let result          = product(list)
        XCTAssertEqualWithAccuracy(result, 7.986000000000001, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(product([Double]()), 1.0, accuracy: 0.00001)
    }

    func testproductFloatArray() {
        let list : [Float]  = [1.1, 2.2, 3.3]
        let result          = product(list)
        XCTAssertEqualWithAccuracy(result, Float(7.986000000000001), accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(product([Float]()), 1.0, accuracy: 0.00001)
    }

    func testproductIntArray() {
        let list : [Int]    = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == Int(24))
        XCTAssertTrue(product([Int]()) == 1)
    }

    func testproductInt16Array() {
        let list : [Int16]  = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == Int16(24))
        XCTAssertTrue(product([Int16]()) == 1)
    }

    func testproductInt32Array() {
        let list : [Int32]  = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == Int32(24))
        XCTAssertTrue(product([Int32]()) == 1)
    }

    func testproductInt64Array() {
        let list : [Int64]  = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == Int64(24))
        XCTAssertTrue(product([Int64]()) == 1)
    }

    func testproductInt8Array() {
        let list : [Int8]   = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == Int8(24))
        XCTAssertTrue(product([Int8]()) == 1)
    }

    func testproductUIntArray() {
        let list : [UInt]   = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == UInt(24))
        XCTAssertTrue(product([UInt]()) == 1)
    }

    func testproductUInt16Array() {
        let list : [UInt16] = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == UInt16(24))
        XCTAssertTrue(product([UInt16]()) == 1)
    }

    func testUproductInt32Array() {
        let list : [UInt32] = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == UInt32(24))
        XCTAssertTrue(product([UInt32]()) == 1)
    }

    func testproductUInt64Array() {
        let list : [UInt64] = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == UInt64(24))
        XCTAssertTrue(product([UInt64]()) == 1)
    }

    func testproductUInt8Array() {
        let list : [UInt8]  = [1, 2, 3, 4]
        let result          = product(list)
        XCTAssertTrue(result == UInt8(24))
        XCTAssertTrue(product([UInt8]()) == 1)
    }

    //maximum
    func testmaximumCGFloatArray() {
        let list : [CGFloat] = [1.0, 2.0, 3.0]
        let result           = maximum(list)
        XCTAssertEqualWithAccuracy(result, 3.0, accuracy: 0.00001)
    }

    func testmaximumDoubleArray() {
        let list : [Double] = [1.1, 2.2, 3.3]
        let result          = maximum(list)
        XCTAssertEqualWithAccuracy(result, 3.3, accuracy: 0.00001)
    }

    func testmaximumFloatArray() {
        let list : [Float]  = [1.1, 2.2, 3.3]
        let result          = maximum(list)
        XCTAssertEqualWithAccuracy(result, 3.3, accuracy: 0.00001)
    }

    func testmaximumIntArray() {
        let list : [Int]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumInt16Array() {
        let list : [Int16]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumInt32Array() {
        let list : [Int32]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumInt64Array() {
        let list : [Int64]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumInt8Array() {
        let list : [Int8]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumUIntArray() {
        let list : [UInt]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumUInt16Array() {
        let list : [UInt16]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumUInt32Array() {
        let list : [UInt32]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumUInt64Array() {
        let list : [UInt64]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    func testmaximumUInt8Array() {
        let list : [UInt8]    = [1, 2, 3]
        let result          = maximum(list)
        XCTAssertTrue(result == 3)
    }

    //minimum
    func testminimumCGFloatArray() {
        let list : [CGFloat] = [4.4, 2.2, 3.3]
        let result           = minimum(list)
        XCTAssertEqualWithAccuracy(result, 2.2, accuracy: 0.00001)
    }

    func testminimumDoubleArray() {
        let list : [Double] = [4.4, 2.2, 3.3]
        let result          = minimum(list)
        XCTAssertEqualWithAccuracy(result, 2.2, accuracy: 0.00001)
    }

    func testminimumFloatArray() {
        let list : [Float]  = [4.4, 2.2, 3.3]
        let result          = minimum(list)
        XCTAssertEqualWithAccuracy(result, 2.2, accuracy: 0.00001)
    }

    func testminimumIntArray() {
        let list : [Int]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumInt16Array() {
        let list : [Int16]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumInt32Array() {
        let list : [Int32]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testInt64Array() {
        let list : [Int64]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumInt8Array() {
        let list : [Int8]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumUIntArray() {
        let list : [UInt]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumUInt16Array() {
        let list : [UInt16]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumUInt32Array() {
        let list : [UInt32]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumUInt64Array() {
        let list : [UInt64]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    func testminimumUInt8Array() {
        let list : [UInt8]    = [5, 2, 3]
        let result          = minimum(list)
        XCTAssertTrue(result == 2)
    }

    //scanl
    func testscanlIntArray() {
        let adds     = { (x: Int,y: Int) in x+y }
        XCTAssertTrue(scanl(adds, 0, [1, 2, 3]) == [1, 3, 6])

        let product = {(x: Int, y: Int) in x*y}
        XCTAssertTrue(scanl(product, 1, [1,2,3,4,5]) == [1, 2, 6, 24, 120])
    }

    func testscanlStringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds    = { (x: String, y: String) in x + y }
        let result  = scanl(adds, "", letters)
        XCTAssertTrue(result == ["W", "Wo", "Wor", "Worl", "World"])
    }

    func testscanlString() {
        let insert = { (x: String, y: Character) in String(y) + x }
        XCTAssertTrue(scanl(insert, "", "World") == ["W", "oW", "roW", "lroW", "dlroW"])
    }

    //scanl1
    func testscanl1IntArray() {
        let adds     = { (x: Int,y: Int) -> Int in x+y }
        XCTAssertTrue(scanl1(adds, [1, 2, 3]) == [1, 3, 6])

        let product = {(x: Int, y: Int) -> Int in x*y}
        XCTAssertTrue(scanl1(product, [1,2,3,4,5]) == [1, 2, 6, 24, 120])
    }

    func testscanl1StringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds    = { (x: String, y: String) in x + y }
        let result  = scanl1(adds, letters)
        XCTAssertTrue(result == ["W", "Wo", "Wor", "Worl", "World"])
    }

    func testscanl1String() {
        let insert = { (x: String, y: Character) in String(y) + x }
        XCTAssertTrue(scanl1(insert, "World") == ["W", "oW", "roW", "lroW", "dlroW"])
    }

    //scanr
    func testscanrIntArray() {
        let adds     = { (x: Int,y: Int) in x+y }
        XCTAssertTrue(scanr(adds, 0, [1, 2, 3]) == [3, 5, 6])

        let product = {(x: Int, y: Int) in x*y}
        XCTAssertTrue(scanr(product, 1, [1,2,3,4,5]) == [5, 20, 60, 120, 120])
    }

    func testscanrStringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds    = { (x: String, y: String) in x + y }
        let result  = scanr(adds, "", letters)
        XCTAssertTrue(result == ["d", "ld", "rld", "orld", "World"])
    }

    func testscanrString() {
        let insert = { (x: Character, y: String) in String(x) + y }
        XCTAssertTrue(scanr(insert, "", "World") == ["d", "ld", "rld", "orld", "World"])
    }

    //scanr1
    func testscanr1IntArray() {
        let adds     = { (x: Int,y: Int) in x+y }
        XCTAssertTrue(scanr1(adds, [1, 2, 3]) == [3, 5, 6])

        let product = {(x: Int, y: Int) in x*y}
        XCTAssertTrue(scanr1(product, [1,2,3,4,5]) == [5, 20, 60, 120, 120])
    }

    func testscanr1StringArray() {
        let letters : [String] = ["W", "o", "r", "l", "d"]
        let adds    = { (x: String, y: String) in x + y }
        let result  = scanr1(adds, letters)
        XCTAssertTrue(result == ["d", "ld", "rld", "orld", "World"])
    }

    func testscanr1String() {
        //Very tricky
        //let insert = { (x: Character, y: String) in String(x) + y } //Wrong
        let insert = { (x: Character, y: String) -> String in String(x) + y } //Correct
        XCTAssertTrue(scanr1(insert, "World") == ["d", "ld", "rld", "orld", "World"])
    }

    //replicate
    func testreplicateIntArray() {
        let ints = replicate(100, 123)
        XCTAssertTrue(filter( { x in x == 123 }, ints).count == 100)
    }

    func testreplicateStringArray() {
        let strings = replicate(100, "Good")
        XCTAssertTrue(filter( { x in x == "Good" }, strings).count == 100)
    }

    //unfoldr
    func testunfoldrIntArray() {
        let ints = unfoldr({ (b: Int) -> (Int, Int)? in
            if b < 1 {
                return nil
            } else {
                return (b, b - 1)
            }
            }, 10)
        XCTAssertTrue(ints == [10,9,8,7,6,5,4,3,2,1])
    }

    func testunfoldrStringArray() {
        let strings = unfoldr({(b: String) -> (String, String)? in
            if length(b) == 0 {
                return nil
            } else {
                return (b, tail(b))
            }
            }, "Good")
        XCTAssertTrue(strings == ["Good", "ood", "od", "d"])
    }

    func testString() {
        var i = 0
        let string = unfoldr({(b: Character) -> (String, Character)? in
            i += 1
            if i > 4 {
                return nil
            } else {
                return (String(b), b)
            }
            }, "A")
        XCTAssertTrue(string == ["A", "A", "A", "A"])
    }
    //let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]

    //take() {
    func testtakeIntArray() {
        let ints = [1, 2, 3]
        XCTAssertTrue(take(0, ints) == [Int]())
        XCTAssertTrue(take(0, [Int]()) == [Int]())
        XCTAssertTrue(take(1, ints) == [1])
        XCTAssertTrue(take(5, ints) == ints)
    }

    func testtakeStringArray() {
        XCTAssertTrue(take(0, files) == [String]())
        XCTAssertTrue(take(0, [String]()) == [String]())
        XCTAssertTrue(take(1, files) == [files[0]])
        XCTAssertTrue(take(10, files) == files)
    }

    func testtakeString() {
        let str = "World"
        XCTAssertTrue(take(0, files) == [String]())
        XCTAssertTrue(take(0, [String]()) == [String]())
        XCTAssertTrue(take(1, str) == "W")
        XCTAssertTrue(take(3, str) == "Wor")
        XCTAssertTrue(take(10, str) == str)
    }

    //drop() {
    func testdropIntArray() {
        let ints = [1, 2, 3]
        XCTAssertTrue(drop(0, ints) == ints)
        XCTAssertTrue(drop(0, [Int]()) == [Int]())
        XCTAssertTrue(drop(1, ints) == [2, 3])
        XCTAssertTrue(drop(10, ints) == [Int]())
    }

    func testdropStringArray() {
        XCTAssertTrue(drop(0, files) == files)
        XCTAssertTrue(drop(0, [String]()) == [String]())
        let XCTAssertTrueedResult = Array(files[1..<(files.count)])
        XCTAssertTrue(drop(1, files) == XCTAssertTrueedResult)
        XCTAssertTrue(drop(files.count + 1, files) == [String]())
    }

    func testdropString() {
        XCTAssertTrue(drop(0, "Hello World") == "Hello World")
        XCTAssertTrue(drop(0, [String]()) == [String]())
        XCTAssertTrue(drop(1, "World") == "orld")
        XCTAssertTrue(drop(10, "World") == "")
    }

    //splitAt() {
    func testsplitAtIntArray() {
        let ints = [1, 2, 3]
        let (list1, list2) = splitAt(2, ints)
        XCTAssertTrue(list1 == [1, 2])
        XCTAssertTrue(list2 == [3])
    }

    func testsplitAtStringArray() {
        let list = ["Is", "it", "OK"]
        let (list1, list2) = splitAt(2, list)
        XCTAssertTrue(list1 == ["Is", "it"])
        XCTAssertTrue(list2 == ["OK"])
    }

    func testsplitAtString() {
        let list = "Hello World"
        let (list1, list2) = splitAt(5, list)
        XCTAssertTrue(list1 == "Hello")
        XCTAssertTrue(list2 == " World")
    }

    //takeWhile() {
    func testtakeWhileIntArray() {
        let ints = [1, 2, 3]
        let result = takeWhile( { $0 > 2} , ints)
        XCTAssertTrue(result == [Int]())
    }

    func testtakeWhileStringArray() {
        let list = ["Is", "it", "OK"]
        let result = takeWhile({ x in head(x) == "I"}, list)
        XCTAssertTrue(result == ["Is"])
    }

    func testtakeWhileString() {
        let list = "Hello World"
        let result = takeWhile({ x in x < "Z"}, list)
        XCTAssertTrue(result == "H")
    }

    //dropWhile() {
    func testdropWhileIntArray() {
        let ints = [1, 2, 3]
        let result = dropWhile( { $0 < 3} , ints)
        XCTAssertTrue(result == [3])
    }

    func testdropWhileStringArray() {
        let list = ["Is", "it", "OK"]
        let result = dropWhile({ x in head(x) == "I" || head(x) == "i" }, list)
        XCTAssertTrue(result == ["OK"])
    }

    func testdropWhileString() {
        let list = "Hello World"
        let result = dropWhile({ x in x < "Z"}, list)
        XCTAssertTrue(result == "ello World")
    }

    //span() {
    func testspanIntArray() {
        let ints            = [1, 2, 3]
        let (list1, list2)  = span( { $0 < 2} , ints)
        XCTAssertTrue(list1 == [1])
        XCTAssertTrue(list2 == [2, 3])
    }

    func testspanStringArray() {
        let list    = ["Is", "it", "OK"]
        let (list1, list2)  = span({ x in head(x) == "I" || head(x) == "i" }, list)
        XCTAssertTrue(list1 == ["Is", "it"])
        XCTAssertTrue(list2 == ["OK"])
    }

    func testspanString() {
        let list = "Hello World"
        let (list1, list2) = span({ x in x < "Z"}, list)
        XCTAssertTrue(list1 == "H")
        XCTAssertTrue(list2 == "ello World")
    }

    //breakx() {
    func testbreakxIntArray() {
        let ints            = [1, 2, 3]
        let (list1, list2)  = breakx( { $0 > 2} , ints)
        XCTAssertTrue(list1 == [1, 2])
        XCTAssertTrue(list2 == [3])
    }

    func testbreakxStringArray() {
        let list    = ["Is", "it", "OK"]
        let (list1, list2)  = breakx({ x in head(x) == "i" }, list)
        XCTAssertTrue(list1 == ["Is"])
        XCTAssertTrue(list2 == ["it", "OK"])
    }

    func testbreakxString() {
        let list = "Hello World"
        let (list1, list2) = breakx({ x in x == " " }, list)
        XCTAssertTrue(list1 == "Hello")
        XCTAssertTrue(list2 == " World")
    }

    //stripPrefix() {
    func teststripPrefixIntArray() {
        let list1           = [1, 1]
        let list2           = [1, 1, 2, 3, 3, 5, 5]
        XCTAssertTrue(stripPrefix([9,1], list2) == nil)
        let r1              = stripPrefix(list1, list2)
        XCTAssertTrue( r1 != nil && r1! == [2, 3, 3, 5, 5])
    }

    func teststripPrefixStringArray() {
        let list1           = ["foo"]
        let list2           = ["foo", "bar"]
        XCTAssertTrue(stripPrefix(["bar"], list2) == nil)
        let r1 = stripPrefix(list1, list2)
        XCTAssertTrue(r1 != nil && r1! == ["bar"])
    }

    func teststripPrefixString() {
        let list1           = "foo"
        let list2           = "foobar"
        XCTAssertTrue(stripPrefix("bar", list2) == nil)
        XCTAssertTrue(stripPrefix(list1, list2) == "bar")
    }

    //group() {
    func testgroupIntArray() {
        let ints            = [1, 1, 2, 3, 3, 5, 5]
        let result          = group(ints)
        XCTAssertTrue(result == [[1,1],[2],[3,3],[5,5]])
    }

    func testgroupStringArray() {
        let list    = ["Apple", "Pie", "Pie"]
        let result  = group(list)
        XCTAssertTrue(result == [["Apple"], ["Pie", "Pie"]])
    }

    func testgroupString() {
        let list = "Hello World"
        let result = group(list)
        XCTAssertTrue(result == ["H","e","ll","o"," ","W","o","r","l","d"])
    }

    //inits() {
    func testinitsIntArray() {
        let ints            = [1, 1, 2, 3, 3, 5, 5]
        let result          = inits(ints)
        XCTAssertTrue(result == [[],[1],[1,1],[1,1,2],[1,1,2,3],[1,1,2,3,3],[1,1,2,3,3,5],[1,1,2,3,3,5,5]])
    }

    func testinitsStringArray() {
        let list    = ["Apple", "Pie", "Pie"]
        let result  = inits(list)
        XCTAssertTrue(result == [[],["Apple"],["Apple","Pie"],["Apple","Pie","Pie"]])
    }

    func testinitsString() {
        let list = "Hello World"
        let result = inits(list)
        XCTAssertTrue(result == ["","H","He","Hel","Hell","Hello","Hello ","Hello W","Hello Wo","Hello Wor","Hello Worl","Hello World"])
    }

    //tails() {
    func testtailsIntArray() {
        let ints            = [1, 1, 2, 3, 3, 5, 5]
        let result          = tails(ints)
        XCTAssertTrue(result == [[1,1,2,3,3,5,5],[1,2,3,3,5,5],[2,3,3,5,5],[3,3,5,5],[3,5,5],[5,5],[5],[]])
    }

    func testtailsStringArray() {
        let list    = ["Apple", "Pie", "Pie"]
        let result  = tails(list)
        XCTAssertTrue(result == [["Apple","Pie","Pie"],["Pie","Pie"],["Pie"],[]])
    }

    func testtailsString() {
        let list = "Hello World"
        let result = tails(list)
        XCTAssertTrue(result == ["Hello World","ello World","llo World","lo World","o World"," World","World","orld","rld","ld","d",""])
    }
    //let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]

    //isPrefixOf() {
    func testisPrefixOfIntArray() {
        let list1            = [1, 1, 2]
        let list2            = [1, 1, 2, 3, 3, 5, 5]
        let list3            = [1, 5]
        XCTAssertTrue(isPrefixOf(list1, list2))
        XCTAssertFalse(isPrefixOf(list1, list3))
    }

    func testisPrefixOfStringArray() {
        let list1            = ["Hello"]
        let list2            = ["Hello", "World"]
        let list3            = ["World", "Hello"]
        XCTAssertTrue(isPrefixOf(list1, list2))
        XCTAssertFalse(isPrefixOf(list1, list3))
    }

    func testisPrefixOfString() {
        let list1            = "Hello"
        let list2            = "Hello World"
        let list3            = "World"
        XCTAssertTrue(isPrefixOf(list1, list2))
        XCTAssertFalse(isPrefixOf(list1, list3))
    }

    //isSuffixOf() {
    func testisSuffixOfIntArray() {
        let list1            = [3, 5, 5]
        let list2            = [1, 1, 2, 3, 3, 5, 5]
        let list3            = [1, 5]
        XCTAssertTrue(isSuffixOf(list1, list2))
        XCTAssertFalse(isSuffixOf(list1, list3))
    }

    func testisSuffixOfStringArray() {
        let list1            = ["Hello"]
        let list2            = ["World", "Hello"]
        let list3            = ["Hello", "World"]
        XCTAssertTrue(isSuffixOf(list1, list2))
        XCTAssertFalse(isSuffixOf(list1, list3))
    }

    func testisSuffixOfString() {
        let list1            = "World"
        let list2            = "Hello World"
        let list3            = "Hello"
        XCTAssertTrue(isSuffixOf(list1, list2))
        XCTAssertFalse(isSuffixOf(list1, list3))
    }

    //isInfixOf() {
    func testisInfixOfIntArray() {
        let list1            = [2, 3, 3]
        let list2            = [1, 1, 2, 3, 3, 5, 5]
        let list3            = [1, 5]
        XCTAssertTrue(isInfixOf(list1, list2))
        XCTAssertFalse(isInfixOf(list1, list3))
    }

    func testisInfixOfStringArray() {
        let list1            = ["Hello"]
        let list2            = ["World", "Hello"]
        let list3            = ["Hello", "World"]
        let list4            = ["Hello!", "World"]
        XCTAssertTrue(isInfixOf(list1, list2))
        XCTAssertTrue(isInfixOf(list1, list3))
        XCTAssertFalse(isInfixOf(list1, list4))
    }

    func testisInfixOfString() {
        let list1            = "World"
        let list2            = "Hello World!"
        let list3            = "Hello"
        XCTAssertTrue(isInfixOf(list1, list2))
        XCTAssertFalse(isInfixOf(list1, list3))
    }

    //isSubsequenceOf() {
    func testisSubsequenceOfIntArray() {
        let list1            = [2, 3, 3]
        let list2            = [1, 1, 2, 3, 3, 5, 5]
        let list3            = [1, 5]
        XCTAssertTrue(isSubsequenceOf(list1, list2))
        XCTAssertFalse(isSubsequenceOf(list1, list3))
        XCTAssertTrue(isSubsequenceOf(list1, list1))
    }

    func testisSubsequenceOfStringArray() {
        let list1            = ["Hello"]
        let list2            = ["World", "Hello"]
        let list3            = ["Hello", "World"]
        let list4            = ["Hello!", "World"]
        XCTAssertTrue(isSubsequenceOf(list1, list2))
        XCTAssertTrue(isSubsequenceOf(list1, list3))
        XCTAssertFalse(isSubsequenceOf(list1, list4))
        XCTAssertTrue(isSubsequenceOf(list1, list1))
    }

    func testisSubsequenceOfString() {
        let list1            = "World"
        let list2            = "Hello World!"
        let list3            = "Hello"
        XCTAssertTrue(isSubsequenceOf(list1, list2))
        XCTAssertFalse(isSubsequenceOf(list1, list3))
        XCTAssertTrue(isSubsequenceOf(list1, list1))
    }

    //elem() {
    func testelemIntArray() {
        let list            = [2, 3, 3]
        XCTAssertTrue(elem(3, list))
        XCTAssertFalse(elem(5, list))
    }

    func testelemStringArray() {
        let list            = ["World", "Hello"]
        XCTAssertTrue(elem("Hello", list))
        XCTAssertFalse(elem("Good", list))
    }

    func testelemString() {
        let list            = "Hello"
        XCTAssertTrue(elem("H", list))
        XCTAssertFalse(elem("T", list))
    }

    //notElem() {
    func testnotElemIntArray() {
        let list            = [2, 3, 3]
        XCTAssertFalse(notElem(3, list))
        XCTAssertTrue(notElem(5, list))
    }

    func testnotElemStringArray() {
        let list            = ["World", "Hello"]
        XCTAssertFalse(notElem("Hello", list))
        XCTAssertTrue(notElem("Good", list))
    }

    func testnotElemString() {
        let list            = "Hello"
        XCTAssertFalse(notElem("H", list))
        XCTAssertTrue(notElem("T", list))
    }

    //lookup() {
    func testlookupIntArray() {
        let list            = ["a": 0, "b": 1]
        XCTAssertTrue(lookup("a", list) == 0)
        XCTAssertTrue(lookup("c", list) == nil)
    }

    func testlookupStringArray() {
        let list            = ["firstname": "tom", "lastname": "sawyer"]
        XCTAssertTrue(lookup("firstname", list) == "tom")
        XCTAssertTrue(lookup("middlename", list) == nil)
    }

    //find() {
    func testfindIntArray() {
        let list             = [1, 2, 3, 4, 5]
        let greaterThanThree = { x in x > 3 }
        let result           = find(greaterThanThree, list)
        XCTAssertTrue(result == 4)
    }

    func testfindStringArray() {
        let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
        let swiftFilter     = { xs in find(isSwift, xs) }
        let swiftFile       = swiftFilter(files)
        XCTAssertTrue(swiftFile == "Haskell.swift")
    }

    func testfindString() {
        let isA             = { (x : Character) in x == "a" }
        let isAFilter       = { (xs : String) in filter(isA, xs) }
        let result          = isAFilter("ABCDa")
        XCTAssertTrue(result == "a")
    }

    //filter() {
    func testfilterIntArray() {
        let list             = [1, 2, 3, 4, 5]
        let greaterThanThree = { x in x > 3 }
        let result           = filter(greaterThanThree, list)
        XCTAssertTrue(result == [4, 5])
    }

    func testfilterStringArray() {
        let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
        let swiftFilter     = { xs in filter(isSwift, xs) }
        let swiftFiles      = swiftFilter(files)
        XCTAssertTrue(swiftFiles == ["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"])
    }

    func testfilterString() {
        let isA             = { (x : Character) in x == "a" }
        let isAFilter       = { (xs : String) in filter(isA, xs) }
        let result          = isAFilter("ABCDa")
        XCTAssertTrue(result == "a")
    }

    //partition() {
    func testpartitionIntArray() {
        let list             = [1, 2, 3, 4, 5]
        let greaterThanThree = { x in x > 3 }
        let (r0, r1)         = partition(greaterThanThree, list)
        XCTAssertTrue(r0 == [4, 5])
        XCTAssertTrue(r1 == [1, 2, 3])
    }

    func testpartitionStringArray() {
        let isSwift             = { (x : String) in x.lowercaseString.hasSuffix("swift") }
        let (r0, r1)            = partition(isSwift, files)
        XCTAssertTrue(r0 == ["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"])
        XCTAssertTrue(r1 == ["README.md"])
    }

    func testpartitionString() {
        let isA                 = { (x : Character) in x == "a" }
        let (r0, r1)            = partition(isA, "ABCDa")
        XCTAssertTrue(r0 == "a")
        XCTAssertTrue(r1 == "ABCD")
    }

    //elemIndex() {
    func testelemIndexIntArray() {
        let list             = [1, 2, 3, 4, 5]
        XCTAssertTrue(elemIndex(1, list) == 0)
        XCTAssertTrue(elemIndex(2, list) == 1)
        XCTAssertTrue(elemIndex(10, list) == nil)
    }

    func testelemIndexStringArray() {
        let words  = ["Window", "Help", "Window"]
        XCTAssertTrue(elemIndex("Window", words) == 0)
        XCTAssertTrue(elemIndex("Help", words) == 1)
        XCTAssertTrue(elemIndex("Debug", words) == nil)
    }

    func testelemIndexString() {
        let word = "Window"
        XCTAssertTrue(elemIndex("W", word) == 0)
        XCTAssertTrue(elemIndex("i", word) == 1)
        XCTAssertTrue(elemIndex("T", word) == nil)
    }

    //elemIndices() {
    func testelemIndicesIntArray() {
        let list             = [1, 2, 3, 4, 3]
        XCTAssertTrue(elemIndices(1, list) == [0])
        XCTAssertTrue(elemIndices(3, list) == [2,4])
        XCTAssertTrue(elemIndices(10, list) == [Int]())
    }

    func testelemIndicesStringArray() {
        let words  = ["Window", "Help", "Window"]
        XCTAssertTrue(elemIndices("Help", words) == [1])
        XCTAssertTrue(elemIndices("Window", words) == [0, 2])
        XCTAssertTrue(elemIndices("D", words) == [Int]())
    }

    func testelemIndicesString() {
        let word = "WINDOW"
        XCTAssertTrue(elemIndices("W", word) == [0, 5])
        XCTAssertTrue(elemIndices("I", word) == [1])
        XCTAssertTrue(elemIndices("T", word) == [Int]())
    }

    //findIndex() {
    func testfindIndexIntArray() {
        let list             = [1, 2, 3, 4, 5]
        let greaterThanThree = { x in x > 3 }
        let result           = findIndex(greaterThanThree, list)
        XCTAssertTrue(result == 3)
    }

    func testfindIndexStringArray() {
        let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
        let swiftFile       = findIndex(isSwift, files)
        XCTAssertTrue(swiftFile == 1)
    }

    func testfindIndexString() {
        let isA             = { (x : Character) in x == "a" }
        let result          =  findIndex(isA, "ABCDa")
        XCTAssertTrue(result == 4)
    }

    //findIndices() {
    func testfindIndicesIntArray() {
        let list             = [1, 2, 3, 4, 5]
        let greaterThanThree = { x in x > 3 }
        let result           = findIndices(greaterThanThree, list)
        XCTAssertTrue(result == [3, 4])
    }

    func testfindIndicesStringArray() {
        let isSwift         = { (x : String) in x.lowercaseString.hasSuffix("swift") }
        let swiftFile       = findIndices(isSwift, files)
        XCTAssertTrue(swiftFile == [1, 2, 3])
    }

    func testfindIndicesString() {
        let isA             = { (x : Character) in x == "a" }
        let result          =  findIndices(isA, "ABCDa")
        XCTAssertTrue(result == [4])
    }

//let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]

    //zip() {
    func testzipIntArray() {
        let tuples          = zip([1, 2, 3], [1, 4, 9])
        let XCTAssertTrueedTuples  = [(1, 1), (2, 4), (3, 9)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzipStringArray() {
        let tuples          = zip(["1", "2", "3"], [".swift", ".o", ".cpp"])
        let XCTAssertTrueedTuples  = [("1", ".swift"), ("2", ".o"), ("3", ".cpp")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzipStringArrayInt() {
        let tuples          = zip([1, 2, 3], [".swift", ".o", ".cpp"])
        let XCTAssertTrueedTuples  = [(1, ".swift"), (2, ".o"), (3, ".cpp")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zip3() {
    func testzip3IntArray() {
        let tuples          = zip3([1, 2, 3], [1, 4, 9], [1, 8, 27])
        let XCTAssertTrueedTuples  = [(1, 1, 1), (2, 4, 8), (3, 9, 27)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip3StringArray() {
        let tuples          = zip3(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
        let XCTAssertTrueedTuples  = [("1", ".", "swift"), ("2", ".", "o"), ("3", ".", "cpp")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip3StringArrayInt() {
        let tuples          = zip3([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"])
        let XCTAssertTrueedTuples  = [(1, ".", "swift"), (2, ".", "o"), (3, ".", "cpp")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zip4() {
    func testzip4IntArray() {
        let tuples          = zip4([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
        let XCTAssertTrueedTuples  = [(1,1,1,1),(2,4,8,2),(3,9,27,3)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip4StringArray() {
        let tuples          = zip4(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        let XCTAssertTrueedTuples  = [("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip4StringArrayInt() {
        let tuples          = zip4([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3])
        let XCTAssertTrueedTuples  = [(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zip5() {
    func testzip5IntArray() {
        let tuples          = zip5([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
        let XCTAssertTrueedTuples  = [(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip5StringArray() {
        let tuples          = zip5(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
        let XCTAssertTrueedTuples  = [("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip5StringArrayInt() {
        let tuples          = zip5([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9])
        let XCTAssertTrueedTuples  = [(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zip6() {
    func testzip6IntArray() {
        let tuples          = zip6([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
        let XCTAssertTrueedTuples  = [(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip6StringArray() {
        let tuples          = zip6(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
        let XCTAssertTrueedTuples  = [("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip6StringArrayInt() {
        let tuples          = zip6([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27])
        let XCTAssertTrueedTuples  = [(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zip7() {
    func testzip7IntArray() {
        let tuples          = zip7([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
        let XCTAssertTrueedTuples  = [(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip7StringArray() {
        let tuples          = zip7(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        let XCTAssertTrueedTuples  = [("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    func testzip7StringArrayInt() {
        let tuples          = zip7([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
        let XCTAssertTrueedTuples  = [(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)]
        let result          = compareTupleArray(tuples, XCTAssertTrueedTuples)
        XCTAssertTrue(result)
    }

    //zipWith() {
    func testzipWithIntArray() {
        let result          = zipWith((+), [1, 2, 3], [1, 4, 9])
        XCTAssertTrue(result == [2,6,12])
    }

    func testzipWithStringArray() {
        let result          = zipWith( (+), ["1", "2", "3"], [".swift", ".o", ".cpp"])
        XCTAssertTrue(result == ["1.swift","2.o","3.cpp"])
    }

    func testzipWithStringArrayInt() {
        let result          = zipWith( { x, y in String(x) + y }, [1, 2, 3], [".swift", ".o", ".cpp"])
        XCTAssertTrue(result == ["1.swift","2.o","3.cpp"])
    }

    //zipWith3() {
    func testzipWith3IntArray() {
        let result          = zipWith3({(x, y, z) in x+y+z}, [1, 2, 3], [1, 4, 9], [1, 8, 27])
        XCTAssertTrue(result == [3,14,39])
    }

    func testzipWith3StringArray() {
        let result          = zipWith3({x, y, z in x+y+z }, ["1", "2", "3"], [".swift", ".o", ".cpp"],[".1", ".2", ".3"])
        XCTAssertTrue(result == ["1.swift.1","2.o.2","3.cpp.3"])
    }

    func testzipWith3StringArrayInt() {
        let result          = zipWith3( { x, y, z in String(x)+y+z }, [1, 2, 3], [".swift", ".o", ".cpp"], [".1", ".2", ".3"])
        XCTAssertTrue(result == ["1.swift.1","2.o.2","3.cpp.3"])
    }

    //zipWith4() {
    func testzipWith4IntArray() {
        let process         = {(a: Int, b: Int, c: Int, d: Int) -> Int in a+b+c+d}
        let result          = zipWith4(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
        XCTAssertTrue(result == [4,16,42])
    }

    func testzipWith4StringArray() {
        let process         = {a,b,c,d-> String in a+b+c+d}
        let result          = zipWith4(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        XCTAssertTrue(result == ["1.swift1","2.o2","3.cpp3"])
    }

    func testzipWith4StringArrayInt() {
        let process         = {(a: Int,b: String,c: String,d: String) -> String in String(a)+b+c+d}
        let result          = zipWith4(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        XCTAssertTrue(result == ["1.swift1","2.o2","3.cpp3"])
    }

    //zipWith5() {
    func testzipWith5IntArray() {
        let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int) -> Int in a+b+c+d+e}
        let result          = zipWith5(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
        XCTAssertTrue(result == [5,20,51])
    }

    func testzipWith5StringArray() {
        let process         = {a,b,c,d,e-> String in a+b+c+d+e}
        let result          = zipWith5(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
        XCTAssertTrue(result == ["1.swift1.","2.o2.","3.cpp3."])
    }

    func testzipWith5StringArrayInt() {
        let process         = {(a: Int,b: String,c: String,d: String,e: String) -> String in String(a)+b+c+d+e}
        let result          = zipWith5(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
        XCTAssertTrue(result == ["1.swift1.","2.o2.","3.cpp3."])
    }

    //zipWith6() {
    func testzipWith6IntArray() {
        let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) -> Int in a+b+c+d+e+f}
        let result          = zipWith6(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
        XCTAssertTrue(result == [6,28,78])
    }

    func testzipWith6StringArray() {
        let process         = {a,b,c,d,e,f-> String in a+b+c+d+e+f}
        let result          = zipWith6(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
        XCTAssertTrue(result == ["1.swift1.swift","2.o2.o","3.cpp3.cpp"])
    }

    func testzipWith6StringArrayInt() {
        let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String) -> String in String(a)+b+c+d+e+f}
        let result          = zipWith6(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
        XCTAssertTrue(result == ["1.swift1.swift","2.o2.o","3.cpp3.cpp"])
    }

    //zipWith7() {
    func testzipWith7IntArray() {
        let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int, g: Int) -> Int in a+b+c+d+e+f+g}
        let result          = zipWith7(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [2, 4, 6])
        XCTAssertTrue(result == [8,32,84])
    }

    func testzipWith7StringArray() {
        let process         = {a,b,c,d,e,f,g -> String in a+b+c+d+e+f+g}
        let result          = zipWith7(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        XCTAssertTrue(result == ["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"])
    }

    func testzipWith7StringArrayInt() {
        let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String,g: String) -> String in String(a)+b+c+d+e+f+g}
        let result          = zipWith7(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
        XCTAssertTrue(result == ["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"])
    }

    //unzip() {
    func testunzipIntArray() {
        let (r0, r1)        = unzip([(1, 1), (2, 4), (3, 9)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
    }

    func testunzipStringArray() {
        let (r0, r1)        = unzip([("1", ".swift"), ("2", ".o"), ("3",".cpp")])
            XCTAssertTrue(r0 == ["1", "2", "3"])
            XCTAssertTrue(r1 == [".swift", ".o", ".cpp"])
    }

    func testunzipStringArrayInt() {
        let (r0, r1)        = unzip([(1, ".swift"), (2, ".o"), (3, ".cpp")])
            XCTAssertTrue(r0 == [1, 2, 3])
            XCTAssertTrue(r1 == [".swift", ".o", ".cpp"])
    }

    //unzip3() {
    func testunzip3IntArray() {
        let (r0, r1, r2)        = unzip3([(1,1,1),(2,4,8),(3,9,27)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
        XCTAssertTrue(r2 == [1, 8, 27])
    }

    func testunzip3StringArray() {
        let (r0, r1, r2)        = unzip3([("1",".","swift"),("2",".","o"),("3",".","cpp")])
            XCTAssertTrue(r0 == ["1", "2", "3"])
            XCTAssertTrue(r1 == [".", ".", "." ])
            XCTAssertTrue(r2 == ["swift", "o", "cpp"])
    }

    func testunzip3StringArrayInt() {
        let (r0, r1, r2)        = unzip3([(1,".","swift"),(2,".","o"),(3,".","cpp")])
            XCTAssertTrue(r0 == [1, 2, 3])
            XCTAssertTrue(r1 == [".", ".", "." ])
            XCTAssertTrue(r2 == ["swift", "o", "cpp"])
    }

    //unzip4() {
    func testunzip4IntArray() {
        let (r0, r1, r2, r3)        = unzip4([(1,1,1,1),(2,4,8,2),(3,9,27,3)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
        XCTAssertTrue(r2 == [1, 8, 27])
        XCTAssertTrue(r3 == [1, 2, 3])
    }

    func testunzip4StringArray() {
        let (r0, r1, r2, r3)        = unzip4([("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")])
            XCTAssertTrue(r0 == ["1", "2", "3"])
            XCTAssertTrue(r1 == [".", ".", "." ])
            XCTAssertTrue(r2 == ["swift", "o", "cpp"])
            XCTAssertTrue(r3 == ["1", "2", "3"])
    }

    func testunzip4StringArrayInt() {
        let (r0, r1, r2, r3)        = unzip4([(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [".", ".", "." ])
        XCTAssertTrue(r2 == ["swift", "o", "cpp"])
        XCTAssertTrue(r3 == [1, 2, 3])
    }

    //unzip5() {
    func testunzip5IntArray() {
        let (r0, r1, r2, r3, r4)        = unzip5([(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
        XCTAssertTrue(r2 == [1, 8, 27])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
    }

    func testunzip5StringArray() {
        let (r0, r1, r2, r3, r4)        = unzip5([("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")])
            XCTAssertTrue(r0 == ["1", "2", "3"])
            XCTAssertTrue(r1 == [".", ".", "." ])
            XCTAssertTrue(r2 == ["swift", "o", "cpp"])
            XCTAssertTrue(r3 == ["1", "2", "3"])
            XCTAssertTrue(r4 ==  [".", ".", "." ])
    }

    func testunzip5StringArrayInt() {
        let (r0, r1, r2, r3, r4)        = unzip5([(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [".", ".", "." ])
        XCTAssertTrue(r2 == ["swift", "o", "cpp"])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
    }

    //unzip6() {
    func testunzip6IntArray() {
        let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
        XCTAssertTrue(r2 == [1, 8, 27])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
        XCTAssertTrue(r5 == [1, 8, 27])
    }

    func testunzip6StringArray() {
        let (r0, r1, r2, r3, r4, r5)        = unzip6([("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")])
        XCTAssertTrue(r0 == ["1", "2", "3"])
        XCTAssertTrue(r1 == [".", ".", "." ])
        XCTAssertTrue(r2 == ["swift", "o", "cpp"])
        XCTAssertTrue(r3 == ["1", "2", "3"])
        XCTAssertTrue(r4 ==  [".", ".", "." ])
        XCTAssertTrue(r5 == ["swift", "o", "cpp"])
    }

    func testunzip6StringArrayInt() {
        let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [".", ".", "." ])
        XCTAssertTrue(r2 == ["swift", "o", "cpp"])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
        XCTAssertTrue(r5 == [1, 8, 27])
    }

    //unzip7() {
    func testunzip7IntArray() {
        let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [1, 4, 9])
        XCTAssertTrue(r2 == [1, 8, 27])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
        XCTAssertTrue(r5 == [1, 8, 27])
        XCTAssertTrue(r6 == [1, 2, 3])
    }

    func testunzip7StringArray() {
        let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")])
            XCTAssertTrue(r0 == ["1", "2", "3"])
            XCTAssertTrue(r1 == [".", ".", "." ])
            XCTAssertTrue(r2 == ["swift", "o", "cpp"])
            XCTAssertTrue(r3 == ["1", "2", "3"])
            XCTAssertTrue(r4 ==  [".", ".", "." ])
            XCTAssertTrue(r5 == ["swift", "o", "cpp"])
            XCTAssertTrue(r6 == ["1", "2", "3"])
    }

    func testunzip7StringArrayInt() {
        let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)])
        XCTAssertTrue(r0 == [1, 2, 3])
        XCTAssertTrue(r1 == [".", ".", "." ])
        XCTAssertTrue(r2 == ["swift", "o", "cpp"])
        XCTAssertTrue(r3 == [1, 2, 3])
        XCTAssertTrue(r4 == [1, 4, 9])
        XCTAssertTrue(r5 == [1, 8, 27])
        XCTAssertTrue(r6 == [1, 2, 3])
    }

    //lines() {
    func testlinesString() {
        let result = lines("Functions\n\n\n don't evaluate their arguments.")
            XCTAssertTrue(result == ["Functions","",""," don't evaluate their arguments."])
    }

    //words() {
    func testwordsString() {
        let result = words("Functions\n\n\n don't evaluate their arguments.")
            XCTAssertTrue(result == ["Functions","don't","evaluate","their","arguments."])
    }

    //unlines() {
    func testunlinesString() {
        let result = unlines(["Functions","",""," don't evaluate their arguments."]) //()
        XCTAssertTrue(result == "Functions\n\n\n don't evaluate their arguments.")
    }

    //unwords() {
    func testunwordsString() {
        let result = unwords(["Functions","don't","evaluate","their","arguments."])
        XCTAssertTrue(result == "Functions don't evaluate their arguments.")
    }

    //nub() {
    func testnubIntArray() {
        let result  = nub([1, 1, 2, 4, 1, 3, 9])
        XCTAssertTrue(result == [1,2,4,3,9])
    }

    func testnubStringArray() {
        let result  = nub(["Create", "Set", "Any", "Set", "Any"])
        XCTAssertTrue(result == ["Create","Set","Any"])
    }

    func testnubString() {
        let result  = nub("are you ok")
            XCTAssertTrue(result == "are youk")
    }

    //delete() {
    func testdeleteIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(delete(2, list) == [1,1,4,1,3,9])
        XCTAssertTrue(delete(1, list) == [1,2,4,1,3,9])
    }

    func testdeleteStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(delete("Set", list) == ["Create","Any","Set","Any"])
        XCTAssertTrue(delete("Any", list) == ["Create","Set","Set","Any"])
    }

    func testdeleteString() {
        XCTAssertTrue(delete(Character("t"), "Swift") == "Swif")
            XCTAssertTrue(delete("t", "Swift") == "Swif")
    }

    //union() {
    func testunionIntArray() {
        let list1   = [1, 1, 2]
        let list2   = [4, 1, 3, 9]
        XCTAssertTrue(union(list1, list2) == [1, 2, 4, 3, 9])
    }

    func testunionStringArray() {
        let list1   = ["Create", "Set"]
        let list2   = ["Any", "Set", "Any"]
        XCTAssertTrue(union(list1, list2) == ["Create","Set", "Any"])
    }

    //intersect() {
    func testintersectIntArray() {
        let list1   = [1, 1, 2]
        let list2   = [4, 1, 3, 9]
        XCTAssertTrue(intersect(list1, list2) == [1, 1])
    }

    func testintersectStringArray() {
        let list1   = ["Create", "Set", "Set"]
        let list2   = ["Any", "Set", "Any"]
        XCTAssertTrue(intersect(list1, list2) == ["Set", "Set"])
    }

    //sort() {
    func testsortIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(sort(list) == [1, 1, 1, 2, 3, 4, 9])
    }

    func testsortStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(sort(list) == ["Any", "Any", "Create", "Set", "Set"])
    }

    //sortOn() {
    func testsortOnIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(sortOn({x, y in x < y}, list) == [1, 1, 1, 2, 3, 4, 9])
        XCTAssertTrue(sortOn({x, y in x > y}, list) == [9,4,3,2,1,1,1])
    }

    func testsortOnStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(sortOn({x, y in x < y}, list) == ["Any", "Any", "Create", "Set", "Set"])
        XCTAssertTrue(sortOn({x, y in x > y}, list) == ["Set","Set","Create","Any","Any"])
    }

    //insert() {
    func testinsertIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        let result  = insert(10, list)
        XCTAssertTrue(result == [1, 1, 2, 4, 1, 3, 9, 10])
    }

    func testinsertStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(insert("Where", list) == ["Create", "Set", "Any", "Set", "Any", "Where"])
    }

    func testinsertString() {
        let list    = "Hello World"
        XCTAssertTrue(insert("!", list) == "Hello World!")
    }

    //nubBy
    func testnubByIntArray() {
        XCTAssertTrue(nubBy({ (x: Int, y: Int) in x == y }, [1, 1, 2, 4, 1, 3, 9]) == [1,2,4,3,9])
        XCTAssertTrue(nubBy({ (x: Int, y: Int) in x == y || x < 3}, [1, 1, 2, 4, 1, 3, 9]) == [1, 4, 3, 9])
    }

    func testnubByStringArray() {
        let list = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(nubBy({ (x: String, y: String) in x == y }, list) == ["Create","Set","Any"])
        XCTAssertTrue(nubBy({ (x: String, y: String) in length(intersect(x, y)) > 0 }, list) == ["Create", "Any"])
    }

    func testnubByString() {
        let f       = { (x: Character, y: Character) -> Bool in
            let x1 = String(x).uppercaseString
            let y1 = String(y).uppercaseString
            return x1 == y1
        }
        let r1      = nubBy(f, "Create , cuT")
        XCTAssertTrue(r1 == "Creat ,u")

        let isSame  = { (x: Character, y: Character) -> Bool in x == y }
        let r2      = nubBy(isSame, "Create a World")
        XCTAssertTrue(r2 == "Creat Wold")
    }

    //deleteBy
    func testdeleteByIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(deleteBy({x,y in x == y}, 2, list) == [1,1,4,1,3,9])
        XCTAssertTrue(deleteBy({x,y in x == y}, 1, list) == [1,2,4,1,3,9])
    }

    func testdeleteByStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(deleteBy({x,y in x == y}, "Set", list) == ["Create","Any","Set","Any"])
        XCTAssertTrue(deleteBy({x,y in x == y}, "Any", list) == ["Create","Set","Set","Any"])
    }

    func testdeleteByString() {
        XCTAssertTrue(deleteBy({x,y in x == y}, Character("t"), "Swift") == "Swif")
        XCTAssertTrue(deleteBy({x,y in x == y}, "t", "Swift") == "Swif")
    }

    //deleteFirstsBy() {
    func testdeleteFirstsByIntArray() {
        let list1    = [1, 1, 2, 4, 1, 3, 9]
        let list2    = [2, 4, 1, 3]
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list1, list2) == [1,1,9])
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list2, list1) == [])
    }

    func testdeleteFirstsByStringArray() {
        let list1    = ["Create", "Set", "Any", "Set", "Any"]
        let list2    = ["Set", "Any", "Object"]
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list1, list2) == ["Create","Set","Any"])
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list2, list1) == ["Object"])
    }

    func testdeleteFirstsByString() {
        let list1   = "overloaded"
        let list2   = "number of elements"
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list1, list2) == "voadd")
        XCTAssertTrue(deleteFirstsBy({x,y in x == y}, list2, list1) == "numb f ements")
    }

    //unionBy() {
    func testunionByIntArray() {
        let list1    = [1, 1, 2, 4, 1, 3, 9]
        let list2    = [2, 4, 1, 3]
        XCTAssertTrue(unionBy({x,y in x == y}, list1, list2) == [1,1,2,4,1,3,9])
        XCTAssertTrue(unionBy({x,y in x == y}, list2, list1) == [2,4,1,3,9])
    }

    func testunionByStringArray() {
        let list1    = ["Create", "Set", "Any", "Set", "Any"]
        let list2    = ["Set", "Any", "Object"]
        let r0       = unionBy({x,y in x == y}, list1, list2)
        XCTAssertTrue(r0 == ["Create","Set","Any","Set","Any","Object"])
        let r1       = unionBy({x,y in x == y}, list2, list1)
        XCTAssertTrue(r1 == ["Set","Any","Object","Create"])
    }

    func testunionByString() {
        let list1   = "overloaded"
        let list2   = "number of elements"
        XCTAssertTrue(unionBy({x,y in x == y}, list1, list2) == "overloadednumb fts")
        XCTAssertTrue(unionBy({x,y in x == y}, list2, list1) == "number of elementsvad")
    }
    //intersectBy
    func testintersectByIntArray() {
        let list1    = [1, 1, 2, 4, 1, 3, 9]
        let list2    = [2, 4, 1, 3]
        XCTAssertTrue(intersectBy({x,y in x == y}, list1, list2) == [1,1,2,4,1,3])
        XCTAssertTrue(intersectBy({x,y in x == y}, list2, list1) == [2,4,1,3])
    }

    func testintersectByStringArray() {
        let list1    = ["Create", "Set", "Any", "Set", "Any"]
        let list2    = ["Set", "Any", "Object"]
        let r0       = intersectBy({x,y in x == y}, list1, list2)
        XCTAssertTrue(r0 == ["Set","Any","Set","Any"])
        let r1       = intersectBy({x,y in x == y}, list2, list1)
        XCTAssertTrue(r1 == ["Set","Any"])
    }

    func testintersectByString() {
        let list1   = "overloaded"
        let list2   = "number of elements"
        XCTAssertTrue(intersectBy({x,y in x == y}, list1, list2) == "oerloe")
        XCTAssertTrue(intersectBy({x,y in x == y}, list2, list1) == "eroelee")
    }

    //groupBy
    func testgroupByIntArray() {
        let ints            = [1, 1, 2, 3, 3, 5, 5]
        let r0              = groupBy({(x, y) in x == y}, ints)
        XCTAssertTrue(r0 == [[1,1],[2],[3,3],[5,5]])
        let r1              = groupBy({(x,y) in x < y}, ints)
        XCTAssertTrue(r1 == [[1],[1,2,3,3,5,5]])
    }

    func testgroupByStringArray() {
        let list    = ["Apple", "Pie", "Pie"]
        let r0      = groupBy( {(x, y) in x == y}, list)
        XCTAssertTrue(r0 == [["Apple"], ["Pie", "Pie"]])
        let r1      = groupBy({(x,y) in x > y}, list)
        XCTAssertTrue(r1 == [["Apple"],["Pie"],["Pie"]])
    }

    func testgroupByString() {
        let list    = "Hello World"
        let r0      = groupBy({(x, y) in x == y}, list)
        XCTAssertTrue(r0 == ["H","e","ll","o"," ","W","o","r","l","d"])
        let r1      = groupBy({(x, y) in x < y}, list)
        XCTAssertTrue(r1 == ["Hello"," World"])
    }
    
    //sortBy
    func testsortByIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(sortBy({x, y in x < y}, list) == [1,1,1,2,3,4,9])
        XCTAssertTrue(sortBy({x, y in x > y}, list) == [9,4,3,2,1,1,1])
    }
    
    func testsortByStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(sortBy({x, y in x < y}, list) == ["Any", "Any", "Create", "Set", "Set"])
        XCTAssertTrue(sortBy({x, y in x > y}, list) == ["Set","Set","Create","Any","Any"])
    }
    
    //insertBy
    func testinsertByIntArray() {
        let list    = [1, 1, 2, 4, 1, 3, 9]
        XCTAssertTrue(insertBy({x, y in x < y}, 6, list) == [1,1,2,4,1,3,6,9])
        XCTAssertTrue(insertBy({x, y in x > y}, 2, list) == [2,1,1,2,4,1,3,9])
    }
    
    func testinsertByStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(insertBy({x, y in x < y}, "Object", list) == ["Create","Object","Set","Any","Set","Any"])
        XCTAssertTrue(insertBy({x, y in x > y}, "Object", list) == ["Object","Create","Set","Any","Set","Any"])
    }
    //maximumBy
    func testmaximumByIntArray() {
        let list    = [1, 1, 2, 18, 4, 24, 6, 9]
        XCTAssertTrue(maximumBy({x, y in x < y ? Ordering.LT : Ordering.GT }, list) == 24)
        XCTAssertTrue(maximumBy({x, y in x > y ? Ordering.GT : Ordering.LT }, list) == 24)
    }
    
    func testmaximumByStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(maximumBy({x, y in x < y ? Ordering.LT : Ordering.GT }, list) == "Set")
        XCTAssertTrue(maximumBy({x, y in x > y ? Ordering.GT : Ordering.LT }, list) == "Set")
    }
    
    //minimumBy
    func testIntArray() {
        let list    = [1, 1, 2, 18, 4, 24, 6, 9]
        XCTAssertTrue(minimumBy({x, y in x < y ? Ordering.LT : Ordering.GT }, list) == 1)
        XCTAssertTrue(minimumBy({x, y in x > y ? Ordering.GT : Ordering.LT }, list) == 1)
    }
    
    func testminimumByStringArray() {
        let list    = ["Create", "Set", "Any", "Set", "Any"]
        XCTAssertTrue(minimumBy({x, y in x < y ? Ordering.LT : Ordering.GT }, list) == "Any")
        XCTAssertTrue(minimumBy({x, y in x > y ? Ordering.GT : Ordering.LT }, list) == "Any")
    }
    
    //genericLength
    func testgenericLengthIntArray() {
        XCTAssertTrue(genericLength([1]) == 1)
        XCTAssertTrue(genericLength([1,2]) == 2)
    }
    
    func testgenericLengthStringArray() {
        XCTAssertTrue(genericLength(["World"]) == 1)
        XCTAssertTrue(genericLength(files) == files.count)
    }
    
    func testgenericLengthString() {
        XCTAssertTrue(genericLength("World") == 5)
        XCTAssertTrue(genericLength("") == 0)
    }
}
