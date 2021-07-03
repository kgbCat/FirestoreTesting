//
//  Groups.swift
//  vkApp
//
//  Created by Anna Delova on 6/16/21.
//
import Foundation
import RealmSwift
import SwiftyJSON


class Photos: Object {
    @objc dynamic var userId: Int = 0
    let photoOwners = LinkingObjects(
        fromType: Friend.self,
        property: "userPhotos")
    
    var photoSizes = List<Sizes>()
    
//    override class func primaryKey() -> String? {
//        "userId"
//    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.userId = json["owner_id"].intValue
    }

}


class Sizes: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    
    let photos = LinkingObjects(
        fromType: Photos.self,
        property: "photoSizes")

}
extension Sizes {
    convenience init(_ json: JSON) {
        self.init()
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
    }
}
