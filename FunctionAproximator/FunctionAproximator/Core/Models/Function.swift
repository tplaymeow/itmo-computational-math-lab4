enum Function: Equatable, Hashable {
  struct Linear: Equatable, Hashable {
    let a0: Double
    let a1: Double
  }

  struct Polynomial2: Equatable, Hashable {
    let a0: Double
    let a1: Double
    let a2: Double
  }

  struct Polynomial3: Equatable, Hashable {
    let a0: Double
    let a1: Double
    let a2: Double
    let a3: Double
  }

  struct Power: Equatable, Hashable {
    let coefficient: Double
    let exponent: Double
  }

  struct Exponential: Equatable, Hashable {
    let coefficient: Double
    let exponentCoefficient: Double
  }

  struct Logarithmic: Equatable, Hashable {
    let coefficient: Double
    let freeCoefficient: Double
  }

  case linear(Linear)
  case polynomial2(Polynomial2)
  case polynomial3(Polynomial3)
  case power(Power)
  case exponential(Exponential)
  case logarithmic(Logarithmic)
}
