import Nest

public typealias Test = (RequestType) -> Bool

public struct Route<P> {
  let method: HTTPMethod
  let test: Test?
  let path: Path
  let payload: P
}
