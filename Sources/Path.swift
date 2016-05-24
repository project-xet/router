public struct Path {
  private let components: [PathComponent]

  public var isEmpty: Bool {
    return components.isEmpty
  }

  public var hasParams: Bool {
    return components.contains { c in
      switch c {
        case .Param: return true
        default: return false
      }
    }
  }

  public func render(_ params: [String: String] = [:]) -> String {
    guard (hasParams && allParamValues(params)) || !hasParams else { return "" }

    let output: [String] = components.map { component in
      switch component {
        case let .Static(value): return value
        case let .Param(label): return params[label]!
        case .Slash: return "/"
      }
    }

    return (["/"] + output).joined(separator: "")
  }

  private func allParamValues(_ params: [String: String]) -> Bool {
    for component in components {
      switch component {
        case let .Param(label) where params[label] == nil:
          return false
        default:
          // no op
          true
      }
    }

    return true
  }
}

public enum PathComponent {
  case Static(value: String)
  case Slash
  case Param(label: String)
}

public protocol PathConvertible {
  func toPath() -> Path
}

extension PathComponent: PathConvertible {
  public func toPath() -> Path {
    return Path(components: [self])
  }
}

extension Path: PathConvertible {
  public func toPath() -> Path {
    return self
  }
}

extension String: PathConvertible {
  public func toPath() -> Path {
    return Path(components: [.Static(value: self)])
  }
}

extension Int: PathConvertible {
  public func toPath() -> Path {
    return Path(components: [.Static(value: String(self))])
  }
}

extension Double: PathConvertible {
  public func toPath() -> Path {
    return Path(components: [.Static(value: String(self))])
  }
}

public func /(lhs: PathConvertible, rhs: PathConvertible) -> Path {
  let lhp = lhs.toPath()
  let rhp = rhs.toPath()

  guard !lhp.isEmpty else { return rhp }
  guard !rhp.isEmpty else { return lhp }

  return Path(components: lhp.components + [.Slash] + rhp.components)
}

public func param(_ label: String) -> PathComponent {
  return PathComponent.Param(label: label)
}

public func +(lhs: PathConvertible, rhs: PathConvertible) -> Path {
  let lhp = lhs.toPath()
  let rhp = rhs.toPath()

  guard !lhp.isEmpty else { return rhp }
  guard !rhp.isEmpty else { return lhp }

  return Path(components: lhp.components + rhp.components)
}

public let format = Path(components: [.Static(value: "."), .Param(label: "format")])
public let root = Path(components: [])
