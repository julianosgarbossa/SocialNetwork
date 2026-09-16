//
//  StoryCardCollectionViewCell.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

protocol StoryCardCollectionViewCellDelegate: AnyObject {
    func tappedAddStoryButton()
}

class StoryCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: StoryCardCollectionViewCellScreen.self)
    
    private weak var delegate: StoryCardCollectionViewCellDelegate?
    
    func delegate(delegate: StoryCardCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    private lazy var screen: StoryCardCollectionViewCellScreen = {
        let screen = StoryCardCollectionViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    private var viewModel: StoryCardCollectionViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
        configProtocols()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configProtocols() {
        screen.configTableViewProtocols(delegate: self, dataSource: self)
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
    
    func setupCell(storyList: [Story]) {
        viewModel = StoryCardCollectionViewCellViewModel(storyList: storyList)
        screen.tableView.reloadData()
    }
}

extension StoryCardCollectionViewCell: UITableViewDelegate {
    
}

extension StoryCardCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
        guard let viewModel else { return UITableViewCell() }
        cell.setupCell(story: viewModel.loadCurrentStory(index: indexPath.row), indexPath: indexPath.row)
        cell.delegate(delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel else { return 0 }
        return viewModel.heightForRowAt
    }
}

extension StoryCardCollectionViewCell: StoryTableViewCellDelegate {
    func tappedAddStoryButton() {
        delegate?.tappedAddStoryButton()
    }
}
