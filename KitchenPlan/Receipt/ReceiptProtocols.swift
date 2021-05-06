import Foundation

protocol ReceiptModuleInput {
	var moduleOutput: ReceiptModuleOutput? { get }
}

protocol ReceiptModuleOutput: AnyObject {
}

protocol ReceiptViewInput: AnyObject {
}

protocol ReceiptViewOutput: AnyObject {
}

protocol ReceiptInteractorInput: AnyObject {
    func load(receiptId: Int)
}

protocol ReceiptInteractorOutput: AnyObject {
    func didLoad()
}

protocol ReceiptRouterInput: AnyObject {
}
