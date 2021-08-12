import UIKit

protocol AccountInfoControllerDelegate: class {
    func onLogout()
    func onAccountInfoUpdated()
}

class AccountInfoController: UIViewController {
    weak var delegate: AuthDelegate?
    
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .white
        button.imageView?.setDimensionsForConstraint(height: 24, width: 24)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccountInfoUI()
        setTitleInViewControllerForNavigationBar(title: NSLocalizedString("account_info_title", comment: "Account Info"))
    }
    
    func logout() {
        // logout
    }

    func setupAccountInfoUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = secondaryBackgroundColor
        view.addSubview(dismissViewControllerButton)
        dismissViewControllerButton.setConstraint(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor, paddingTop: 0,
                                paddingLeft: 24)
    }
   
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
