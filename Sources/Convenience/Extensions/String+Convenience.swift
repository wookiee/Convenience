
import Foundation

extension String {
    private static let capChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let chars = "abcdefghijklmnopqrstuvwxyz"
    
    static func randomTitle() -> String {
        let wordCount = Int.random(in: 2...6)
        let phrase = (1...wordCount).map { _ -> String in
            let charCount = Int.random(in: 1...7)
            var str = String(capChars.randomElement()!)
            for _ in (1...charCount) {
                str += String(chars.randomElement()!)
            }
            return str
        }.reduce("", {$0 + " " + $1})
        return phrase
    }
}
