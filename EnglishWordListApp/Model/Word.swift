import UIKit

struct Word {
    let id: Int
    var word: String
    var meaning: String
    var exampleSentence: String
    var exampleTranslation: String
    var wordCategory: [String]
    var level: Int
    var isSolved: Bool
    var isSoftDeleted: Bool
}
