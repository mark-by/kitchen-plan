import Foundation

final class RecipesInteractor {
    weak var output: RecipesInteractorOutput?
    var isFetching = false
    private let recipesManager: RecipesManagerDescription = RecipesManager.shared
}

extension RecipesInteractor: RecipesInteractorInput {
    func loadRecipes(since: Int, limit: Int) {
        if isFetching {
            return
        }
        
        isFetching = true
        recipesManager.loadRecipes(since: since, limit: limit) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.output?.didLoad(recipes: recipes)
                    self?.isFetching = false
                case .failure(let error):
                    print("Fail to fetch recipes ", error)
                    self?.isFetching = false
                }
            }
        }
    }
}
