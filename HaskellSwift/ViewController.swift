//
//  ViewController.swift
//  HaskellSwift
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

