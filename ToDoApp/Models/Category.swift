//
//  Category.swift
//  ToDoApp
//
//  Created by Egor Lass on 29.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
