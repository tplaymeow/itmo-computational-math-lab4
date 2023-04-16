import simd

enum LeastSquares { }

extension LeastSquares {
  static func run(
    data: [Point]
  ) -> Output {
    [
      Function.linear(Self.linear(data: data)),
      Function.polynomial2(Self.polynomial2(data: data)),
      Function.polynomial3(Self.polynomial3(data: data)),
      Function.power(Self.power(data: data)),
      Function.exponential(Self.exponential(data: data)),
      Function.logarithmic(Self.logarithmic(data: data)),
    ].map { function in
      Output(data: data, function: function)
    }.min { lhs, rhs in
      lhs.standardDeviation < rhs.standardDeviation
    }!
  }
}

extension LeastSquares {
  private static func linear(
    data: [Point]
  ) -> Function.Linear {
    let n = Double(data.count)

    let sx = data.reduce(0.0) { $0 + $1.x }
    let sxx = data.reduce(0.0) { $0 + $1.x * $1.x }
    let sy = data.reduce(0.0) { $0 + $1.y }
    let sxy = data.reduce(0.0) { $0 + $1.x * $1.y }

    let matrix = simd_double2x2(
      [n, sx],
      [sx, sxx]
    )
    let results = SIMD2([sy, sxy])
    let coefficients = simd_mul(matrix.inverse, results)

    return .init(
      a0: coefficients.x,
      a1: coefficients.y
    )
  }

  private static func polynomial2(
    data: [Point]
  ) -> Function.Polynomial2 {
    let n = Double(data.count)

    let sx = data.reduce(0.0) { $0 + $1.x }
    let sxx = data.reduce(0.0) { $0 + $1.x * $1.x }
    let sxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x }
    let sxxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x * $1.x }
    let sy = data.reduce(0.0) { $0 + $1.y }
    let sxy = data.reduce(0.0) { $0 + $1.x * $1.y }
    let sxxy = data.reduce(0.0) { $0 + $1.x * $1.x * $1.y }

    let matrix = simd_double3x3(
      [n, sx, sxx],
      [sx, sxx, sxxx],
      [sxx, sxxx, sxxxx]
    )
    let results = SIMD3([sy, sxy, sxxy])
    let coefficients = simd_mul(matrix.inverse, results)

    return .init(
      a0: coefficients.x,
      a1: coefficients.y,
      a2: coefficients.z
    )
  }

  private static func polynomial3(
    data: [Point]
  ) -> Function.Polynomial3 {
    let n = Double(data.count)

    let sx = data.reduce(0.0) { $0 + $1.x }
    let sxx = data.reduce(0.0) { $0 + $1.x * $1.x }
    let sxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x }
    let sxxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x * $1.x }
    let sxxxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x * $1.x * $1.x }
    let sxxxxxx = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x * $1.x * $1.x * $1.x }
    let sy = data.reduce(0.0) { $0 + $1.y }
    let sxy = data.reduce(0.0) { $0 + $1.x * $1.y }
    let sxxy = data.reduce(0.0) { $0 + $1.x * $1.x * $1.y }
    let sxxxy = data.reduce(0.0) { $0 + $1.x * $1.x * $1.x * $1.y }

    let matrix = simd_double4x4(
      [n, sx, sxx, sxxx],
      [sx, sxx, sxxx, sxxxx],
      [sxx, sxxx, sxxxx, sxxxxx],
      [sxxx, sxxxx, sxxxxx, sxxxxxx]
    )
    let results = SIMD4([sy, sxy, sxxy, sxxxy])
    let coefficients = simd_mul(matrix.inverse, results)

    return .init(
      a0: coefficients.x,
      a1: coefficients.y,
      a2: coefficients.z,
      a3: coefficients.w
    )
  }

  private static func power(
    data: [Point]
  ) -> Function.Power {
    let linearData = data.map { Point(x: log($0.x), y: log($0.y)) }
    let linear = Self.linear(data: linearData)
    return .init(
      coefficient: exp(linear.a0),
      exponent: linear.a1
    )
  }

  private static func exponential(
    data: [Point]
  ) -> Function.Exponential {
    let linearData = data.map { Point(x: $0.x, y: log($0.y)) }
    let linear = Self.linear(data: linearData)
    return .init(
      coefficient: exp(linear.a0),
      exponentCoefficient: linear.a1
    )
  }

  private static func logarithmic(
    data: [Point]
  ) -> Function.Logarithmic {
    let powerData = data.map { Point(x: $0.x, y: exp($0.y)) }
    let power = Self.power(data: powerData)
    return .init(
      coefficient: power.exponent,
      freeCoefficient: log(power.coefficient)
    )
  }
}
