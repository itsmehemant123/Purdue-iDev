//
//  Post.swift
//  iDev Social
//
//  Created by Hemanth Devarapalli on 1/19/17.
//  Copyright © 2017 Hemanth Devarapalli. All rights reserved.
//

import UIKit

class Post: NSObject {

    var text: String = ""
    var email: String = ""
    var imageUUID: String?
    
    init(dict: Dictionary<String, AnyObject>) {
        guard let dText = dict["text"] as? String else {
            return
        }
        self.text = dText
        
        guard let dEmail = dict["user"] as? String else {
            return
        }
        self.email = dEmail
        
        guard let imageUUID = dict["image"] as? String else {
            print("No img")
            
        }
        self.imageUUID = imageUUID
    }
}
