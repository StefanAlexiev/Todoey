//
//  Category.swift
//  Todoey
//
//  Created by Stefan Alexiev on 14.03.19.
//  Copyright © 2019 Stefan Alexiev. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var backgroundColor : String = ""
    
    // relationship
    let items = List<Item>()
}
