import Foundation

final class FavoritesInteractor {
    private var isFetching = false
	weak var output: FavoritesInteractorOutput?
    private let manager: RecipesManagerDescription = RecipesManager.shared
}

extension FavoritesInteractor: FavoritesInteractorInput {
    func loadRecipes(since: Int, recipes: [Int]) {
        if isFetching {
            return
        }
        
        isFetching = true
        manager.loadRecipes(since: since, limit: 5, title: nil, type: nil, ingredients: [], recipes: recipes) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.output?.didLoad(recipes: recipes)
                    self?.isFetching = false
                case .failure(let error):
                    self?.output?.didReceive()
                    self?.isFetching = false
                }
            }
        }
    }
}
