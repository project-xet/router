

func integer(_ int: Int) -> String {
  return String(describing: int)
}

func string(_ str: String) -> String {
  return str
}

// (Int) -> (String) -> String


func / <A, B>(lhs: @escaping (A) -> String, rhs: @escaping (B) -> String) -> (A) -> (B) -> String {
  return { a in
    return { b in
      return lhs(a) + "/" + rhs(b)
    }
  }
}

let composed = integer / string
let result = composed(1)("no")

print(result)


// Call
// produce a function
// Call
// produce a function
// Call
// generate string


struct P<Input, Result> {
  let call: (Input) -> Result
}
