//
//  NetworkRequests.swift
//  vkApp
//
//  Created by Anna Delova on 5/28/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


class NetworkRequests {
    
    var urlComponents: URLComponents = {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.132"),
            URLQueryItem(name: "user_id", value: String(Session.instance.userId))
        ]
        return url
    }()
    
    func getFriends(completion: @escaping ([Friend]?) -> Void) {
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "offset", value: "5"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
//            URLQueryItem(name: "count", value: "50"),
                ])
        
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkUsers = usersJSONs.map { Friend($0) }
                        DispatchQueue.main.async {
                            completion(vkUsers)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }

    }

    func getGroup(completion: @escaping ([Groups]?) -> Void) {
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
//            URLQueryItem(name: "count", value: "50"),

                ])
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkGroups = usersJSONs.map { Groups($0) }
                        DispatchQueue.main.async {
                            completion(vkGroups)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
    }
    }

    func searchGroups(search q: String, completion: @escaping ([SearchGroups]?) -> Void) {
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "sort", value: "1"),

                ])

        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkGroups = usersJSONs.map { SearchGroups($0) }
                        DispatchQueue.main.async {
                            completion(vkGroups)
                            print(vkGroups)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
    }
    }
    
    func getPhotos(userID:Int, completion: @escaping ([Photos]?) -> Void) {
        urlComponents.path = "/method/pphotos.getAll"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: "\(userID)"),
                ])
        
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkPhotos = usersJSONs.map { Photos($0) }
                        print(vkPhotos)
                        DispatchQueue.main.async {
                            completion(vkPhotos)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }
    
}
    
