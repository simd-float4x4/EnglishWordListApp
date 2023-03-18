import UIKit

class AddWordViewController: UIViewController {

    let sectionTitleArray = ["単語", "意味", "カテゴリ", "例文", "例文(日本語訳)"]

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

}

extension AddWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        let tweetModel = self.wordList[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = tweetModel.word.english
//        let vM = VisibilityManager()
//        let currentTranslationVisibility = vM.getCurrentTranslationVisibility()
//        content.secondaryText = currentTranslationVisibility == true ? tweetModel.word.meaning : ""
//        cell.contentConfiguration = content
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
        return 1
    }
    
}
