//
//  PostCollectionViewCell.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: PostCollectionViewCell.self)
    
    private lazy var screen: PostCollectionViewCellScreen = {
        let screen = PostCollectionViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        contentView.addSubview(screen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(post: Post) {
        screen.profileImageView.image = UIImage(named: post.profileImage)
        screen.userNameLabel.text = post.userName
        screen.postImageView.image = UIImage(named: post.postImage)
    }
}
