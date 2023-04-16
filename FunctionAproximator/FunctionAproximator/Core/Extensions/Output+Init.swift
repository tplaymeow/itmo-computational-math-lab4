import Foundation

extension Output {
  init(data: [Point], function: Function) {
    self.function = function
    self.table = data.map { point in
      TableItem(
        x: point.x,
        y: point.y,
        approximatedY: function(point.x)
      )
    }
    self.standardDeviation = sqrt(
      self.table.reduce(0.0) { result, item in
        result + item.deviation * item.deviation
      } / Double(self.table.count)
    )
  }
}

extension Output.TableItem {
  init(x: Double, y: Double, approximatedY: Double) {
    self.x = x
    self.y = y
    self.approximatedY = approximatedY
    self.deviation = approximatedY - y
  }
}
