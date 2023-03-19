import UIKit

struct Word {
    let english: String // 変えたい
    let meaning: String
    let exampleSentence: String
    let exampleSentenceMeaning: String // translationにしたい
    let wordCategory: [String]
    let level: Int
    let isSolved: Bool
    // 論理削除フラグを増やしたい
}
