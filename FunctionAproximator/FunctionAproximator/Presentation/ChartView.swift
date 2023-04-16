import SwiftUI
import Charts

struct ChartView: View {
  enum `Type`: Hashable {
    case point
    case line
  }

  struct Data: Hashable {
    let points: [Point]
    var color: Color = .white
    var type: `Type` = .line
  }

  var data: [Data] = []

  var body: some View {
    Chart {
      ForEach(self.data, id: \.self) { data in
        ForEach(data.points) { point in
          switch data.type {
          case .line:
            LineMark(
              x: .value("X", point.x),
              y: .value("Y", point.y)
            )
            .foregroundStyle(data.color)
            .interpolationMethod(.cardinal)

          case .point:
            PointMark(
              x: .value("X", point.x),
              y: .value("Y", point.y)
            )
            .foregroundStyle(data.color)
          }
        }
      }
    }
    .foregroundStyle(Color.white)
    .padding(20)
    .cornerRadius(20)
  }
}
