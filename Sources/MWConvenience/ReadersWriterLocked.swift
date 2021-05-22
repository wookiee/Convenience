
import Foundation

@propertyWrapper
public class ReadersWriterLocked<Value> {
    
    private var value: Value
    private let q = DispatchQueue(label: "LockedWrapper", qos: .userInteractive, attributes: .concurrent)

    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    public var wrappedValue: Value {
        get { q.sync { value } }
        set { q.sync(flags: .barrier) { value =  newValue } }
    }
    
    public var projectedValue: ReadersWriterLocked<Value> { self }
}
