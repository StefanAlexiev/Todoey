//
//  Item.swift
//  Todoey
//
//  Created by Stefan Alexiev on 14.03.19.
//  Copyright © 2019 Stefan Alexiev. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    // relationship
    let parentCategory = LinkingObjects(fromType: Category.self,property: "items")
}
