import Foundation
import RealmSwift

final class MyRecipesInteractor {
    weak var output: MyRecipesInteractorOutput?
    private let myRecipesManager: MyRecipesManagerDescription = MyRecipesManager.shared
}

extension MyRecipesInteractor: MyRecipesInteractorInput {
    func loadMyRecipes() -> [RecipesViewModel] {
        let result = self.myRecipesManager.loadMyRecipes()
        output?.didLoad(recipes: result)
        
        return result
    }
    
    func addRecipe(with model: CreatedReceipt) -> RecipesViewModel {
        let result = self.myRecipesManager.addToMyRecipes(with: model)
        
        return result
    }
    
    func deleteRecipe(id: Int) {
        DispatchQueue.main.async {
            self.myRecipesManager.deleteMyRecipe(id: id)
        }
    }
}
