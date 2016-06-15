//
//  PreludeSpec.swift
//  HaskellSwift
//
//  Created by Liang on 02/03/2016.
import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class PreludeSpec: QuickSpec {
    override func spec() {
        //MARK: succ
        describe("succ") {
            it("Int") {
                let x = Int(1)
                let y = succ(x)
                expect(y).to(equal(x+1))
            }

            it("Int8") {
                let x = Int8(1)
                let y = succ(Int8(1))
                expect(y).to(equal(x+1))
            }

            it("Int16") {
                let x = Int16(1)
                let y = succ(Int16(1))
                expect(y).to(equal(x+1))
            }

            it("Int32") {
                let x = Int32(1)
                let y = succ(Int32(1))
                expect(y).to(equal(x+1))
            }

            it("Int64") {
                let x = Int64(1)
                let y = succ(Int64(1))
                expect(y).to(equal(x+1))
            }
            
            it("UInt") {
                let x = UInt16(1)
                let y = succ(UInt16(1))
                expect(y).to(equal(x+1))
            }
            
            it("UInt8") {
                let x = UInt8(1)
                let y = succ(UInt8(1))
                expect(y).to(equal(x+1))
            }

            it("UInt16") {
                let x = UInt16(1)
                let y = succ(UInt16(1))
                expect(y).to(equal(x+1))
            }

            it("UInt32") {
                let x = UInt32(1)
                let y = succ(UInt32(1))
                expect(y).to(equal(x+1))
            }

            it("UInt64") {
                let x = UInt64(1)
                let y = succ(UInt64(1))
                expect(y).to(equal(x+1))
            }

            it("Character") {
                let x = Character("a")
                let y = succ(x)
                expect(y).to(equal("b"))
            }
        }

        //MARK: pred
        describe("pred") {
            it("Int") {
                let x = Int(1)
                let y = pred(x)
                expect(y).to(equal(x-1))
            }

            it("Int8") {
                let x = Int8(1)
                let y = pred(Int8(1))
                expect(y).to(equal(x-1))
            }

            it("Int16") {
                let x = Int16(1)
                let y = pred(Int16(1))
                expect(y).to(equal(x-1))
            }

            it("Int32") {
                let x = Int32(1)
                let y = pred(Int32(1))
                expect(y).to(equal(x-1))
            }

            it("Int64") {
                let x = Int64(1)
                let y = pred(Int64(1))
                expect(y).to(equal(x-1))
            }

            it("UInt") {
                let x = UInt16(1)
                let y = pred(UInt16(1))
                expect(y).to(equal(x-1))
            }

            it("UInt8") {
                let x = UInt8(1)
                let y = pred(UInt8(1))
                expect(y).to(equal(x-1))
            }

            it("UInt16") {
                let x = UInt16(1)
                let y = pred(UInt16(1))
                expect(y).to(equal(x-1))
            }

            it("UInt32") {
                let x = UInt32(1)
                let y = pred(UInt32(1))
                expect(y).to(equal(x-1))
            }

            it("UInt64") {
                let x = UInt64(1)
                let y = pred(UInt64(1))
                expect(y).to(equal(x-1))
            }

            it("Character") {
                let x = Character("b")
                let y = pred(x)
                expect(y).to(equal("a"))
            }

            //special case
            it("Character-UnicodeScalar(0)") {
                let x = Character(UnicodeScalar(0))
                let y = pred(x)
                expect(y).to(equal(x))
            }
        }

        //MARK: enumFromTo
        describe("enumFromTo") {
            it("Int") {
                let xs = enumFromTo(1, 3)
                expect(xs).to(equal([1, 2, 3]))
            }

            it("Int8") {
                let xs = enumFromTo(Int8(1), Int8(3))
                let ys: [Int8] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("Int16") {
                let xs = enumFromTo(Int16(1), Int16(3))
                let ys: [Int16] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("Int32") {
                let xs = enumFromTo(Int32(1), Int32(3))
                let ys: [Int32] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("Int64") {
                let xs = enumFromTo(Int64(1), Int64(3))
                let ys: [Int64] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("UInt") {
                let xs = enumFromTo(UInt(1), UInt(3))
                expect(xs).to(equal([1, 2, 3]))
            }

            it("UInt8") {
                let xs = enumFromTo(UInt8(1), UInt8(3))
                let ys: [UInt8] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("UInt16") {
                let xs = enumFromTo(UInt16(1), UInt16(3))
                let ys: [UInt16] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("UInt32") {
                let xs = enumFromTo(UInt32(1), UInt32(3))
                let ys: [UInt32] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("UInt64") {
                let xs = enumFromTo(UInt64(1), UInt64(3))
                let ys: [UInt64] = [1, 2, 3]
                expect(xs).to(equal(ys))
            }

            it("Character a -> z") {
                let xs = enumFromTo(Character("a"), Character("c"))
                let ys = "abc"
                expect(xs).to(equal(ys))
            }

            it("Character a -> a") {
                let xs = enumFromTo(Character("a"), Character("a"))
                let ys = "a"
                expect(xs).to(equal(ys))
            }

            it("Character z -> a") {
                let xs = enumFromTo(Character("z"), Character("a"))
                let ys = ""
                expect(xs).to(equal(ys))
            }
        }

        //MARK: until
        describe("until") {
            it("Int") {
                let condition = { x in
                    return x > 10
                }

                let process  = { x in
                    return x + 1
                }

                let x = until(condition, process, 0)
                expect(x).to(equal(11))
            }

            it("tuple") {
                let condition = { (t: (name: String, age: Int))  in
                    return t.age > 10
                }

                let process  = { (t: (String, Int)) in
                    return (t.0, t.1 + 1)
                }

                let t = until(condition, process, ("Jack", 0))
                expect(t.0).to(equal("Jack"))
                expect(t.1).to(equal(11))
            }
        }

        //MARK: - Integer
        //MARK: div
        describe("div") {
            it("Int") {
                let x = div(7, 3)
                expect(x).to(equal(2))
            }
        }

        //MARK: mod
        describe("mod") {
            it("Int") {
                let x = mod(7, 3)
                expect(x).to(equal(1))
            }
        }

        //MARK: divMod
        describe("divMod") {
            it("Int") {
                let t = divMod(7, 3)
                expect(t.0).to(equal(2))
                expect(t.1).to(equal(1))
            }
        }

        //MARK: - Numberic
        //MARK: even
        describe("even") {
            it("Int") {
                expect(even(1)).to(beFalse())
                expect(even(2)).to(beTrue())
            }
        }

        //MARK: odd
        describe("odd") {
            it("Int") {
                expect(odd(2)).to(beFalse())
                expect(odd(1)).to(beTrue())
            }
        }

        //MARK: - Files
        describe("Files") {
            //MARK: fileExists
            describe("fileExists") {
                it("existing file/dir") {
                    expect(fileExists("/etc/hosts")).to(beTrue())
                    expect(fileExists("/etc/")).to(beTrue())
                }

                it("non existing file/dir") {
                    expect(fileExists("/not_existed_dir/")).to(beFalse())
                    expect(fileExists("/not_existed_dir/file")).to(beFalse())
                }
            }

            //MARK: readFile
            describe("readFile") {
                it("existing file: permission granted") {
                    let content = readFile("/etc/paths")
                    expect(content != nil).to(beTrue())
                    expect(length(content!) > 0).to(beTrue())
                }

                it("existing file: permission denied") {
                    let content = readFile("/etc/sudoers")
                    expect(content).to(beNil())
                }

                it("non existing file") {
                    let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let content  = readFile(path)
                    expect(content).to(beNil())
                }
            }

            //MARK: writeFile
            it("writeFile") {
                //permission granted
                let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                let content0 = readFile("/etc/paths")
                writeFile(path, content0!)
                expect(fileExists(path)).to(beTrue())
                let content1 = readFile(path)
                expect(content0).to(equal(content1))

                //permission denied
                setFilePermission(path, 0o000)
                let content2 = readFile(path)
                expect(content2).to(beNil())
                setFilePermission(path, 0o666)
                removeFile(path)
            }

            //MARK: appendFile
            describe("appendFile") {
                it("append existing file") {
                    //permission granted
                    let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let content0 = readFile("/etc/paths")
                    let newData  = "appended content"
                    writeFile(path, content0!)
                    appendFile(path, newData)
                    expect(fileExists(path)).to(beTrue())
                    let content1 = readFile(path)
                    expect(content0! + newData).to(equal(content1))

                    //permission denied
                    setFilePermission(path, 0o000)
                    let r = appendFile(path, newData)

                    //permission granted
                    setFilePermission(path, 0o666)
                    let content2 = readFile(path)
                    expect(r).to(beFalse())
                    expect(content2).to(equal(content1))

                    //clean up
                    removeFile(path)
                }

                it("append non existing file") {
                    let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let content0 = "appended content"
                    appendFile(path, content0)
                    expect(fileExists(path)).to(beTrue())
                    let content1 = readFile(path)
                    expect(content0).to(equal(content1))
                    removeFile(path)
                }
            }

            //MARK: removeFile
            describe("removeFile") {
                it("remove existing file") {
                    let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    writeFile(path, "test")
                    expect(fileExists(path)).to(beTrue())
                    removeFile(path)
                    expect(fileExists(path)).to(beFalse())
                }

                it("remove non existing file") {
                    let path     = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    expect(fileExists(path)).to(beFalse())
                    let r = removeFile(path)
                    expect(r).to(beFalse())
                }
            }

            //MARK: copyFile
            describe("copyFile") {
                it("copy existing file") {
                    let src = "/etc/paths"
                    let dst = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let r   = copyFile(src, dst)
                    expect(r).to(beTrue())
                    expect(readFile(src)).to(equal(readFile(dst)))
                    expect(fileExists(dst)).to(beTrue())
                    removeFile(dst)
                }

                it("copy non existing file") {
                    let src = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let dst = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                    let r   = copyFile(src, dst)
                    expect(r).to(beFalse())
                    expect(readFile(src)).to(beNil())
                    expect(readFile(dst)).to(beNil())
                    expect(fileExists(dst)).to(beFalse())
                    removeFile(dst)
                }
            }

            //MARK: readDir
            describe("readDir") {
                it("existing directory") {
                    let r = filter({$0 == "var"}, readDir("/"))
                    expect(r).to(equal(["var"]))
                }

                it("non existing directory") {
                    let r = readDir("/non_existing_directory")
                    expect(r).to(equal([]))
                }
            }

            //MARK: getFilePermission
            it("getFilePermission") {
                let r0 = getFilePermission("/etc/paths")
                expect(r0!).to(equal(420))
                let r1 = getFilePermission("/etc/paths_not_exists")
                expect(r1).to(beNil())
            }

            //MARK: setFilePermission
            it("setFilePermission") {
                let path = NSTemporaryDirectory() + NSUUID().UUIDString + ".txt"
                writeFile(path, "test")
                let r0 = setFilePermission(path, 0o777)
                expect(!r0).to(beTrue())
                let r1 = getFilePermission(path)
                expect(r1!).to(equal(0o777))
                removeFile(path)
            }
        }
    }
}

