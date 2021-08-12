import UIKit

protocol SendMessageControllerDelegate: class {
    func onMessageSent()
    func onCancelled()
}

class SendMessageViewController: UIViewController {
    weak var delegate: SendMessageControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSendMessageUI()
        setTitleInViewControllerForNavigationBar(title: NSLocalizedString("send_message", comment: "Send Message"))
    }
    
    func setupSendMessageUI(){
        view.backgroundColor = secondaryBackgroundColor
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))

    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

}
