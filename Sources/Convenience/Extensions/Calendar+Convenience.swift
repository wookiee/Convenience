
import Foundation

extension Calendar {
    
    /// Compute the number of days from one `Date` to another in terms of a human-centric understanding of calendar dates, accounting for partial days.
    ///
    /// When computing the distance between two dates in a human-friendly way, it is important to account correctly for partial days.
    /// Use this method instead of `dateComponents(_:from:to:)` in cases where you expect a `Date` at 12:01am tomorrow to be "1 day" from a `Date` at 11:59pm today.
    /// - Parameters:
    ///   - startDate: The earlier of the two dates whose distance is being computed
    ///   - endDate: Theh later of the two dates whose distance is being computed
    /// - Returns: the integer number of days from `startDate` to `endDate`, accounting for partial days.
    func days(from startDate: Date, to endDate: Date) -> Int {
        let startInEra = Calendar.current.ordinality(of: .day, in: .era, for: startDate)!
        let endInEra = Calendar.current.ordinality(of: .day, in: .era, for: endDate)!
        let distance = endInEra - startInEra
        return distance
    }
    
    
    /// Compute the distance from one `Date` to another in terms of a human-centric understanding of calendar dates, accounting for partial days, returning year, month, and day calendar components.
    ///
    /// When computing the distance between two dates in a human-friendly way, it is important to account correctly for partial days.
    /// Use this method instead of `dateComponents(_:from:to:)` in cases where you expect a `Date` at 12:01am tomorrow to be "1 day away" from a `Date` at 11:59pm today.
    /// - Parameters:
    ///   - startDate: The earlier of the two dates whose distance is being computed
    ///   - endDate: Theh later of the two dates whose distance is being computed
    /// - Returns: A `DateComponents` with only `year`, `month`, and `day` representing the distance from `startDate` to `endDate`.
    func cardinalComponents(from startDate: Date, to endDate: Date) -> DateComponents {
        let endDateComponents = Calendar.current.dateComponents([.year,.month,.day],
                                                                from: endDate)
        let startDateComponents = Calendar.current.dateComponents([.year,.month,.day],
                                                              from: startDate)
        let distanceComponents = Calendar.current.dateComponents([.year,.month,.day],
                                                                 from: startDateComponents,
                                                                 to: endDateComponents)
        return distanceComponents
    }
    
}
