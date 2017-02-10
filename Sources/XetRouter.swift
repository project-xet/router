import Foundation

// Segment needs to be equatable in order to allow paths to be checked
// against one another.
protocol Segment {
    func describe() -> String
}

struct Path<Builder> {
    let segments: [Segment]
    let build: Builder
}

extension Path {
    func describe() -> String {
        return "/" + segments.map { $0.describe() }.joined(separator: "/")
    }
}

struct Fixed<T: Equatable>: Segment {
    let value: T

    func describe() -> String {
        return String(describing: value)
    }
}

extension Fixed {
    init(_ value: T) {
        self.value = value
    }
}

struct Param<T: Equatable>: Segment {
    let name: String

    func describe() -> String {
        return "<\(name):\(T.self)>"
    }
}

extension Param {
    init(_ name: String) {
        self.name = name
    }
}

// OPERATORS
typealias PathZero = Path<() -> String>
typealias PathOne<A> = Path<(A) -> String>
typealias PathTwo<A, B> = Path<(A, B) -> String>
typealias PathThree<A, B, C> = Path<(A, B, C) -> String>
typealias PathFour<A, B, C, D> = Path<(A, B, C, D) -> String>
typealias PathFive<A, B, C, D, E> = Path<(A, B, C, D, E) -> String>
typealias PathSix<A, B, C, D, E, F> = Path<(A, B, C, D, E, F) -> String>
typealias PathSeven<A, B, C, D, E, F, G> = Path<(A, B, C, D, E, F, G) -> String>
typealias PathEight<A, B, C, D, E, F, G, H> = Path<(A, B, C, D, E, F, G, H) -> String>
typealias PathNine<A, B, C, D, E, F, G, H, I> = Path<(A, B, C, D, E, F, G, H, I) -> String>
typealias PathTen<A, B, C, D, E, F, G, H, I, J> = Path<(A, B, C, D, E, F, G, H, I, J) -> String>

func / <A, B>(lhs: Fixed<A>, rhs: Fixed<B>) -> PathZero {
    return Path(segments: [lhs, rhs]) {
        return "\(lhs.value)/\(rhs.value)"
    }
}

func / <A, B>(lhs: Fixed<A>, rhs: Param<B>) -> PathOne<B> {
    return PathOne<B>(segments: [lhs, rhs]) { b in
        return "\(lhs.value)/\(b)"
    }
}

func / <A, B>(lhs: Param<A>, rhs: Fixed<B>) -> PathOne<A> {
    return Path(segments: [lhs, rhs]) { a in
        return "\(a)/\(rhs.value)"
    }
}

func / <A, B>(lhs: PathOne<A>, rhs: Fixed<B>) -> PathOne<A> {
    return Path(segments: lhs.segments + [rhs]) { a in
        return "\(lhs.build(a))/\(rhs.value)"
    }
}

// Path + Param

func / <A>(lhs: PathZero, rhs: Param<A>) -> PathOne<A> {
    return Path(segments: lhs.segments + [rhs]) { b in
        return "\(lhs.build())/\(b)"
    }
}

func / <A, B>(lhs: PathOne<A>, rhs: Param<B>) -> PathTwo<A, B> {
    return Path(segments: lhs.segments + [rhs]) { a, b in
        return "\(lhs.build(a))/\(b)"
    }
}

func / <A, B, C>(lhs: PathTwo<A, B>, rhs: Param<C>) -> PathThree<A, B, C> {
    return Path(segments: lhs.segments + [rhs]) { a, b, c in
        return "\(lhs.build(a, b))/\(c)"
    }
}

func / <A, B, C, D>(lhs: PathThree<A, B, C>, rhs: Param<D>) -> PathFour<A, B, C, D> {
    return Path(segments: lhs.segments + [rhs]) { a, b, c, d in
        return "\(lhs.build(a, b, c))/\(d)"
    }
}

func / <A, B, C, D, E>(lhs: PathFour<A, B, C, D>, rhs: Param<E>) -> PathFive<A, B, C, D, E> {
    return Path(segments: lhs.segments + [rhs]) { a, b, c, d, e in
        return "\(lhs.build(a, b, c, d))/\(e)"
    }
}

func / <A, B, C, D, E, F>(lhs: PathFive<A, B, C, D, E>, rhs: Param<F>) -> PathSix<A, B, C, D, E, F> {
    return Path(segments: lhs.segments + [rhs]) { a, b, c, d, e, f in
        return "\(lhs.build(a, b, c, d, e))/\(f)"
    }
}
