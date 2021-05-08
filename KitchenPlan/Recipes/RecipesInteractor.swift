import Foundation

final class RecipesInteractor {
    weak var output: RecipesInteractorOutput?
    var isFetching = false
    private let recipesManager: RecipesManagerDescription = RecipesManager.shared
}

extension RecipesInteractor: RecipesInteractorInput {
    func loadRecipes(since: Int, limit: Int, title: String? = nil, type: String? = nil, ingredients: [Int]) {
        if isFetching {
            return
        }
        
        isFetching = true
        recipesManager.loadRecipes(since: since, limit: limit,
                                   title: title, type: type, ingredients: ingredients) { [weak self] (result) in
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
    
    func havingIngredients() -> [Int] {
//        return [1,2,3,4,5,6,7,8,9,10]
        return []
    }
}
