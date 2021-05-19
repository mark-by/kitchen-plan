import UIKit
import PinLayout

final class TypePicker: UIViewController {
    private let data = ["Все", "Завтраки", "Обеды", "Ужины", "Десерты"]
    private let dataByIngredients = ["Все", "По ингредиетам"]
    private let picker = UIPickerView()
    private let doneButton = UIButton()
    var output: RecipesViewOutput?
    weak var mainViewController: RecipesViewController?
    
    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        picker.dataSource = self
        picker.delegate = self
        selectDefault()
        doneButton.setTitle("OK", for: .normal)
        doneButton.setTitleColor(.lightGray, for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 35, weight: .light)
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        [picker, doneButton].forEach {
            view.addSubview($0)
        }
    }
    
    func selectDefault() {
        let userDefaults = UserDefaults()
        guard let title = userDefaults.string(forKey: "receipt_type") else {
            return
        }
        picker.selectRow(data.firstIndex(of: title) ?? 0, inComponent: 0, animated: true)
        guard let canFilterByIngredients = output?.canFilterByIngredients() else {
            return
        }
        if !canFilterByIngredients {
            return
        }
        if let output = output {
            let (_, searchByIngredients) = output.selected()
            picker.selectRow(searchByIngredients ? 1 : 0, inComponent: 1, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        doneButton.pin.bottom().horizontally().height(100)
        picker.pin.above(of: doneButton).top().horizontally()
    }
    
    @objc func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func chooseDataByComponent(idx: Int) -> [String] {
        switch idx {
        case 0:
            return data
        case 1:
            return dataByIngredients
        default:
            return data
        }
    }
}

extension TypePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let canFilter = output?.canFilterByIngredients() else {
            return 2
        }
        return canFilter ? 2 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chooseDataByComponent(idx: component).count
    }
}

extension TypePicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chooseDataByComponent(idx: component)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            var selectedType: String?
            let userDefaults = UserDefaults()
            if data[row] == "Все" {
                selectedType = nil
                mainViewController?.title = "Рецепты"
                userDefaults.setValue("Рецепты", forKey: "receipt_type")
            } else {
                selectedType = String(data[row].dropLast())
                mainViewController?.title = data[row]
                userDefaults.setValue(data[row], forKey: "receipt_type")
            }
            output?.didSelectType(type: selectedType)
        case 1:
            output?.didToggleIngredients(isActive: row == 1)
        default:
            print("Unexpected")
        }
        
    }
}
