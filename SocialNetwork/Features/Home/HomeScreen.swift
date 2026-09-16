//
//  HomeScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func tappedLogoutButton()
}

class HomeScreen: UIView {
    
    private weak var delegate: HomeScreenDelegate?
    
    func delegate(delegate: HomeScreenDelegate) {
        self.delegate = delegate
    }

    private lazy var barView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.setCardShadow()
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SocialNetwork"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StoryCardCollectionViewCell.self, forCellWithReuseIdentifier: StoryCardCollectionViewCell.identifier)
        collectionView.register(PostCardCollectionViewCell.self, forCellWithReuseIdentifier: PostCardCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    @objc
    private func tappedLogoutButton(_ sender: UIButton) {
        delegate?.tappedLogoutButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .appBackground
        
        addSubview(barView)
        barView.addSubview(logoImageView)
        barView.addSubview(appNameLabel)
        barView.addSubview(logoutButton)
        addSubview(collectionView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            barView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            barView.heightAnchor.constraint(equalToConstant: 70),
            
            logoImageView.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: barView.leadingAnchor, constant: 10),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            
            appNameLabel.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            
            logoutButton.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: barView.trailingAnchor, constant: -10),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: barView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configProtocolsCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
}
