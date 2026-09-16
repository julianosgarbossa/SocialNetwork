//
//  StoryTableViewCell.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

protocol StoryTableViewCellDelegate: AnyObject {
    func tappedAddStoryButton()
}

class StoryTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: StoryTableViewCell.self)
    
    private weak var delegate: StoryTableViewCellDelegate?
    
    func delegate(delegate: StoryTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    private lazy var screen: StoryTableViewCellScreen = {
        let screen = StoryTableViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addVisualElements()
        configProtocols()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configProtocols() {
        screen.delegate(delegate: self)
    }
    
    private func addVisualElements() {
        selectionStyle = .none
        
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
    
    func setupCell(story: Story, indexPath: Int) {
        screen.profileImageView.image = UIImage(named: story.image)
        screen.userNameLabel.text = story.userName
        screen.addStoryButton.isHidden = indexPath == 0 ? false : true
    }
}

extension StoryTableViewCell: StoryTableViewCellScreenDelegate {
    func tappedAddStoryButton() {
        delegate?.tappedAddStoryButton()
    }
}
