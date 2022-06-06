//
//  PostLocalDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import RealmSwift

class PostLocalDataModel: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String
    
    @Persisted var type: String = ""
    
    @Persisted var url: String = ""
    
    convenience init(id: String, type: String, url: String) {
        self.init()
        self.id = id
        self.type = type
        self.url = url
    }
}
