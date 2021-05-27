import Foundation
import RealmSwift

protocol IngredientsManagerDescription: AnyObject {
    func getIngredients() -> [IngredientViewModel]
    func save(in model: IngredientViewModel)
    func delete(for id: Int)
}

final class IngredientsManager {
    static let shared: IngredientsManagerDescription = IngredientsManager()
    private let realm = try! Realm()
}

extension IngredientsManager: IngredientsManagerDescription {
    func save(in model: IngredientViewModel) {
        let ingredient = Ingredient()
        ingredient.id = model.id
        ingredient.title = model.title
        if let image = model.image {
            ingredient.image = image
        }
        if let measure = model.measure {
            ingredient.measure = measure
        }
        if let quantity = model.quantity {
            ingredient.quantity = quantity
        }

        realm.beginWrite()
        realm.add(ingredient)
        try! realm.commitWrite()
    }

    func getIngredients() -> [IngredientViewModel] {
        var result: [IngredientViewModel] = []
        for el in realm.objects(Ingredient.self) {
            result.append(IngredientViewModel(id: el.id, title: el.title, image: el.image, measure: el.measure, quantity: el.quantity))
        }
        return result
    }

    func delete(for id: Int) {
        realm.beginWrite()
        realm.delete(realm.objects(Ingredient.self).filter("id == %@", id))
        try! realm.commitWrite()
    }
}
