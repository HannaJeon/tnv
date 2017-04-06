//
//  User.swift
//  TnvMemogram
//
//  Created by 김재정 on 2017. 4. 5..
//  Copyright © 2017년 Hanna. All rights reserved.
//

import Foundation
import Alamofire

struct User {
    
    var _id: String
    var profilePhoto: String
    var password: String
    var email: String
    var __v: Bool
    
    init(id: String, profilePhoto: String, password: String, email: String, __v: Bool) {
        self._id = id
        self.profilePhoto = profilePhoto
        self.password = password
        self.email = email
        self.__v = __v
    }
  
    
    static func usersFromBundle(callback: @escaping (_ posts: [User]) -> Void) {
        
        var users = [User]()
        
        var userObjects = [[String: Any]]()
        
        Alamofire.request("http://localhost:8000/api/Register").responseJSON { (response) in
            
            /*
            if let rootObject = response.result.value as? [String : Any] {
                postObjects = rootObject["feeds"] as! [[String : Any]]
            }
            
            for postObject in postObjects {
                if let date = postObject["createdAt"] as? String {
                    let dateForm = DateFormatter()
                    dateForm.dateFormat = "yyyy-MM-dd"
                    print(date)
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
            }*/
            callback(users)
        }

    }
    
}
