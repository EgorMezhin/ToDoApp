//
//  Data.swift
//  ToDoApp
//
//  Created by Egor Lass on 24.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
