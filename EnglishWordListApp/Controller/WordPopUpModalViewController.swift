import UIKit

class WordPopUpModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let wordPopUpView = WordPopUp()
        self.view = wordPopUpView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(onTapRemoveView))
        wordPopUpView.cancelView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func onTapRemoveView() {
        dismiss(animated: true)
    }
}
