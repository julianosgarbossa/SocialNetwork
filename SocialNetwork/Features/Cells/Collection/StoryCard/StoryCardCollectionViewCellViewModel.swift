//
//  StoryCardCollectionViewCellViewModel.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import Foundation

final class StoryCardCollectionViewCellViewModel {
    private var storyList: [Story] = []
    
    init(storyList: [Story]) {
        self.storyList = storyList
    }
    
    var numberOfRowsInSection: Int {
        return storyList.count
    }
    
    var heightForRowAt: CGFloat {
        return 120
    }
    
    func loadCurrentStory(index: Int) -> Story {
        return storyList[index]
    }
}
