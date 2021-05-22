
public extension Int {

    /// Generate an array of values produced by executing the provided closure `self` times.
    func of<Value>(_ value: @autoclosure () throws -> Value) rethrows -> [Value] {
        return try (1...self).map { _ in try value() }
    }
    
    /// Execute the provided closure `self` times.
    func times(_ execute: @autoclosure () throws -> Void) rethrows {
        try (1...self).forEach { _ in try execute() }
    }
}
