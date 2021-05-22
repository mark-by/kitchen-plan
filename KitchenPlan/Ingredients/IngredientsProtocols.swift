import UIKit

protocol IngredientsViewOutput: AnyObject {
    func didLoadView()

    func count() -> Int
    func item(idx: Int) -> IngredientsViewModel
    func didSelectItem(at index: Int)
}

protocol IngredientsViewInput: AnyObject {
    func reloadData()
}

protocol IngredientsInteractorInput: AnyObject {
    func loadIngredients(title: String?)
}

protocol IngredientsInteractorOutput: AnyObject {
    func didLoad(ingredients: [IngredientsInfoResponse])
    func didReceive()
}
