//
//  Item.swift
//  ElmenusTask
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import RealmSwift

class  Item :  Object , Codable {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photoURL = ""
    @objc dynamic var itemDescription = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photoURL = "photoUrl"
        case itemDescription = "description"
    }
}
