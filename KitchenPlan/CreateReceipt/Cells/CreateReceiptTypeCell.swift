import UIKit

final class CreateReceiptTypeCell: InputCell {
    
    let textField = UITextField()
    let picker = UIPickerView()
    let toolBar = UIToolbar()
    
    let pickerData = ["Не выбрано","Завтрак", "Обед", "Ужин", "Десерт"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getData() -> String? {
        textField.text
    }
    
    func setup() {
        picker.delegate = self
        picker.dataSource = self
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: true)
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
        textField.placeholder = "Выберите тип"
        
        contentView.addSubview(textField)
    }
    
    @objc func donePicker() {
        contentView.endEditing(true)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    func layout() {
        toolBar.sizeToFit()
        
        textField.pin.horizontally().margin(10).sizeToFit(.width)
    }
}

extension CreateReceiptTypeCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[row]
    }
}

extension CreateReceiptTypeCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row != 0 else {
            textField.text = nil
            return
        }
        textField.text = pickerData[row]
    }
}
