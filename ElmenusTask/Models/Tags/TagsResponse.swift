//
//  TagsResponse.swift
//  ElmenusTask
//
//  Created by Apple on 10/30/19.
//  Copyright © 2019 Muhammmed. All rights reserved.
//

import Foundation
import RealmSwift

class  Tag: Object ,  Codable
{
    @objc dynamic var  tagName: String = ""
    @objc dynamic var  photoURL: String = ""
}
