import Foundation

final class RecipesPresenter {
//    weak var view:
    private var recipes: [RecipesViewModel] = [
        RecipesViewModel(title: "Макароны с котлеткой"),
        RecipesViewModel(title: "Капуста не красная")
    ]
}

extension RecipesPresenter: RecipesViewOutput {
    func didLoadView() {
    }
    
    func count() -> Int {
        return recipes.count
    }
    
    func item(idx: Int) -> RecipesViewModel {
        return recipes[idx]
    }
    
}
