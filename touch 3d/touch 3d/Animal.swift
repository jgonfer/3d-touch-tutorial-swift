//
//  Animal.swift
//  touch 3d
//
//  Created by jgonzalez on 20/1/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import Foundation

class Animal {
    private var name = ""
    private var image: String?
    private var url: String?
    private var type: ItemType?
    private var like = false
    
    init(name: String, image: String?, url: String?, type: ItemType) {
        self.name = name
        self.image = image
        self.url = url
        self.type = type
    }
    
    func getName() -> String {
        return name
    }
    
    func getImage() -> String? {
        return image
    }
    
    func getUrl() -> String? {
        return url
    }
    
    func getType() -> ItemType? {
        return type
    }
    
    func getLike() -> Bool {
        return like
    }
    
    func toggleLikeState() {
        like = !like
    }
}
