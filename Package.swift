import PackageDescription

let package = Package(
      name: "HaskellSwift",
      targets: [
      Target(
                 name: "HaskellSwift",
      dependencies: []),
      /*Target(
                         name: "SwiftCheck",
      dependencies: []),*/

      //dependencies: [.Target(name: "Data"), .Target(name: "Control"), .Target(name: "GHC")]),
      /*    Target(
                 name: "Data",
      dependencies: []),
          Target(
                 name: "GHC",
      dependencies: []),
          Target(
                 name: "Control",
      dependencies: [.Target(name: "Data")])*/
      ])
