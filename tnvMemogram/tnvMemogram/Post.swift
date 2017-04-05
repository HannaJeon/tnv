//
//  Posts.swift
//  tnvMemogram
//
//  Created by Mac on 2017. 3. 31..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import UIKit
import Alamofire

struct Post {

    let id: String!
    let user: String!
    let photoId: String!
    let createdAt: Date!
    let isLiked: Bool!
    let likedCount: Int!
    let message: String?

    init(id: String, user: String, photoId: String, createdAt: Date, isLiked: Bool, likedCount: Int, message: String) {
        self.id = id
        self.user = user
        self.photoId = photoId
        self.createdAt = createdAt
        self.isLiked = isLiked
        self.likedCount = likedCount
        self.message = message
    }
    
    init() {
        self.id = ""
        self.user = ""
        self.photoId = ""
        self.createdAt = Date()
        self.isLiked = true
        self.likedCount = 0
        self.message = ""
    }

    static func postsFromBundle(callback: @escaping (_ posts: [Post]) -> Void) {

        var posts = [Post]()

        var createdAt = Date()
        var isLiked = Bool()
        var postObjects = [[String: Any]]()

        Alamofire.request("http://localhost:8000/api/feeds").responseJSON { (response) in
            if let rootObject = response.result.value as? [String : Any] {
                postObjects = rootObject["feeds"] as! [[String : Any]]
            }

            for postObject in postObjects {
                if let date = postObject["createdAt"] as? String {
                    let dateForm = DateFormatter()
                    dateForm.dateFormat = "yyyy-MM-dd"
                    createdAt = dateForm.date(from: date)!
                }
                if let isLikedInt = postObject["isLiked"] as? Bool {
                    isLiked = Bool(isLikedInt)
                }
                if let id = postObject["_id"] as? String,
                let user = postObject["user"] as? String,
                let photoId = postObject["photoId"] as? String,
                let likedCount = postObject["likeCount"] as? Int,
                let message = postObject["message"] as? String {
                let post = Post(id: id, user: user, photoId: photoId, createdAt: createdAt, isLiked: isLiked, likedCount: likedCount, message: message)
                    posts.append(post)
                }
            }
            callback(posts)
        }
    }

}
