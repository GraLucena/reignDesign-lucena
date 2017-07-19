//
//  Hit.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class Hit: Object, Unboxable {
    
    dynamic var id = 0
    dynamic var title : String?
    dynamic var storyTitle : String?
    dynamic var storyURL : String!
    dynamic var createdAt : String!
    dynamic var author : String!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let story_id = "story_id"
        static let title = "title"
        static let story_title = "story_title"
        static let story_url = "story_url"
        static let created_at = "created_at"
        static let author = "author"
        
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        id = unboxer.unbox(key: JSONKey.story_id) ?? 0
        title = unboxer.unbox(key: JSONKey.title)
        storyTitle = unboxer.unbox(key: JSONKey.story_title)
        storyURL = unboxer.unbox(key: JSONKey.story_url)
        createdAt = unboxer.unbox(key: JSONKey.created_at)
        author = unboxer.unbox(key: JSONKey.author)
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "id"
    }
}
