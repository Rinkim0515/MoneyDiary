//
//  UIComponent.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
// Call By Reference class -> class
import UIKit


class UIComponent {
    //MARK: - UIButton
    static func button(title: String, bgColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = bgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }
    
    //MARK: - UILabel
    static func label(title: String, textSize: CGFloat, textColor: UIColor = .black, align: NSTextAlignment = .left, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.textAlignment = align
        label.text = title
        label.textColor = textColor
        label.font = isBold ?
        UIFont.boldSystemFont(ofSize: textSize) : UIFont.systemFont(ofSize: textSize)
        label.numberOfLines = 0
        return label
    }
    
    //MARK: - UITextField
    static func textField(keyboard: UIKeyboardType, rightViewString: String = "") -> CustomTextField {
        let textField = CustomTextField()
        textField.textColor = UIColor.black
        textField.borderStyle = .none
        textField.keyboardType = keyboard
        textField.clipsToBounds = false
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "입력완료", style: .done, target: textField, action: #selector(textField.dismissKeyboard))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        guard rightViewString == "" else {
            let currencyLabel = UILabel()
            currencyLabel.text = rightViewString
            currencyLabel.font = textField.font
            currencyLabel.textColor = .black
            currencyLabel.sizeToFit()
            
            textField.rightView = currencyLabel
            textField.rightViewMode = .always
            return textField }
        
        
        return textField
    }
    
    //MARK: - UIDatePicker
    static func datePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = TimeZone(identifier: "Asia/Seoul")
        picker.backgroundColor = .white
        picker.tintColor = .black
        return picker
    }

    static func buttonWithTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: imageName)

        let configuration = UIButton.Configuration.plain()
        button.configuration = configuration
        button.configuration?.image = image
        button.configuration?.imagePadding = 5
        button.configuration?.imagePlacement = .top
        button.configuration?.baseForegroundColor = .black
        button.configuration?.title = title
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            return newAttr
        }
        
        return button
    }
}
