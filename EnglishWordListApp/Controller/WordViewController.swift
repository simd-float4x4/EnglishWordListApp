import UIKit
import Foundation

class WordViewController: UIViewController {
    
    var isTranslationShowed: Bool = true
    var isDeleteModeActivated: Bool = false
    
    var word : String = ""
    var meaning: String = ""
    var exampleSentence: String = ""
    var exampleTranslation: String = ""

    var myModel: EnglishWordsModel?
    
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
    
    @objc func onTapTableViewCell() {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }
    
    @objc func onTapRemoveView() {
        dismiss(animated: true)
    }
    
    @IBAction func onTapToAddWordView() {
        performSegue(withIdentifier: "toAddWordView", sender: nil)
    }
    
    @IBAction func toggleDeleteModeOnOff() {
        isDeleteModeActivated = isDeleteModeActivated == true ? false : true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalSegue" {
            let vc = segue.destination as! WordPopUpModalViewController
            vc.word = word
            vc.meaning = meaning
            vc.exampleSentence = exampleSentence
            vc.exampleTranslation = exampleTranslation
        }
    }
}

extension WordViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var action = UIContextualAction()
        
        switch isDeleteModeActivated {
        case true :
            action =  UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
                completionHandler(true)
                self.myModel?.removeWordList(index: indexPath.row)
                tableView.reloadData()
              }
            action.backgroundColor = UIColor.red
        case false :
            action =  UIContextualAction(style: .destructive, title: "覚えた") { (action, view, completionHandler) in
                completionHandler(true)
              }
            action.backgroundColor = UIColor.blue
        }
        return UISwipeActionsConfiguration(actions: [action])
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweetModel = myModel?.wordList[indexPath.row]
        word = tweetModel?.word.english ?? ""
        meaning = tweetModel?.word.meaning ?? ""
        exampleSentence = tweetModel?.word.exampleSentence ?? ""
        exampleTranslation = tweetModel?.word.exampleSentenceMeaning ?? ""
        self.onTapTableViewCell()
    }
}
