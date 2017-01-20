//
//  Item.swift
//  touch 3d
//
//  Created by jgonzalez on 20/1/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import Foundation

struct Item {
    var name = ""
    var image: String?
    var url: String?
    var type: ItemType?
    
    init(name: String, image: String?, url: String?, type: ItemType) {
        self.name = name
        self.image = image
        self.url = url
        self.type = type
    }
}
