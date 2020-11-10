//
//  File.swift
//  DATA
//
//  Created by 二爷 on 2020/9/9.
//  Copyright © 2020 二爷. All rights reserved.
//

import Foundation
import SwiftUI
var enCoder = JSONEncoder()
var deCoder = JSONDecoder()
class ToDo:ObservableObject {
    @Published var todoList:[SingleToDo] = []
    @Published var tags:[Tags] = []
    
    var count = 0
    var countT = 0
    
    init(data:[SingleToDo],tags:[Tags]) {
        for i in data {
            self.todoList.append(SingleToDo(title: i.title,id: count,tags: i.tags))
            count += 1
        }
        tags.forEach { tag in
            self.tags.append(Tags(id: countT, str: tag.str))
            countT += 1
        }
    }
    
    func add(data:SingleToDo) {
        self.todoList.append(SingleToDo(title: data.title,id: count,tags: data.tags))
        count += 1
        self.DataEnd()
    }
    
    func check(id:Int) {
        self.todoList[id].isCheckd.toggle()
        self.DataEnd()
    }
    
    func delete(id:Int) {
        self.todoList[id].delete = true
        self.DataEnd()
    }
    
    func DataEnd() {
        let dataEnd = try! enCoder.encode(self.todoList)
        UserDefaults.standard.set(dataEnd, forKey: "todoList")
    }
    
    func TagStorage() {
        let dataEnd = try! enCoder.encode(self.tags)
        UserDefaults.standard.set(dataEnd, forKey: "tags")
    }
    
    func deleteTags(id:Int) {
        self.tags[id].delete = true
        self.TagStorage()
    }
    
    func TagsAdd(data:Tags) {
        self.tags.append(Tags(id: countT, str: data.str))
        countT += 1
        self.TagStorage()
    }
}
struct SingleToDo:Identifiable,Codable {
    var title:String = ""
    var isCheckd:Bool = true
    var id:Int = 0
    var tags:[String] = []
    var delete:Bool = false
}
struct Tags:Identifiable,Codable {
    var id:Int = 0
    var delete:Bool = false
    var str:String = ""
}
struct Sil:Identifiable {
    var col:Color
    var img:String
    var id:Int
    var count:Int
    var name:String
}
