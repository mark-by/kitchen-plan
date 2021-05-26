import Foundation
import RealmSwift

final class MyRecipesInteractor {
    weak var output: MyRecipesInteractorOutput?
}

extension MyRecipesInteractor: MyRecipesInteractorInput {
    func loadMyRecipes() {
    }
}
