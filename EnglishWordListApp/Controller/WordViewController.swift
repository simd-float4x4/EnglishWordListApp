import UIKit
import Foundation

class WordViewController: UIViewController {
    
    var isTranslationShowed: Bool = true
    var isDeleteModeActivated: Bool = false
    
    var solvedCount = 0
    
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
    
    ///
    /// TableViewの初期化、およびデータのセットアップ
    ///
    private func settingTableView () {
        let wordView = self.view as! WordView
        wordView.tableView.delegate = self
        wordView.tableView.dataSource = self.myModel
        wordView.tableView.tableFooterView = UIView()
        wordView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchCurrentProgessInfo(view: wordView)
    }
    
    ///
    /// ProgressBarの最新情報を取得するメソッド
    ///
    private func fetchCurrentProgessInfo(view: WordView) {
        // 解答問題数
        let sumQuestion = (myModel?.wordList.count ?? 0) + solvedCount
        let sumCurrent = String(solvedCount) + "/" + String(sumQuestion)
        
        // TO-DO: エラーで片方取得できなかった場合の例外処理
        let progressPercentage = solvedCount * 100 / sumQuestion
        let progress = String(progressPercentage) + "%"
        // 解答問題のパーセンテージ数
        view.progressBarWidget.setProgress(Float(progressPercentage)/100, animated: true)
        view.progressBarWidget.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        view.progressWordsSumLabel.text = sumCurrent
        view.progressPercentageLabel.text = progress
    }
    
    ///
    /// TableViewを更新するメソッド
    ///
    func reloadData() {
        let wordView = self.view as! WordView
        wordView.tableView.reloadData()
        fetchCurrentProgessInfo(view: wordView)
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
    
    ///
    /// 単語タップ時に単語表示画面に値を渡すためのメソッド
    ///
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
    
    // TableViewセルのスワイプ時の挙動
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var action = UIContextualAction()
        
        switch isDeleteModeActivated {
        case true :
            // 削除モードON
            action =  UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
                completionHandler(true)
                self.myModel?.removeWordList(index: indexPath.row)
                self.reloadData()
              }
            action.backgroundColor = UIColor.red
        case false :
            // 暗記モードON
            action =  UIContextualAction(style: .destructive, title: "覚えた") { (action, view, completionHandler) in
                completionHandler(true)
                self.myModel?.wordList[indexPath.row].word.isSoftDeleted = true
                self.myModel?.removeWordList(index: indexPath.row)
                self.solvedCount += 1
                self.reloadData()
              }
            action.backgroundColor = UIColor.blue
        }
        return UISwipeActionsConfiguration(actions: [action])
     }
    
    ///
    /// TableViewが選択された時の挙動
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweetModel = myModel?.wordList[indexPath.row]
        word = tweetModel?.word.word ?? ""
        meaning = tweetModel?.word.meaning ?? ""
        exampleSentence = tweetModel?.word.exampleSentence ?? ""
        exampleTranslation = tweetModel?.word.exampleTranslation ?? ""
        self.onTapTableViewCell()
    }
}
