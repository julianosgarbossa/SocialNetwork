//
//  PostCardCollectionViewCellViewModel.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import Foundation

final class PostCardCollectionViewCellViewModel {
    private var postList: [Post] = []
    
    init(postList: [Post]) {
        self.postList = postList
    }
    
    var numberOfItemsInSection: Int {
        return postList.count
    }
    
    func sizeForItemAt(collectionViewBoundsWidth: CGFloat) -> CGSize {
        return CGSize(width: collectionViewBoundsWidth, height: 450)
    }
    
    func loadCurrentPost(index: Int) -> Post {
        return postList[index]
    }
}
