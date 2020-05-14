//
//  UserPost.swift
//  KickShow
//
//  Created by Christopher Tufaro on 5/8/20.
//  Copyright © 2020 Personal. All rights reserved.
//
import Foundation

struct UserPost: Decodable, Identifiable {
    var id: Int
    var postTitle: String
    var postMotion: String
    var postImage: String
    var postDate: String
    var userId: Int
    var userName: String
    var userAvatar: String
}
