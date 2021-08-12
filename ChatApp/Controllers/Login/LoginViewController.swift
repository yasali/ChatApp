//
//  LoginViewController.swift
//  ChatApp
//
//  Created by SWE-PC-110 on 2021-08-10.
//

import UIKit


protocol AuthDelegate: class {
    func onLoginSuccess()
    func onLoginFailed()
    func onRegisterSuccess()
    func onRegisterFailed()
}

class LoginViewController: UIViewController {
    private var loginViewModel = LoginViewModel()
    weak var delegate: AuthDelegate?
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        
        let attributedTitle = NSMutableAttributedString(string: NSLocalizedString("app_title", comment: "App Title"),
                                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 42),
                                                                     .foregroundColor: lightTextColor])
        label.attributedText = attributedTitle
        return label
    }()
    
    private lazy var emailContainerView: CustomTextFieldView = CustomTextFieldView(textField: emailTextField)
    private lazy var passwordContainerView: CustomTextFieldView = CustomTextFieldView(textField: passwordTextField)
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("login", comment: "Login"), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.5)
        button.setTitleColor(lightTextColor, for: .normal)
        button.setHeightForConstraint(height: 50)
        button.isEnabled = true // FIXME change to false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: NSLocalizedString("email", comment: "Email"))
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: NSLocalizedString("password", comment: "Password"))
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: NSLocalizedString("not_registered", comment: "Not registered"),
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: lightTextColor])
        attributedTitle.append(NSAttributedString(string: NSLocalizedString("register", comment: "Register"),
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                               .foregroundColor: lightTextColor]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginUI()
        
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
      // TBD
        delegate?.onLoginSuccess()
    }
    
    @objc func handleShowRegister() {
        let controller = RegistrationViewController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            loginViewModel.email = sender.text
        } else {
            loginViewModel.password = sender.text
        }
        
        updateLoginForm()
    }
    
    // MARK: - Helpers
    func setupLoginUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        setupGradientLayer()
        
        view.addSubview(appTitleLabel)
        appTitleLabel.centerX(inView: view)
        appTitleLabel.setConstraint(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        appTitleLabel.setDimensionsForConstraint(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.setConstraint(top: appTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.setConstraint(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 32,
                                     paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func updateLoginForm() {
        if loginViewModel.isValidInput {
            loginButton.isEnabled = true
            loginButton.backgroundColor = buttonBackgroundColor
        } else {
            loginButton.isEnabled = true // FIXME change to false
            loginButton.backgroundColor =  buttonBackgroundColor.withAlphaComponent(0.5)
        }
    }
}

