//
//  Film.swift
//  StarWarsCollections
//
//  Created by Jorge Catalan on 7/20/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

import Foundation

class Film:AnyObject {
    
    var title: String
    var episode: Int
    var description: String
    
    init(title: String, episode: Int, description: String) {
        self.title = title
        self.episode = episode
        self.description = description
    }
    
}