import UIKit

class AddWordViewController: UIViewController {

    let sectionTitleArray = ["単語", "意味", "カテゴリ", "例文", "例文(日本語訳)"]
    
    var word : String = ""
    var meaning: String = ""
    var exampleSentence: String = ""
    var exampleTranslation: String = ""
    
    var myModel: EnglishWordsModel? {
        didSet {
            registerModel()
        }
    }

    override func loadView() {
        self.view = AddWordView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable()
    }
    
    private func settingTable(){
        let view = self.view as! AddWordView
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        myModel?.addWordList(
            registeredWord: Word.init(
                id: 99999,
                word: word,
                meaning: meaning,
                exampleSentence: exampleSentence,
                exampleTranslation: exampleTranslation,
                wordCategory: [],
                level: 0,
                isSolved: false,
                isSoftDeleted: false))}
}

extension AddWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if indexPath.row % 2 != 0 {
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section]
    }
}


extension AddWordViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
     
    func tableView(_ table: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
        // TO-DO: Categoryだけ動的に変更できるようにする
        return 2
    }
    
}
