//
//  System.FilePath.PosixSpec.swift
//  HaskellSwift
//
//  Created by Liang on 30/05/2016.
//  Copyright © 2016 Liang. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HaskellSwift

class SystemFilePathPosixSpec: QuickSpec {
    override func spec() {
        describe("Extension functions") {
            it("splitSearchPath") {
                XCTAssertEqual(splitSearchPath("File1:File2:File3") , ["File1","File2","File3"])
                XCTAssertEqual(splitSearchPath("File1::File2:File3") , ["File1", ".", "File2","File3"])
            }

            it("splitExtension") {
                XCTAssertTrue(splitExtension("/tmp.txt") == ("/tmp", ".txt"))
                XCTAssertTrue(splitExtension("/tmp") == ("/tmp", ""))
                XCTAssertTrue(splitExtension("/tmp.") == ("/tmp", "."))

                XCTAssertTrue(splitExtension("file.txt") == ("file",".txt"))
                XCTAssertTrue(splitExtension("file") == ("file", ""))
                XCTAssertTrue(splitExtension("file/file.txt") == ("file/file", ".txt"))
                XCTAssertTrue(splitExtension("file.txt/boris") == ("file.txt/boris", ""))
                XCTAssertTrue(splitExtension("file.txt/boris.ext") == ("file.txt/boris", ".ext"))
                XCTAssertTrue(splitExtension("file/path.txt.bob.fred") == ("file/path.txt.bob",".fred"))
                XCTAssertTrue(splitExtension("file/path.txt/") == ("file/path.txt/", ""))
            }

            it("takeExtension") {
                XCTAssertEqual(takeExtension("/directory/path.ext") , ".ext")
                XCTAssertEqual(takeExtension("/directory/pathext") , "")
            }

            it("replaceExtension") {
                XCTAssertEqual(replaceExtension("/directory/path.ext", ".abc") , "/directory/path.abc")
                XCTAssertEqual(replaceExtension("/directory/path.ext", "abc") , "/directory/path.abc")
                XCTAssertEqual(replaceExtension("/directory/pathext", "") , "/directory/pathext")
                XCTAssertEqual(replaceExtension("/directory/pathext", ".") , "/directory/pathext.")
            }

            it("dropExtension") {
                XCTAssertEqual(dropExtension("/directory/path.ext"), "/directory/path")
            }

            it("addExtension") {
                XCTAssertEqual(addExtension("/directory/path", "ext"), "/directory/path.ext")
                XCTAssertEqual(addExtension("file.txt", "bib") , "file.txt.bib")
                XCTAssertEqual(addExtension("file.", "bib") , "file..bib")
                XCTAssertEqual(addExtension("file", ".bib") , "file.bib")
            }

            it("hasExtension") {
                XCTAssertTrue(hasExtension("/directory/path.ext"))
                XCTAssertFalse(hasExtension("/directory/path"))
            }

            it("splitExtensions") {
                XCTAssertTrue(splitExtensions("/tmp.txt") == ("/tmp", ".txt"))
                XCTAssertTrue(splitExtensions("/tmp") == ("/tmp", ""))
                XCTAssertTrue(splitExtensions("/tmp.tar.gz") == ("/tmp", ".tar.gz"))
            }

            it("dropExtensions") {
                expect(dropExtensions("/directory/path.ext")).to(equal("/directory/path"))
                expect(dropExtensions("file.tar.gz")).to(equal("file"))
            }

            it("takeExtensions") {
                XCTAssertTrue(splitExtensions("/tmp.txt") == ("/tmp", ".txt"))
                XCTAssertTrue(splitExtensions("/tmp") == ("/tmp", ""))
                XCTAssertTrue(splitExtensions("/tmp.tar.gz") == ("/tmp", ".tar.gz"))
            }

            it("replaceExtensions") {
                XCTAssertEqual(replaceExtensions("/directory/path.ext", ".abc") , "/directory/path.abc")
                XCTAssertEqual(replaceExtensions("/directory/path.tar.gz", "abc") , "/directory/path.abc")
                XCTAssertEqual(replaceExtensions("/directory/pathext", "") , "/directory/pathext")
                XCTAssertEqual(replaceExtensions("/directory/pathext", ".") , "/directory/pathext.")
                XCTAssertEqual(replaceExtensions("/directory/path.bob", "tar.gz") , "/directory/path.tar.gz")
            }

            it("stripExtensions") {
                XCTAssertEqual(stripExtensions("hs.o", "foo.x.hs.o") , Optional<String>.some("foo.x"))
                XCTAssertEqual(stripExtensions("hi.o", "foo.x.hs.o") , nil)
                XCTAssertEqual(stripExtensions(".c.d", "a.b.c.d") , Optional<String>.some("a.b"))
                XCTAssertEqual(stripExtensions(".c.d", "a.b..c.d") , Optional<String>.some("a.b."))
                XCTAssertEqual(stripExtensions("baz", "foo.bar") , nil)
                XCTAssertEqual(stripExtensions("bar", "foobar") , nil)
                XCTAssertEqual(stripExtensions("", "foobar.txt") , "foobar.txt")
            } 
        }

        describe("Filename/directory functions") {
            it("splitFileName") {
                XCTAssertTrue(splitFileName("file/bob.txt") == ("file/", "bob.txt"))
            }

            it("takeFileName") {
                XCTAssertEqual(takeFileName("/directory/file.ext"), "file.ext")
                XCTAssertEqual(takeFileName("test/"), "")
            }

            it("replaceFileName") {
                XCTAssertEqual(replaceFileName("/directory/file.ext", "zz.tar.gz"), "/directory/zz.tar.gz")
                XCTAssertEqual(replaceFileName("test/", "abc.txt"), "test/abc.txt")
            }

            it("dropFileName") {
                XCTAssertEqual(dropFileName("/directory/file.ext"), "/directory/")
                XCTAssertEqual(dropFileName("test/"), "test/")
            }

            it("takeBaseName") {
                XCTAssertEqual(takeBaseName("/directory/file.ext"), "file")
                XCTAssertEqual(takeBaseName("dave.ext"), "dave")
                XCTAssertEqual(takeBaseName(""), "")
                XCTAssertEqual(takeBaseName("test"), "test")
                XCTAssertEqual(takeBaseName("file/file.tar.gz"), "file.tar")
            }

            it("replaceBaseName") {
                XCTAssertEqual(replaceBaseName("/directory/other.ext", "file"), "/directory/file.ext")
                XCTAssertEqual(replaceBaseName("file/test.txt", "bob"), "file/bob.txt")
                XCTAssertEqual(replaceBaseName("fred", "bill"), "bill")
                XCTAssertEqual(replaceBaseName("/dave/fred/bob.gz.tar", "new"), "/dave/fred/new.tar")
            }

            it("takeDirectory") {
                XCTAssertEqual(takeDirectory("/directory/other.ext"), "/directory")
                XCTAssertEqual(takeDirectory("foo"), ".")
                XCTAssertEqual(takeDirectory("/"), "/")
                XCTAssertEqual(takeDirectory("/foo"), "/")
                XCTAssertEqual(takeDirectory("/foo/bar/baz"), "/foo/bar")
                XCTAssertEqual(takeDirectory("/foo/bar/baz/"), "/foo/bar/baz")
                XCTAssertEqual(takeDirectory("foo/bar/baz"), "foo/bar")
            }

            it("replaceDirectory") {
                XCTAssertEqual(replaceDirectory("/directory/other.ext", "root"), "root/other.ext")
                XCTAssertEqual(replaceDirectory("root/file.ext", "/directory/"), "/directory/file.ext")
                XCTAssertEqual(replaceDirectory("/fred/file.ext", "bill"), "bill/file.ext")
                XCTAssertEqual(replaceDirectory("/dave/fred/bob.gz.tar", ""), "bob.gz.tar")
            }

            it("</>") {
                XCTAssertEqual("/directory/path" </> "file", "/directory/path/file")
                XCTAssertEqual("" </> "file", "file")
                XCTAssertEqual("/abc/" </> "/file", "/file")
                XCTAssertEqual("/abc/" </> "file", "/abc/file")
            }

            it("splitPath") {
                XCTAssertEqual(splitPath("/directory/file.ext"), ["/","directory/","file.ext"])
                XCTAssertEqual(splitPath("test/file"), ["test/","file"])
                XCTAssertEqual(splitPath("/test/file"), ["/","test/","file"])
            }

            it("joinPath") {
                XCTAssertEqual(joinPath(["/","directory/","file.ext"]), "/directory/file.ext")
                XCTAssertEqual(joinPath(["test/","file"]), "test/file")
                XCTAssertEqual(joinPath(["/","test/","file"]), "/test/file")
            }

            it("splitDirectories") {
                XCTAssertEqual(splitDirectories("/directory/file.ext"), ["/","directory","file.ext"])
                XCTAssertEqual(splitDirectories("test/file"), ["test","file"])
                XCTAssertEqual(splitDirectories("/test/file"), ["/","test","file"])
            }
        }

        describe("Trailing slash functions") {
            it("hasTrailingPathSeparator") {
                XCTAssertFalse(hasTrailingPathSeparator("test"))
                XCTAssertTrue(hasTrailingPathSeparator("test/"))
            }

            it("addTrailingPathSeparator") {
                XCTAssertEqual(addTrailingPathSeparator("test/rest"), "test/rest/")
                XCTAssertEqual(addTrailingPathSeparator("test/rest/"), "test/rest/")
                XCTAssertEqual(addTrailingPathSeparator(""), "/")
                XCTAssertEqual(addTrailingPathSeparator("/"), "/")
            }

            it("dropTrailingPathSeparator") {
                XCTAssertEqual(dropTrailingPathSeparator("test/rest"), "test/rest")
                XCTAssertEqual(dropTrailingPathSeparator("test/rest/"), "test/rest")
                XCTAssertEqual(dropTrailingPathSeparator(""), "")
                XCTAssertEqual(dropTrailingPathSeparator("/"), "/")
            }
        }

        describe("Trailing slash functions") {
            it("normalisePath") {
                XCTAssertEqual(normalisePath("/file/\\test////"), "/file/\\test/")
                XCTAssertEqual(normalisePath(""), ".")
                XCTAssertEqual(normalisePath("."), ".")
                XCTAssertEqual(normalisePath("./"), "./")
                XCTAssertEqual(normalisePath("./."), "./")
                XCTAssertEqual(normalisePath("/./"), "/")
                XCTAssertEqual(normalisePath("/"), "/")
                XCTAssertEqual(normalisePath("bob/fred/."), "bob/fred/")
                XCTAssertEqual(normalisePath("//home"), "/home")
            }
        }

        describe("File name manipulations") {
            it("isRelativePath") {
                XCTAssertTrue(isRelativePath("test/path"))
                XCTAssertTrue(isRelativePath("test"))
                XCTAssertFalse(isRelativePath("/"))
                XCTAssertFalse(isRelativePath("/test"))
            }

            it("isAbsolutePath") {
                XCTAssertFalse(isAbsolutePath("test/path"))
                XCTAssertFalse(isAbsolutePath("test"))
                XCTAssertTrue(isAbsolutePath("/"))
                XCTAssertTrue(isAbsolutePath("/test"))
            }
        }
    }
}
