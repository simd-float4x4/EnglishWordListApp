import UIKit
import Foundation

class WordViewController: UIViewController {
    
    var isTranslationShowed: Bool = true
    
    @IBOutlet var inputEnglishWordField: UITextField!
    @IBOutlet var inputEnglishMeaningField: UITextField!
    @IBOutlet var inputEnglishExampleSentenceField: UITextField!
    @IBOutlet var inputEnglishExampleSentenceMeaningField: UITextField!
    @IBOutlet var inputEnglishWordCategoryField: UITextField!
    @IBOutlet var inputEnglishWordLevelField: UITextField!

    var myModel: EnglishWordsModel? {
        didSet {
            registerModel()
        }
    }
    
    override func loadView() {
        super.loadView()
        let wordView = WordView()
        self.view = wordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myModel = EnglishWordsModel()
        settingTableView()
    }
    
    private func settingTableView () {
        let wordView = self.view as! WordView
        wordView.tableView.delegate = self
        wordView.tableView.dataSource = self.myModel
        wordView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchCurrentProgessInfo(view: wordView)
    }
    
    private func fetchCurrentProgessInfo(view: WordView) {
        // 解答問題数
        let solvedCount = 1
        let sumQuestion = myModel?.wordList.count ?? 0
        let sumCurrent = String(solvedCount) + "/" + String(sumQuestion)
        // 解答問題のパーセンテージ数
        
        // TO-DO: エラーで片方取得できなかった場合の例外処理
        let progressPercentage = solvedCount * 100 / sumQuestion
        let progress = String(progressPercentage) + "%"
        view.progressWordsSumLabel.text = sumCurrent
        view.progressPercentageLabel.text = progress
    }
    
    @objc func registerModel(){
        guard let model = myModel else { return }
        
        model.notificationCenter.addObserver(forName: .init(rawValue: "changeTweetList"),
                                            object: nil,
                                            queue: nil,
                                            using: {
            [unowned self] notification in
            let wordView = self.view as! WordView
             
            wordView.tableView.reloadData()
         })
    }
    
    @objc func registerWordButton() {
        var wordCategories: [String] = []
        wordCategories.append(inputEnglishWordCategoryField.text ?? "")
        myModel?.addWordList(
            registeredWord: Word.init(
                english: inputEnglishWordField.text ?? "",
                meaning: inputEnglishMeaningField.text ?? "",
                exampleSentence: inputEnglishExampleSentenceField.text ?? "",
                exampleSentenceMeaning: inputEnglishExampleSentenceMeaningField.text ?? "",
                wordCategory: wordCategories,
                level: 0,
                isSolved: false))}
    
    @objc func onTapTableViewCell() {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }
    
    @objc func onTapRemoveView() {
        dismiss(animated: true)
    }
    
    @IBAction func onTapToAddWordView() {
        performSegue(withIdentifier: "toAddWordView", sender: nil)
    }
}

extension WordViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

       let deleteAction = UIContextualAction(style: .destructive, title: "Remembered!") { (action, view, completionHandler) in
         completionHandler(true)
       }
        
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.onTapTableViewCell()
    }
}
