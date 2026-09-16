//
//  HomeViewModel.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import Foundation
import FirebaseAuth

protocol HomeViewModelDelegate: AnyObject {
    func logoutSuccess()
    func logoutFailure(error: String)
    func success()
    func failure(failure: String)
}

final class HomeViewModel {
    
    private weak var delegate: HomeViewModelDelegate?
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    private let auth = Auth.auth()
    private let service: HomeService = HomeService()
    private var homeData: HomeData?
    
    func logout() {
        do {
            try auth.signOut()
            delegate?.logoutSuccess()
        } catch {
            delegate?.logoutFailure(error: error.localizedDescription)
        }
    }
    
    func fetchRequest(typeFetch: TypeFetch) {
        switch typeFetch {
        case .mock:
            service.getHomeFromJson { [weak self] result in
                switch result {
                case .success(let homeData):
                    self?.homeData = homeData
                    self?.delegate?.success()
                case .failure(let error):
                    self?.delegate?.failure(failure: error.localizedDescription)
                }
            }
        case .alamofire:
            service.getHomeFromAlamofire { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let homeData):
                        self?.homeData = homeData
                        self?.delegate?.success()
                    case .failure(let error):
                        self?.delegate?.failure(failure: error.localizedDescription)
                    }
                }
            }
        case .urlSession:
            service.getHomeFromUrlSession { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let homeData):
                        self?.homeData = homeData
                        self?.delegate?.success()
                    case .failure(let error):
                        self?.delegate?.failure(failure: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // Um para stories e outro de posts
    var numberOfItemsInSection: Int {
        return 2
    }
    
    var getStoryList: [Story] {
        return homeData?.story ?? []
    }
    
    // Largura dos stories
    private let storyItemWidth: CGFloat = 120
    
    func sizeForItemAtStory(collectionViewBoundsHeight: CGFloat) -> CGSize {
        return CGSize(width: storyItemWidth, height: collectionViewBoundsHeight)
    }
    
    func sizeForItemAtPost(collectionViewBoundsWidth: CGFloat, collectionViewBoundsHeight: CGFloat) -> CGSize {
        return CGSize(width: collectionViewBoundsWidth - storyItemWidth, height: collectionViewBoundsHeight)
    }
    
    var getPostList: [Post] {
        return homeData?.post ?? []
    }
}
