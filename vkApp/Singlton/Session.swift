//
//  Session.swift
//  vkApp
//
//  Created by Anna Delova on 5/20/21.
//

/*
 1. Добавить в проект синглтон для хранения данных о текущей сессии – Session.
2. Добавить в него свойства:
token: String – для хранения токена в VK,
userId: Int – для хранения идентификатора пользователя ВК.
*/
import UIKit

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token = ""
    var userId = 0

}
