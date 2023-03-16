import UIKit

class WordView: UIView {
   @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressWordsSumLabel: UILabel!
    @IBOutlet weak var progressPercentageLabel: UILabel!
   
   override init(frame: CGRect){
       super.init(frame: frame)
       loadNib()
   }

   required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)!
       loadNib()
   }

   func loadNib(){
       let view = Bundle.main.loadNibNamed("WordView", owner: self, options: nil)?.first as! UIView
       view.frame = self.bounds
       self.addSubview(view)
   }

}

