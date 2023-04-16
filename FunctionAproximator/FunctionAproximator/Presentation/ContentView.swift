import SwiftUI
import AppKit
import CodableCSV

struct ContentView: View {
  var body: some View {
    self.content
      .padding()
  }

  private enum State {
    case empty
    case content(Output)
    case error(message: String)
  }

  @SwiftUI.State
  private var state: State = .empty

  @ViewBuilder
  private var content: some View {
    switch self.state {
    case .empty:
      Button("Import data") {
        self.importData()
      }

    case let .error(message):
      VStack {
        Text(message)
        Button("Try again") {
          self.importData()
        }
      }

    case let .content(output):
      VStack {
        Text("Function: ") +
        Text(output.function.displayString).bold()

        Text("Standard deviation: ") +
        Text(output.standardDeviation.formatted()).bold()

        ChartView(data: [
          .init(
            points: output.table.map { Point(x: $0.x, y: $0.y) },
            color: .red,
            type: .point
          ),
          .init(
            points: self.points(for: output)
          ),
        ])

        Table(output.table) {
          TableColumn("X") { item in
            Text(item.x.formatted())
          }

          TableColumn("Y") { item in
            Text(item.y.formatted())
          }

          TableColumn("φ(x)") { item in
            Text(item.approximatedY.formatted())
          }

          TableColumn("ε") { item in
            Text(item.deviation.formatted())
          }
        }

        Button("Clear") {
          self.clear()
        }
      }
    }
  }

  private func points(for output: Output) -> [Point] {
    guard let intervalFrom = output.table.map(\.x).min(),
          let intervalTo = output.table.map(\.x).max() else {
      return []
    }

    let intervalSize = intervalTo - intervalFrom
    guard intervalSize > 0 else {
      return []
    }

    return linspace(
      from: intervalFrom - 0.1 * intervalSize,
      through: intervalTo + 0.1 * intervalSize,
      in: 100
    ).map { x in
      Point(x: x, y: output.function(x))
    }
  }

  func importData() {
    let panel = NSOpenPanel()
    panel.begin { _ in
      guard let url = panel.url else {
        self.state = .error(message: "File not selected")
        return
      }

      guard let data = try? Data(contentsOf: url) else {
        self.state = .error(message: "Can't read file")
        return
      }

      let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
      guard let points = try? decoder.decode([Point].self, from: data) else {
        self.state = .error(message: "Incorrect file content")
        return
      }

      guard points.count >= 6 else {
        self.state = .error(message: "Too few points. Your file must contain more than or equal to 6 points.")
        return
      }

      self.state = .content(LeastSquares.run(data: points))
    }
  }

  func clear() {
    self.state = .empty
  }
}
