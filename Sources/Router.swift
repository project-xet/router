import Nest

public struct Router<P> {
  public let routes: [Route<P>]

  public init(_ routes: Route<P>...) {
    self.routes = routes
  }

  public init(_ routes: [Route<P>]) {
    self.routes = routes
  }

  public func match(_ request: RequestType) -> Route<P>? {
    return nil
  }
}

public func get<P>(_ path: Path, test: Test? = nil, payload: P) -> Route<P> {
  return Route<P>(
    method: .GET,
    test: test,
    path: path,
    payload: payload
  )
}

public func post<P>(_ path: Path, test: Test? = nil, payload: P) -> Route<P> {
  return Route<P>(
    method: .POST,
    test: test,
    path: path,
    payload: payload
  )
}

public func put<P>(_ path: Path, test: Test? = nil, payload: P) -> Route<P> {
  return Route<P>(
    method: .PUT,
    test: test,
    path: path,
    payload: payload
  )
}

public func delete<P>(_ path: Path, test: Test? = nil, payload: P) -> Route<P> {
  return Route<P>(
    method: .DELETE,
    test: test,
    path: path,
    payload: payload
  )
}
