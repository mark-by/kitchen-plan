import UIKit

final class RecipesPresenter {
//    weak var view:
    private var recipes: [RecipesViewModel] = [
        RecipesViewModel(id: 387, title: "Жаренная картошка с грибами и сыром", timeToCook: "50 мин", image: "/recipes/387.jpg"),
        RecipesViewModel(id: 42, title: "Израильская шакшука", timeToCook: "30 мин", image: "/recipes/42.jpg"),
        RecipesViewModel(id: 233, title: "Запечный батат с пряными травами", timeToCook: "30 мин", image: "/recipes/233.jpg"),
        RecipesViewModel(id: 260, title: "Зеленый салат с грушей", timeToCook: "30 мин", image: "/recipes/260.jpg"),
        RecipesViewModel(id: 1287, title: "Белая рыба со сливочным булгуром", timeToCook: "30 мин", image: "/recipes/1287.jpg"),
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
