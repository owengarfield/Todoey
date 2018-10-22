//
//  Item.swift
//  Todoey
//
//  Created by Owen Richards on 22/10/2018.
//  Copyright © 2018 Owen Garfield. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {

    var title: String = ""
    var done: Bool = false
    
}
