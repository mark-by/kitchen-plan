import Foundation

protocol ReceiptModuleInput {
	var moduleOutput: ReceiptModuleOutput? { get }
}

protocol ReceiptModuleOutput: AnyObject {
}

protocol ReceiptViewInput: AnyObject {
    func loadData(with model: Receipt)
}

protocol ReceiptViewOutput: AnyObject {
    func didLoadView()
    func getModel() -> ReceiptModelView?
}

protocol ReceiptInteractorInput: AnyObject {
    func load(receiptId: Int)
}

protocol ReceiptInteractorOutput: AnyObject {
    func didLoad(with model: Receipt)
}

protocol ReceiptRouterInput: AnyObject {
}
