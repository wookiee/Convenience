
public extension Int {

    /// Generate an array of values produced by executing the provided closure `self` times.
    /// Example: `let mockData = 50.of { Model.random() }`
    func of<Value>(_ value: () throws -> Value) rethrows -> [Value] {
        return try (1...self).map { _ in try value() }
    }
    
    /// Execute the provided closure `self` times.
    /// Example: `10.times { runSelfTest() }`
    func times(_ execute: () throws -> Void) rethrows {
        try (1...self).forEach { _ in try execute() }
    }
}
