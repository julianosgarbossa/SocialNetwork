//
//  StoryCardCollectionViewCellScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

class StoryCardCollectionViewCellScreen: UIView {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.setCardShadow()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        addSubview(cardView)
        cardView.addSubview(tableView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: cardView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
    }
    
    func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
