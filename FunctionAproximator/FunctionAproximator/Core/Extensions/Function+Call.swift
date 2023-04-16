import Foundation

extension Function {
  func callAsFunction(_ x: Double) -> Double {
    switch self {
    case let .linear(linear):
      return linear(x)
    case let .polynomial2(polynomial):
      return polynomial(x)
    case let .polynomial3(polynomial):
      return polynomial(x)
    case let .power(power):
      return power(x)
    case let .exponential(exponential):
      return exponential(x)
    case let .logarithmic(logarithmic):
      return logarithmic(x)
    }
  }
}

extension Function.Linear {
  func callAsFunction(_ x: Double) -> Double {
    self.a0 + self.a1 * x
  }
}

extension Function.Polynomial2 {
  func callAsFunction(_ x: Double) -> Double {
    self.a0 + self.a1 * x + self.a2 * x * x
  }
}

extension Function.Polynomial3 {
  func callAsFunction(_ x: Double) -> Double {
    self.a0 + self.a1 * x + self.a2 * x * x + self.a3 * x * x * x
  }
}

extension Function.Power {
  func callAsFunction(_ x: Double) -> Double {
    self.coefficient * pow(x, self.exponent)
  }
}

extension Function.Exponential {
  func callAsFunction(_ x: Double) -> Double {
    self.coefficient * exp(self.exponentCoefficient * x)
  }
}

extension Function.Logarithmic {
  func callAsFunction(_ x: Double) -> Double {
    self.coefficient * log(x) + self.freeCoefficient
  }
}
