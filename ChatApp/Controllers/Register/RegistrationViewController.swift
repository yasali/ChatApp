import UIKit

class RegistrationViewController: UIViewController {
    private var registrationViewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthDelegate?

    private let appTitleLabel: UILabel = {
        let attributedTitle = NSMutableAttributedString(string: "Chat App",
                                                                     attributes: [.font: UIFont.boldSystemFont(ofSize: 42),
                                                                     .foregroundColor: lightTextColor])
        let label = UILabel()
        label.attributedText = attributedTitle
        return label
    }()
    
    private lazy var emailTextFieldView: CustomTextFieldView = CustomTextFieldView(textField: emailTextField)
    private lazy var firstNameTextFieldView: CustomTextFieldView = CustomTextFieldView(textField: firstNameTextField)
    private lazy var lastNameTextFieldView: CustomTextFieldView = CustomTextFieldView(textField: lastNameTextField)
    private lazy var usernameTextFieldView: CustomTextFieldView = CustomTextFieldView(textField: usernameTextField)
    private lazy var passwordTextFieldView: CustomTextFieldView = CustomTextFieldView(textField: passwordTextField)
    private let emailTextField = CustomTextField(placeholder: NSLocalizedString("email", comment: "Email"))
    private let firstNameTextField = CustomTextField(placeholder: NSLocalizedString("first_name", comment: "First Name"))
    private let lastNameTextField = CustomTextField(placeholder: NSLocalizedString("last_name", comment: "Last Name"))
    private let usernameTextField = CustomTextField(placeholder: NSLocalizedString("username", comment: "User Name"))
    private let passwordTextField: CustomTextField = {
        let customTextField = CustomTextField(placeholder: NSLocalizedString("password", comment: "Password"))
        customTextField.isSecureTextEntry = true
        return customTextField
    }()
    
    private let registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.setTitle(NSLocalizedString("register", comment: "Register"), for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        registerButton.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.5)
        registerButton.setTitleColor(lightTextColor, for: .normal)
        registerButton.setHeightForConstraint(height: 50)
        registerButton.isEnabled = false
        registerButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return registerButton
    }()
    
    private let alreadyRegisteredButton: UIButton = {
        let arBtn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: NSLocalizedString("already_registered", comment: "Already Registered"),
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: lightTextColor])
        attributedTitle.append(NSAttributedString(string: NSLocalizedString("login", comment: "Login"),
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                               .foregroundColor: lightTextColor]))
        arBtn.setAttributedTitle(attributedTitle, for: .normal)
        arBtn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return arBtn
    }()
    
    // MARK: - Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterUI()
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object:  nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:  nil)
    }
    
    // MARK: - Selectors
    
    @objc func handleRegistration() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = profileImage else { return }
        
        let regUser = RegistrationUser(email: email, password: password,
                                       firstName: firstName, lastName: lastName, username: username,
                                                  profileImage: profileImage)
        
        showProgress(true, withText: NSLocalizedString("registering_user", comment: "Registering"))
        
        AuthenticationService.instance.register(user: regUser) { error in
            if let error = error {
                self.showProgress(false)
                self.alertError(error.localizedDescription)
                return
            }
            self.showProgress(false)
            self.delegate?.onLoginSuccess()
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            registrationViewModel.email = sender.text
        } else if sender == passwordTextField {
            registrationViewModel.password = sender.text
        } else if sender == firstNameTextField {
            registrationViewModel.firstName = sender.text
        }  else if sender == lastNameTextField {
            registrationViewModel.lastName = sender.text
        } else {
            registrationViewModel.username = sender.text
        }
        
        updateRegisterForm()
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    // MARK: - Helpers
    
    func setupRegisterUI() {
        setupGradientLayer()
        
        view.addSubview(appTitleLabel)
        appTitleLabel.centerX(inView: view)
        appTitleLabel.setConstraint(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        appTitleLabel.setDimensionsForConstraint(height: 200, width: 200)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextFieldView,
                                                   firstNameTextFieldView,
                                                   lastNameTextFieldView,
                                                   usernameTextFieldView,
                                                   passwordTextFieldView,
                                                   registerButton])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.setConstraint(top: appTitleLabel.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(alreadyRegisteredButton)
        alreadyRegisteredButton.setConstraint(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 32,
                                     paddingRight: 32)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object:  nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:  nil)
    }
    
    func updateRegisterForm() {
        if registrationViewModel.isValidInput {
            registerButton.isEnabled = true
            registerButton.backgroundColor = buttonBackgroundColor
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.5)
        }
    }
}
