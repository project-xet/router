import XetRouter
import Nest
import XCTest

struct Paths {
  static let users      = root / "users"
  static let user       = users / param("id")
  static let editUser   = users / param("id") / "edit"
  static let deleteUser = users / param("id") / "delete"
  static let newUser    = users / "new"
}

class PathTests: XCTestCase {

}
