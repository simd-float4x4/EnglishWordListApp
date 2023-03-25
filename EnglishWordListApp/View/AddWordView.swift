import UIKit

class AddWordView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var registerButton: UIButton!
    
    weak var controller: AddWordViewController?
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        // Controllerのメソッドを呼び出す
        controller?.addWord()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
        print("a")
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib(){
        let view = Bundle.main.loadNibNamed("AddWordView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        print("c")
    }

}
