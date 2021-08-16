import UIKit

protocol AccountInfoControllerDelegate: class {
    func onLogout()
    func onAccountInfoUpdated()
}

class AccountInfoController: UIViewController {
    private let tableView = UITableView()
    weak var delegate: AuthDelegate?
    
    private let accountInfoImageView : UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "profile_img_.jpeg")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.setDimensionsForConstraint(height: 24, width: 24)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleInViewControllerForNavigationBar(title: NSLocalizedString("account_info_title", comment: "Account Info"))
        setupAccountInfoUI()
    }
    
    func logout() {
        // logout
    }

    func setupAccountInfoUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = secondaryBackgroundColor
        accountInfoImageView.setDimensionsForConstraint(height: 200, width: self.view.frame.width)
        self.view.addSubview(accountInfoImageView)
        accountInfoImageView.centerX(inView: self.view)
        accountInfoImageView.setConstraint(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        
        view.addSubview(dismissViewControllerButton)
        dismissViewControllerButton.setConstraint(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor, paddingTop: 10,
                                paddingLeft: 10)
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.rowHeight = 100
        tableView.register(AccountInfoCell.self, forCellReuseIdentifier: "accountInfoTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setDimensionsForConstraint(height: self.view.frame.height, width: self.view.frame.width)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.setConstraint(top: accountInfoImageView.bottomAnchor, paddingTop: 20)
    }
   
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

extension AccountInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountInfoViewModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "accountInfoTableViewCell", for: indexPath) as! AccountInfoCell
        let viewModel = AccountInfoViewModel(rawValue: indexPath.row)
        tableViewCell.viewModel = viewModel
        tableViewCell.accessoryType = .none
        return tableViewCell;
    }
}

extension AccountInfoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TBD
    }
}

class AccountInfoCell: UITableViewCell {
    
    var viewModel: AccountInfoViewModel? {
        didSet { configure() }
    }
    private let infoImageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.setDimensionsForConstraint(height: 40, width: 40)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [infoImageView, titleLabel])
        stackView.spacing = 10
        stackView.axis = .horizontal
        
        addSubview(stackView)
        stackView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        infoImageView.image = UIImage(systemName: viewModel.imageName)
        titleLabel.text = viewModel.title
    }
}
