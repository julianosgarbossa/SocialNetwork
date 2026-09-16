//
//  PostCollectionViewCellScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

class PostCollectionViewCellScreen: UIView {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.setCardShadow()
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "red-heart")
        imageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLikeImageView))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedPostImageView))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "white-heart")
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    @objc
    private func tappedLikeImageView(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) { [weak self] in
            self?.likeImageView.center.y += 50
        } completion: { [weak self] _ in
            self?.likeImageView.center.y -= 50
            self?.likeImageView.isHidden = true
        }
    }
    
    @objc
    private func tappedPostImageView(_ sender: UITapGestureRecognizer) {
        if likeImageView.isHidden == true {
            heartImageView.isHidden = false
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn) { [weak self] in
                self?.heartImageView.transform = .init(scaleX: 1.8, y: 1.8)
                self?.postImageView.transform = .init(scaleX: 1.05, y: 1.05)
                self?.likeImageView.center.y += 50
            } completion: { [weak self] _ in
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn) { [weak self] in
                    self?.postImageView.transform = .identity
                    self?.likeImageView.center.y -= 50
                    self?.likeImageView.isHidden = false
                }
                self?.heartImageView.transform = .identity
                self?.heartImageView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        addSubview(cardView)
        cardView.addSubview(profileImageView)
        cardView.addSubview(likeImageView)
        cardView.addSubview(userNameLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(heartImageView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            
            likeImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            likeImageView.widthAnchor.constraint(equalToConstant: 25),
            likeImageView.heightAnchor.constraint(equalToConstant: 25),
            
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -10),
            
            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            postImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            postImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            heartImageView.centerXAnchor.constraint(equalTo: postImageView.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: postImageView.centerYAnchor),
            heartImageView.widthAnchor.constraint(equalToConstant: 70),
            heartImageView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
