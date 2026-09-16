//
//  HomeData.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import Foundation

struct HomeData: Decodable {
    let story: [Story]
    let post: [Post]
}

struct Story: Decodable{
    let image: String
    let userName: String
}

struct Post: Decodable {
    let profileImage: String
    let userName: String
    let postImage: String
}
