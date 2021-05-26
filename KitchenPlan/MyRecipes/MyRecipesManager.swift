import Foundation
import RealmSwift

final class MyRecipesManager {
    static let shared: MyRecipesManagerDescription = MyRecipesManager()
    private let realm = try! Realm()
}

extension MyRecipesManager: MyRecipesManagerDescription {
    func loadMyRecipes() -> [RecipesViewModel] {
        var result: [RecipesViewModel] = []
        
        for elem in realm.objects(MyRecipe.self) {
            result.append(RecipesViewModel(id: elem.id, title: elem.title, timeToCook: "", image: elem.image))
        }
        
        return result
    }
    
    func addToMyRecipes(with model: CreatedReceipt) -> RecipesViewModel {
        var newId = 1
        if let lastInsertedId = realm.objects(MyRecipe.self).max(ofProperty: "id") as Int? {
            newId = lastInsertedId + 1
        }
        
        let addedRecipe = MyRecipe()
        
        addedRecipe.id = newId
        addedRecipe.title = model.title
        if let image = model.image {
            addedRecipe.image = image
        }
        addedRecipe.type = model.type
        addedRecipe.ingredients.append(objectsIn: model.ingredients)
        addedRecipe.steps.append(objectsIn: model.steps)
                
        realm.beginWrite()
        realm.add(addedRecipe)
        try! realm.commitWrite()
        
        let addedRecipeViewModel = RecipesViewModel(id: addedRecipe.id, title: addedRecipe.title, timeToCook: "", image: addedRecipe.image)
        
        return addedRecipeViewModel
    }
    
    func deleteMyRecipe(id:Int) {
        realm.beginWrite()
        realm.delete(realm.objects(MyRecipe.self).filter("id == %@", id))
        try! realm.commitWrite()
    }
}
