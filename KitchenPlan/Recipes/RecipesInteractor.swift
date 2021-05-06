import Foundation

final class RecipesInteractor {
    weak var output: RecipesInteractorOutput?
    private let recipesManager: RecipesManagerDescription = RecipesManager.shared
}

extension RecipesInteractor: RecipesInteractorInput {
    func loadRecipes() {
        recipesManager.loadRecipes() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.output?.didLoad(recipes: recipes)
                case .failure(let error):
                    print("Fail to fetch recipes ", error)
                }
            }
        }
    }
}
