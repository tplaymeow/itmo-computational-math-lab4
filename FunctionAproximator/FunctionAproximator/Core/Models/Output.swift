import Foundation

struct Output: Equatable, Hashable {
  struct TableItem: Equatable, Hashable {
    let x: Double
    let y: Double
    let approximatedY: Double
    let deviation: Double
  }

  let function: Function
  let standardDeviation: Double
  let table: [TableItem]
}

extension Output.TableItem: Identifiable {
  var id: Self {
    self
  }
}
