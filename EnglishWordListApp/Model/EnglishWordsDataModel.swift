import Foundation
import UIKit

class EnglishWordsDataModel {
    var word: Word
    
    init(englishWord: Word){
        word = englishWord
    }
}

class EnglishWordsModel: NSObject, UITableViewDataSource {
    
    let notificationCenter = NotificationCenter()
    
    private(set) var wordList: [EnglishWordsDataModel] = [
        EnglishWordsDataModel.init(
            englishWord: Word(
                id: 1,
                word: "accentuate",
                meaning: "強調する",
                exampleSentence: "This picture was taken in the evening to accentuate the shows of ancient remains.",
                exampleTranslation: "この写真は古代遺物の出現を強調するために夕方撮影された。",
                wordCategory: ["動詞", "頻出単語", "ニガテ"],
                level: 0,
                isSolved: false,
                isSoftDeleted: false)
        ),
        EnglishWordsDataModel.init(
            englishWord: Word(
                id: 2,
                word: "culminate",
                meaning: "締め括る／最高潮に達する",
                exampleSentence: "The ceremony was culminated with the national anthem.",
                exampleTranslation: "その式典は国歌斉唱で締めくくられた。",
                wordCategory: ["動詞", "ニガテ"],
                level: 0,
                isSolved: false,
                isSoftDeleted: false)
        ),
        EnglishWordsDataModel.init(
            englishWord: Word(
                id: 3,
                word: "protectionism",
                meaning: "保護主義",
                exampleSentence: "The country denounced Japan's protectionism to conceal its own lack of economic policy.",
                exampleTranslation: "その国は自らの経済的な無策を隠すために日本の保護貿易主義を非難しました。",
                wordCategory: ["名詞", "政治・経済"],
                level: 0,
                isSolved: false,
                isSoftDeleted: false)
        ),
    ]{
        didSet{
            notificationCenter.post(name: .init(rawValue: "changeWordList"), object: nil, userInfo: ["list" : wordList])
        }
    }
    
    func addWordList(registeredWord: Word) {
        self.wordList.append(EnglishWordsDataModel.init(englishWord: registeredWord))
    }
    
    func removeWordList(index: Int) {
        self.wordList.remove(at: index)
    }
    
    
    // MARK: UITableViewDatasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetModel = self.wordList[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if tweetModel.word.isSoftDeleted == false {
            var content = cell.defaultContentConfiguration()
            content.text = tweetModel.word.word
            content.secondaryText = tweetModel.word.meaning
            cell.contentConfiguration = content
            return cell
        }
        return cell
    }
}
