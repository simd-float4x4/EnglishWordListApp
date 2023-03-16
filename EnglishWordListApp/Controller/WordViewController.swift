import UIKit
import Foundation

class WordViewController: UIViewController {
    
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
        self.view = WordView()
        
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
        // Modelでタップされた時の追加処理を行う。
        tableView.deselectRow(at: indexPath, animated: true)
        self.onTapTableViewCell()
    }
}
