import Foundation

extension Function {
  var displayString: String {
    switch self {
    case let .linear(linear):
      return linear.displayString
    case let .polynomial2(polynomial):
      return polynomial.displayString
    case let .polynomial3(polynomial):
      return polynomial.displayString
    case let .power(power):
      return power.displayString
    case let .exponential(exponential):
      return exponential.displayString
    case let .logarithmic(logarithmic):
      return logarithmic.displayString
    }
  }
}

extension Function.Linear {
  var displayString: String {
    let a0 = self.a0.formatted()
    let a1 = self.a1.formatted()
    return "\(a1)x + \(a0)"
  }
}

extension Function.Polynomial2 {
  var displayString: String {
    let a0 = self.a0.formatted()
    let a1 = self.a1.formatted()
    let a2 = self.a2.formatted()
    return "\(a2)x\u{00B2} + \(a1)x + \(a0)"
  }
}

extension Function.Polynomial3 {
  var displayString: String {
    let a0 = self.a0.formatted()
    let a1 = self.a1.formatted()
    let a2 = self.a2.formatted()
    let a3 = self.a2.formatted()
    return "\(a3)x\u{00B3} + \(a2)x\u{00B2} + \(a1)x + \(a0)"
  }
}

extension Function.Power {
  var displayString: String {
    let coefficient = self.coefficient.formatted()
    let exponent = self.exponent.formatted()
    return "\(coefficient) * x^\(exponent)"
  }
}

extension Function.Exponential {
  var displayString: String {
    let coefficient = self.coefficient.formatted()
    let exponentCoefficient = self.exponentCoefficient.formatted()
    return "\(coefficient) * e^\(exponentCoefficient)x"
  }
}

extension Function.Logarithmic {
  var displayString: String {
    let coefficient = self.coefficient.formatted()
    let freeCoefficient = self.freeCoefficient.formatted()
    return "\(coefficient) * ln(x) + \(freeCoefficient)"
  }
}
