import UIKit

class ChatsViewController: UIViewController, UISearchResultsUpdating {
    private let chatSearch = UISearchController(searchResultsController: nil)
    var isAuthenciated = true
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.backgroundColor = buttonBackgroundColor
        button.imageView?.setDimensionsForConstraint(height: 24, width: 24)
        button.tintColor = .white
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeUI()
        setTitleInViewControllerForNavigationBar(title: NSLocalizedString("chats", comment: "Chats"))
        if (!isAuthenciated) {
            showLoginRegistrationViewIfNeeded()
        }
    }
    func showLoginRegistrationViewIfNeeded() {
        switchToLoginViewController()
    }
    
    func logout() {
        // logout
    }
    
    @objc func sendMessage() {
        DispatchQueue.main.async {
            let controller = SendMessageViewController()
            controller.delegate = self
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    //MARK: - LOGIN/REGISTER
    
    func switchToLoginViewController() {
        DispatchQueue.main.async {
            let controller = LoginViewController()
            controller.delegate = self
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    func setupHomeUI() {
        view.backgroundColor = secondaryBackgroundColor
        let navRightImage = UIImage(systemName: "gearshape.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: navRightImage, style: .plain, target: self, action: #selector(accountInfo))
        
        // Search Controller
        chatSearch.searchResultsUpdater = self
        chatSearch.obscuresBackgroundDuringPresentation = false
        chatSearch.searchBar.placeholder = ""
        navigationItem.searchController = chatSearch
        definesPresentationContext = true
        
        view.addSubview(sendMessageButton)
        sendMessageButton.setDimensionsForConstraint(height: 48, width: 48)
        sendMessageButton.layer.cornerRadius = 48 / 2
        sendMessageButton.setConstraint(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor, paddingBottom: 16,
                                paddingRight: 24)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    @objc func accountInfo() {
        DispatchQueue.main.async {
            let controller = AccountInfoController()
            controller.delegate = self
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
   
}

// MARK: - Login/Reg

extension ChatsViewController: AuthDelegate {
    func onLoginSuccess() {
        dismiss(animated: true, completion: nil)
        // setup HOMEVIEWCONTROLLER
    }
    
    func onLoginFailed() {
        dismiss(animated: true, completion: nil)
        // setup HOMEVIEWCONTROLLER
    }
    
    func onRegisterSuccess() {
        dismiss(animated: true, completion: nil)
        // setup HOMEVIEWCONTROLLER
    }
    
    func onRegisterFailed() {
        dismiss(animated: true, completion: nil)
        // setup HOMEVIEWCONTROLLER
    }
}

extension ChatsViewController: AccountInfoControllerDelegate {
    func onLogout() {
        // TBD
    }
    
    func onAccountInfoUpdated() {
        // TBD
    }
}

extension ChatsViewController: SendMessageControllerDelegate {
    func onMessageSent() {
        // TBD
    }
    
    func onCancelled() {
        // TBD
    }
}
