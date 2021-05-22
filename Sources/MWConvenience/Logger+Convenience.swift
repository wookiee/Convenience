
import OSLog

public extension Logger {
    init(category: String) {
        self.init(subsystem: "\(ProcessInfo().processName)[\(Bundle.main.bundleIdentifier ?? "unknown bundle")]",
                  category: category)
    }
}
