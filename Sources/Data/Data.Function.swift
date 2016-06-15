//MARK: id
public func id<A>(_ a: A)->A {
    return a
}

public func id<A, B>(_ a: (A)->B)->(A)->B {
    return a
}

//MARK: const
public func const<A, B>(_ a: A, _ b: B) -> A {
    return a
}

public func const<A, B>(_ a: A) -> (B) -> A {
    return { (b: B) -> A in
        return a
    }
}

//MARK flip :: (a -> b -> c) -> b -> a -> c
public func flip<A, B, C>(_ f: (A, B) -> C) -> (B, A) -> C {
    let g = { (b: B,  a: A) -> C in
        let result = f(a, b)
        return result
    }
    return g
}
//MARK: <<<
//the left takes the right as its argument
infix operator <<< {}
func <<< <A, B>(f: (A)->B, g: A) -> B {
    return f(g)
}

//MARK: function composition
infix operator • { associativity right precedence 100}
func •<A,B,C>(f2: (B)->C, f1: (A)->B) -> ((A)->C) {
    return { (x: A) in f2(f1(x)) }
}

infix operator .. { associativity right precedence 100}
//A->B->C
public func ..<A,B,C>(f2: (B)->C, f1: (A)->B) -> ((A)->C) {
    return { (x: A) in f2(f1(x)) }
}

//A->B-C?
public func ..<A,B,C>(f2: (B)->C?, f1: (A)->B) -> ((A)->C?) {
    return { (x: A) in f2(f1(x)) }
}

//A->B?-C
public func ..<A,B,C>(f2: (B?)->C, f1: (A)->B?) -> ((A)->C) {
    return { (x: A) in f2(f1(x)) }
}

//A->B?-C?
public func ..<A,B,C>(f2: (B?)->C?, f1: (A)->B?) -> ((A)->C?) {
    return { (x: A) in f2(f1(x)) }
}

//A?->B->C
public func ..<A,B,C>(f2: (B)->C, f1: (A?)->B) -> ((A?)->C) {
    return { (x: A?) in f2(f1(x)) }
}

//A?->B->C?
public func ..<A,B,C>(f2: (B)->C?, f1: (A?)->B) -> ((A?)->C?) {
    return { (x: A?) in f2(f1(x)) }
}

//A?->B?->C
public func ..<A,B,C>(f2: (B?)->C, f1: (A?)->B?) -> ((A?)->C) {
    return { (x: A?) in f2(f1(x)) }
}

//A?->B?->C?
public func ..<A,B,C>(f2: (B?)->C?, f1: (A?)->B?) -> ((A?)->C?) {
    return { (x: A?) in f2(f1(x)) }
}

//MARK: on
func on<A, B, C>(_ g: (B,B)->C, _ f: (A)->B)->(A,A)->C {
    return {(x: A, y: A) -> C in
        return g(f(x), f(y))
    }
}
