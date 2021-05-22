import Foundation

protocol CreateReceiptModuleInput {
	var moduleOutput: CreateReceiptModuleOutput? { get }
}

protocol CreateReceiptModuleOutput: AnyObject {
}

protocol CreateReceiptViewInput: AnyObject {
}

protocol CreateReceiptViewOutput: AnyObject {
}

protocol CreateReceiptInteractorInput: AnyObject {
}

protocol CreateReceiptInteractorOutput: AnyObject {
}

protocol CreateReceiptRouterInput: AnyObject {
}

protocol CreateReceiptCellConfiguration: AnyObject {
    func configure(output: CreateReceiptViewController)
}
