import Foundation
import UIKit

class EnglishWordsDataModel {
    let word: Word
    
    init(englishWord: Word){
        word = englishWord
    }
}

class EnglishWordsModel: NSObject,UITableViewDataSource {
    
    let notificationCenter = NotificationCenter()
    
    private(set) var wordList: [EnglishWordsDataModel] = [
        EnglishWordsDataModel.init(
            englishWord: Word(
                english: "accentuate",
                meaning: "強調する",
                exampleSentence: "This picture was taken in the evening to accentuate the shows of ancient remains.",
                exampleSentenceMeaning: "この写真は古代遺物の出現を強調するために夕方撮影された。",
                wordCategory: ["動詞", "頻出単語", "ニガテ"],
                level: 0,
                isSolved: false)
        ),
    ]{
        didSet{
            notificationCenter.post(name: .init(rawValue: "changeWordList"), object: nil, userInfo: ["list" : wordList])
        }
    }
    
    func addWordList(registeredWord: Word) {
        self.wordList.append(EnglishWordsDataModel.init(englishWord: registeredWord))
    }
    
    
    // MARK: UITableViewDatasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let tweetModel = self.wordList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = tweetModel.word.english
        content.secondaryText = tweetModel.word.meaning
        cell.contentConfiguration = content
        return cell
    }
}
