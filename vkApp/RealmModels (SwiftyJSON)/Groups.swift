//
//  Groups.swift
//  vkApp
//
//  Created by Anna Delova on 6/16/21.
//
import Foundation
import RealmSwift
import SwiftyJSON


class Groups: Object {
    
    @objc dynamic var groupId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    override class func primaryKey() -> String? {
        "groupId"
    }

}

extension Groups {
    convenience init(_ json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
        self.groupId = json["id"].intValue
    }
}

