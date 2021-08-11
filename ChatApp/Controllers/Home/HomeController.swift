import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeUI()
        showLoginRegistrationViewIfNeeded()
        setTitleInViewControllerForNavigationBar(title: NSLocalizedString("home_title", comment: "Home"))
    }
    func showLoginRegistrationViewIfNeeded() {
        // TBD 
        switchToLoginViewController()
    }
    
    func logout() {
        // logout
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
        // TBD
    }
   
}

// MARK: - Login/Reg

extension HomeController: AuthDelegate {
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
