import Foundation
import UIKit

protocol CreateReceiptModuleInput {
	var moduleOutput: CreateReceiptModuleOutput? { get }
}

protocol CreateReceiptModuleOutput: AnyObject {
    func didSaveReceipt(with model: CreatedReceipt)
}

protocol CreateReceiptViewInput: AnyObject {
}

protocol CreateReceiptViewOutput: AnyObject {
    func didSaveReceipt(with model: CreatedReceipt)
}

protocol CreateReceiptInteractorInput: AnyObject {
}

protocol CreateReceiptInteractorOutput: AnyObject {
}

protocol CreateReceiptRouterInput: AnyObject {
}

protocol DataGetter: AnyObject {
    func getData() -> String?
}
