import Foundation

class VisibilityManager {
    var isTranslationVisible: Bool = true
    
    func switchTranslationVisibility() {
        isTranslationVisible = isTranslationVisible == true ? false : true
    }
    
    func getCurrentTranslationVisibility() -> Bool {
        return isTranslationVisible
    }
}
