//
//  HomeViewController.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

enum NameCellHome: Int {
    case story = 0
    case post = 1
}

class HomeViewController: UIViewController {

    private var screen: HomeScreen?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configProtocols()
        viewModel.fetchRequest(typeFetch: .urlSession)
    }
    
    private func configNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        screen?.delegate(delegate: self)
        screen?.configProtocolsCollection(delegate: self, dataSource: self)
        viewModel.delegate(delegate: self)
    }
}

extension HomeViewController: HomeScreenDelegate {
    func tappedLogoutButton() {
        viewModel.logout()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch NameCellHome(rawValue: indexPath.row) {
        case .story:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCardCollectionViewCell.identifier, for: indexPath) as? StoryCardCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCell(storyList: viewModel.getStoryList)
            cell.delegate(delegate: self)
            return cell
        case .post:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCardCollectionViewCell.identifier, for: indexPath) as? PostCardCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCell(postList: viewModel.getPostList)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch NameCellHome(rawValue: indexPath.row) {
        case .story:
            return viewModel.sizeForItemAtStory(collectionViewBoundsHeight: collectionView.bounds.height)
        case .post:
            return viewModel.sizeForItemAtPost(collectionViewBoundsWidth: collectionView.bounds.width, collectionViewBoundsHeight: collectionView.bounds.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func logoutSuccess() {
        dismiss(animated: true)
    }
    
    func logoutFailure(error: String) {
        showAlert(title: "Atenção", message: error)
    }
    
    func success() {
        screen?.collectionView.reloadData()
    }
    
    func failure(failure: String) {
        showAlert(title: "Atenção", message: failure)
    }
}

extension HomeViewController: StoryCardCollectionViewCellDelegate {
    func tappedAddStoryButton() {
        showAlert(title: "Atenção", message: "A funcionalidade para adicionar story será implementada em uma futura atualização!")
    }
}
