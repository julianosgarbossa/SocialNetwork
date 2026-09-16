//
//  PostCardCollectionViewCell.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

class PostCardCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: PostCardCollectionViewCell.self)
    
    private lazy var screen: PostCardCollectionViewCellScreen = {
        let screen = PostCardCollectionViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    private var viewModel: PostCardCollectionViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
        configProtocols()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configProtocols() {
        screen.configCollectionViewProtocols(delegate: self, dataSource: self)
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
    
    func setupCell(postList: [Post]) {
        viewModel = PostCardCollectionViewCellViewModel(postList: postList)
        screen.collectionView.reloadData()
    }
}

extension PostCardCollectionViewCell: UICollectionViewDelegate {
    
}

extension PostCardCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel else { return UICollectionViewCell() }
        cell.setupCell(post: viewModel.loadCurrentPost(index: indexPath.row))
        return cell
    }
}

extension PostCardCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel else { return .zero }
        return viewModel.sizeForItemAt(collectionViewBoundsWidth: collectionView.bounds.width)
    }
}
