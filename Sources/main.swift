//
//  AppDelegate.swift
//  HaskellSwift
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

    //func test() {
      //        let list = ["abc", "cde", "efg"]
      //        let h = [head(list)]
      //        print(h)
        //        let i = initx(list)
        //        print(i)
        //        let result = reverse(list) + list
        //        print(result)
        //        let filteredWords = reverse(filter({ (x: String) in take(2,x) == "cd"}, result))
        //        print(filteredWords)
        //
        //        let isGood = and([true, false])
        //        print(isGood)
        //        //print(add([true, false]))
        //        let r1 = lines("Functions\n\n\n don't evaluate their arguments.")
        //        print(r1)


        //        var list         = "abc"
        //        let expectedList = ["abc","bac","cba","bca","cab","acb"]
        //  let r0 = list >>= { ys in between(head(list), ys)}
        //let r0 = permutations(["a", "b", "c"])


        let r1 = permutations("abc")
        print(r1)
        let r2 = scanl((*), 1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        print(r2)

        // Insert code here to initialize your application
        let d1           = { (x: Int) -> [Int] in
          return [x+1, x+2]
        }

        let d2 = { (x: Int) -> [Int] in
          return [x*2, x*3]
        }

        let d3 = d2

        let r3 = [1] >>= d1 >>= d2 >>= d3
        print(r3)

        let r4 = [1] >>= d3 <=< d2 <=< d1
        print(r4)

        let r5 = [1] >>= d1 >=> d2 >=> d3
        print(r5)

        let ds = [d3,d2,d1]
        let f6 = { (f:Int->[Int], g: Int->[Int]) -> Int->[Int] in
          return f <=< g
        }
        let r6 = [1] >>= foldr1(f6, ds)
        print(r6)
//    }

