import UIKit

class CustomTextFieldView: UIView {

    init(textField: UITextField) {
        super.init(frame: .zero)
        setHeightForConstraint(height: 50)
        addSubview(textField)
        textField.centerY(inView: self)
        textField.setConstraint(left: leftAnchor, bottom: bottomAnchor,
                              right: rightAnchor, paddingLeft: 8, paddingBottom: -8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.setConstraint(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                           paddingLeft: 8, height: 0.75)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

