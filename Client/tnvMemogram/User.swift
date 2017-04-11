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

    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    
    
}
