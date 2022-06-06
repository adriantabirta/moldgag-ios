//
//  UserLocalDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation
import RealmSwift

class UserLocalDataModel: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String
    
    @Persisted var firstName: String = ""
    
    @Persisted var lastName: String = ""
    
    convenience init(id: String, firstName: String, lastName: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
