
import Foundation

extension String {
    private static let capChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let chars = "abcdefghijklmnopqrstuvwxyz"
    
    public static func randomTitle(wordCount: Int) -> String {
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
    
    public static func randomTitle(wordCount: ClosedRange<Int>) -> String {
        let actualCount = Int.random(in: wordCount)
        return randomTitle(wordCount: actualCount)
    }
}
