import UIKit
import PinLayout

final class TypePicker: UIViewController {
    private let data = ["Все", "Завтрак", "Обед", "Ужин", "Десерт"]
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
        doneButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .light)
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        [picker, doneButton].forEach {
            view.addSubview($0)
        }
    }
    
    func selectDefault() {
        guard let title = mainViewController?.title else {
            return
        }
        let type = String(title.dropLast())
        let found = data.firstIndex(of: type)
        if let unwrapFound = found {
            picker.selectRow(unwrapFound, inComponent: 0, animated: true)
        } else {
            picker.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        doneButton.pin.bottom().horizontally().height(100)
        picker.pin.above(of: doneButton).top().horizontally()
    }
    
    @objc func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func toTitle(type: String) -> String {
        switch type {
        case "Завтрак":
            return "Завтраки"
        default:
            return type + "ы"
        }
    }
}

extension TypePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension TypePicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedType: String?
        if data[row] == "Все" {
            selectedType = nil
            mainViewController?.title = "Рецепты"
        } else {
            selectedType = data[row]
            mainViewController?.title = toTitle(type: data[row])
        }
        output?.didSelectType(type: selectedType)
    }
}
