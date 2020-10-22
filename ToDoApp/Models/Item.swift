//
//  Item.swift
//  ToDoApp
//
//  Created by Egor Lass on 22.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import Foundation

class Item: Encodable {
    
    var title: String = ""
    var done: Bool = false
}
