//
//  UserOptionsModal.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 10.02.2021.
//

import UIKit
import FirebaseAuth

class UserOptionsModal: UIViewController {
    
    //MARK: - Properties
    
    private var user: User!
    
    private let topBarView              = UIView()
    private let userHeaderView          = UserHeaderView()
    private let userOptionsTableView    = UITableView()
    
    private var hasSetPointOrigin       = false
    private var pointOrigin: CGPoint?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        setupPanGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    init(with user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        userHeaderView.update(withImageURLString: "", userName: user.fullname)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func logUserOut() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } catch let error {
            let dismissAction   = UIAlertAction(title: "Dismiss", style: .cancel)
            let alert           = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(dismissAction)
            present(alert, animated: true)
        }
    }
    
    @objc private func swipeToDismissModal(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Only let the user swipe down
        
        guard translation.y >= 0  else { return }
        
        // Setting the origin to x = 0 to prevent the user from swiping the view sideways, setting y to be equal to the original position + the amount the user swiped down
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        // Checking if the swipe has ended
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            
            // If the velocity was fast enough, dismiss the VC, otherwise animate the view back to the original position
            
            if dragVelocity.y > 1300 {
                self.dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    //MARK: - Helpers
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeToDismissModal))
        view.addGestureRecognizer(panGesture)
    }
    
    //MARK: - UI Configuration
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureUI() {
        configureTopBarView()
        configureUserHeaderView()
        configureUserOptionsTableView()
    }
    
    private func configureTopBarView() {
        view.addSubview(topBarView)
        topBarView.backgroundColor      = .label
        topBarView.alpha                = 0.25
        topBarView.layer.cornerRadius   = 2.5
        
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            topBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 5),
            topBarView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureUserHeaderView() {
        view.addSubview(userHeaderView)
        
        NSLayoutConstraint.activate([
            userHeaderView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 30),
            userHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userHeaderView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func configureUserOptionsTableView() {
        view.addSubview(userOptionsTableView)
        
        userOptionsTableView.register(BGUserOptionsCell.self, forCellReuseIdentifier: BGUserOptionsCell.reuseIdentifier)
        userOptionsTableView.delegate           = self
        userOptionsTableView.dataSource         = self
        userOptionsTableView.separatorStyle     = .none
        userOptionsTableView.isScrollEnabled    = false
        
        userOptionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userOptionsTableView.topAnchor.constraint(equalTo: userHeaderView.bottomAnchor, constant: 18),
            userOptionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userOptionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userOptionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}

extension UserOptionsModal: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BGUserOptionsCell.reuseIdentifier, for: indexPath) as! BGUserOptionsCell
        switch indexPath.row {
        case 0:
            cell.set(iconName: "person", optionName: "Personal Info")
        case 1:
            cell.set(iconName: "gearshape", optionName: "Preferences")
        case 2:
            cell.set(iconName: "arrow.backward.circle", optionName: "Log Out")
            let tap = UITapGestureRecognizer(target: self, action: #selector(logUserOut))
            cell.addGestureRecognizer(tap)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
