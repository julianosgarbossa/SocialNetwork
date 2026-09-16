//
//  StoryTableViewCellScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

protocol StoryTableViewCellScreenDelegate: AnyObject {
    func tappedAddStoryButton()
}

class StoryTableViewCellScreen: UIView {
    
    private weak var delegate: StoryTableViewCellScreenDelegate?
    
    func delegate(delegate: StoryTableViewCellScreenDelegate) {
        self.delegate = delegate
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        return imageView
    }()
    
    lazy var addStoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.addTarget(self, action: #selector(tappedAddStoryButton), for: .touchUpInside)
        return button
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    @objc
    private func tappedAddStoryButton(_ sender: UIButton) {
        delegate?.tappedAddStoryButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        addSubview(profileImageView)
        addSubview(addStoryButton)
        addSubview(userNameLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            addStoryButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            addStoryButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            addStoryButton.widthAnchor.constraint(equalToConstant: 25),
            addStoryButton.heightAnchor.constraint(equalToConstant: 25),
            
            userNameLabel.topAnchor.constraint(equalTo: addStoryButton.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
