import UIKit

class WordPopUpModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    
    func popUp(){
        performSegue(withIdentifier: "toWordPopUpModal", sender: nil)
    }
}
