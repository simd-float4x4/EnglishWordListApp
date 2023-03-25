import UIKit

class AddWordViewController: UIViewController, UIGestureRecognizerDelegate {

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
        super.loadView()
        let wordView = AddWordView()
        self.view = wordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myModel = EnglishWordsModel()
        settingTable()
    }
    
    
    private func settingTable(){
        let view = self.view as! AddWordView
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.tableFooterView = UIView()
        view.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.controller = self
    }
    
    
    ///
    /// Notificationに変更を送り、tableViewを更新するファンクション
    ///
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
    
    
    ///
    /// 単語を登録する
    ///
    @IBAction func registerWord() {
        myModel?.addWordList(
            registeredWord: Word.init(
                id: 99999,
                word: "affiliate",
                meaning: "〜を連携させる",
                exampleSentence: "In the States, doctors have their own offices and most are affiliated with a hospital within the area.",
                exampleTranslation: "アメリカの医者は自分の診療所を持っていても、大抵は地域のどこかの病院に所属しています。",
                wordCategory: [],
                level: 0,
                isSolved: false,
                isSoftDeleted: false))
        registerModel()
    }
    
    func addWord() {
        // 単語を追加する処理を実行する
        // TO-DO: Viewのボタンが押下できない不具合の修正
        print("Add word")
    }
}

extension AddWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
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
        // TO-DO: if文を使い、Categoryだけ動的に変更できるようにする
        return 1
    }
    
    
    ///
    /// TableViewが選択された時の挙動
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

