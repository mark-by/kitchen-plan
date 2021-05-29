import UIKit

protocol IngredientsModuleInput {
    var moduleOutput: IngredientsModuleOutput? { get }
}

protocol IngredientsModuleOutput: AnyObject {
}

protocol IngredientsViewOutput: AnyObject {
    func didLoadView()
    func didTapAdd()

    func count() -> Int
    func item(idx: Int) -> IngredientViewModel
    func didSelectItem(at index: Int)
    func didDelete(for idx: Int)
    func didDelete(for items: [Int])
}

protocol IngredientsViewInput: AnyObject {
    func reloadData()
    func close()
}

protocol IngredientsInteractorInput: AnyObject {
    func load()
    func save(in model: IngredientViewModel)
    func delete(for id: Int)
    
}

protocol IngredientsInteractorOutput: AnyObject {
    func didLoad(with model: [IngredientViewModel])
}

protocol IngredientsRouterInput: AnyObject {
    func showIngredient(with model: IngredientViewModel)
    func showIngredientSearch()
}
