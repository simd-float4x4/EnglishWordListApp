import UIKit

class WordPopUp: UIView {
    @IBOutlet weak var cancelView: UIView!
   
   override init(frame: CGRect){
       super.init(frame: frame)
       loadNib()
   }

   required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)!
       loadNib()
   }

   func loadNib(){
       let view = Bundle.main.loadNibNamed("WordPopUp", owner: self, options: nil)?.first as! UIView
       view.frame = self.bounds
       self.addSubview(view)
   }
}

