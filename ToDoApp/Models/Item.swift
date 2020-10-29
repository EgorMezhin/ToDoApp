//
//  Item.swift
//  ToDoApp
//
//  Created by Egor Lass on 29.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
