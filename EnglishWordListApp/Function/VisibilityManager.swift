import Foundation

class VisibilityManager {
    var isTranslationVisible: Bool = true
    
    func switchTranslationVisibility(currentVisibility: Bool) {
        isTranslationVisible = currentVisibility == true ? false : true
    }
    
    func getCurrentTranslationVisibility() -> Bool {
        return isTranslationVisible
    }
    
}
