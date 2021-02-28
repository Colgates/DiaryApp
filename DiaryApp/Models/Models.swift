//
//  Models.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 19.11.2020.
//

import Foundation
import RealmSwift

class UserNotes: Object {
//    let date: Date
    @objc dynamic var imageName: String?
     @objc dynamic var text: String?
}
