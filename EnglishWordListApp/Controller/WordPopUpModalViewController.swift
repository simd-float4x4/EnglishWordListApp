import UIKit

class WordPopUpModalViewController: UIViewController {
    
    var word: String = ""
    var meaning: String = ""
    var exampleSentence: String = ""
    var exampleTranslation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wordPopUpView = WordPopUp()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(onTapRemoveView))
        wordPopUpView.cancelView.addGestureRecognizer(tapGestureRecognizer)
        wordPopUpView.wordLabel.text = word + "\n" + meaning
        wordPopUpView.wordExampleSentence.text = exampleSentence
        wordPopUpView.wordExampleSentenceTranslation.text = exampleTranslation
        self.view = wordPopUpView
    }
    
    @objc func onTapRemoveView() {
        dismiss(animated: true)
    }
}
