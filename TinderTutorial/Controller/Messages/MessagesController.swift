//
//  MessagesController.swift
//  TinderFirestore
//
//  Created by Stephen Dowless on 2/28/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class MessagesController: UITableViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private lazy var headerView: MatchHeader = {
        let header = MatchHeader()
        header.delegate = self
        return header
    }()
    
    private var conversations = [Conversation]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        fetchMatches()
        fetchRecentMessages()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchRecentMessages() {
        MessagingService.shared.fetchConversations { conversations in
            self.conversations = conversations
        }
    }
    
    func fetchMatches() {
        Service.fetchMatches { matches in
            self.headerView.matches = matches
        }
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableHeaderView = headerView
    }
    
    func configureNavigationBar() {
        let leftButton = UIImageView()
        leftButton.setDimensions(height: 32, width: 32)
        leftButton.layer.cornerRadius = 32 / 2
        leftButton.layer.masksToBounds = true
        leftButton.isUserInteractionEnabled = true
        leftButton.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        leftButton.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let icon = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate))
        icon.tintColor = .systemPink
        navigationItem.titleView = icon
    }
}

// MARK: - UITableViewDataSource

extension MessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.viewModel = ConversationViewModel(conversation: conversations[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessagesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9826375842, green: 0.3476698399, blue: 0.447683692, alpha: 1)
        label.text = "Messages"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        view.addSubview(label)
        label.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 12)
        
        return view
    }
}

// MARK: - MatchHeaderDelegate

extension MessagesController: MatchHeaderDelegate {
    func matchHeader(_ header: MatchHeader, wantsToStartChatWith uid: String) {
        Service.fetchUser(withUid: uid) { user in
            let controller = ChatController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
