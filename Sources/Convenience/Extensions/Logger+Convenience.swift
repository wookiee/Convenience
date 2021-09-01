
import OSLog

public extension Logger {
    init(_ category: String) {
        self.init(subsystem: "\(ProcessInfo().processName)[\(Bundle.main.bundleIdentifier ?? "unknown bundle")]",
                  category: category)
    }
}
