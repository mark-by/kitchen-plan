import Foundation

final class RecipesInteractor {
    weak var output: RecipesInteractorOutput?
    var isFetching = false
    private let recipesManager: RecipesManagerDescription = RecipesManager.shared
}

extension RecipesInteractor: RecipesInteractorInput {
    func loadRecipes(since: Int, limit: Int, title: String? = nil, type: String? = nil) {
        if isFetching {
            return
        }
        
        isFetching = true
        recipesManager.loadRecipes(since: since, limit: limit, title: title, type: type) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.output?.didLoad(recipes: recipes)
                    self?.isFetching = false
                case .failure(let error):
                    print("Fail to fetch recipes ", error)
                    self?.output?.didReceive()
                    self?.isFetching = false
                }
            }
        }
    }
}
