import XCTest
@testable import Convenience

struct ThingStruct: Codable, Equatable {
    var number = 1
    var name = "Hello"
}

struct ThingClass: Codable, Equatable {
    var number = 1
    var name = "Hello"
}

final class UserDefaultTests: XCTestCase {

    @UserDefault(key: "ConvenienceTests_stringDefault") var stringDefault: String?
    @UserDefault(key: "ConvenienceTests_doubleDefault") var doubleDefault: Double?
    @UserDefault(key: "ConvenienceTests_thingStructDefault") var thingStructDefault: ThingStruct?
    @UserDefault(key: "ConvenienceTests_thingClassDefault") var thingClassDefault: ThingClass?

    func testStoreAndRetrieveStringDefault() throws {
        let valueIn = "Hello"
        stringDefault = valueIn
        let valueOut = stringDefault
        XCTAssertEqual(valueIn, valueOut)
    }
    
    func testStoreAndRetrieveDoubleDefault() throws {
        let valueIn = 42.0
        doubleDefault = valueIn
        let valueOut = doubleDefault
        XCTAssertEqual(valueIn, valueOut)
    }
    
    func testStoreAndRetrieveThingStructDefault() throws {
        let valueIn = ThingStruct()
        thingStructDefault = valueIn
        let valueOut = thingStructDefault
        XCTAssertEqual(valueIn, valueOut)
    }
    
    func testStoreAndRetrieveThingClassDefault() throws {
        let valueIn = ThingClass()
        thingClassDefault = valueIn
        let valueOut = thingClassDefault
        XCTAssertEqual(valueIn, valueOut)
    }
    
}
