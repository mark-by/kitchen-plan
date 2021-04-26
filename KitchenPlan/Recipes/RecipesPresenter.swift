import UIKit

final class RecipesPresenter {
//    weak var view:
    private var recipes: [RecipesViewModel] = [
        RecipesViewModel(title: "Жаренная картошка с грибами и сыром", timeToCook: "50 мин", image: UIImage(data: Data.init(base64Encoded: base64ImagePotato)!)!),
        RecipesViewModel(title: "Израильская шакшука", timeToCook: "30 мин", image: UIImage(data: Data.init(base64Encoded: base64ImageIzrailShakshua)!)!),
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
