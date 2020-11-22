//
//  ContentView.swift
//  DATA
//
//  Created by 二爷 on 2020/9/9.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
func initUserData() -> [SingleToDo] {
    var outPut:[SingleToDo] = []
    
    if let dataDeEnd = UserDefaults.standard.object(forKey: "todoList") as? Data{
        let data = try! deCoder.decode([SingleToDo].self, from: dataDeEnd)
        
        data.forEach{ todo in
            if !todo.delete{
                outPut.append(SingleToDo(title: todo.title, isCheckd: todo.isCheckd, id: todo.id,tags: todo.tags,delete: todo.delete,important: todo.important))
            }
        }
    }
    return outPut
}
func initTags() -> [Tags] {
    var outPut:[Tags] = []
    
    if let dataDeEnd = UserDefaults.standard.object(forKey: "tags") as? Data {
        let data = try! deCoder.decode([Tags].self, from: dataDeEnd)
        
        data.forEach { tag in
            if !tag.delete {
                outPut.append(Tags(id: tag.id, str: tag.str))
            }
        }
    } else {
        outPut.append(Tags(id: 0, str: "生活"))
        outPut.append(Tags(id: 1, str: "锻炼"))
        outPut.append(Tags(id: 2, str: "学习"))
    }
    return outPut
}
struct ContentView: View {
    @ObservedObject var userData:ToDo = ToDo(data: initUserData(),tags: initTags())
    @State var error:Bool = false
    @State var title:String = "全部项目"
    var body: some View {
        VStack {
            ToDoTop(title: $title)
                .environmentObject(self.userData)
            ScrollView(showsIndicators: false) {
                ForEach(self.userData.todoList){ todo in
                    if !todo.delete && todo.tags.contains(title) {
                        ToDoOne(id: todo.id)
                            .environmentObject(self.userData)
                            .padding(.top)
                    } else if !todo.delete && todo.important && title == "重要" {
                        ToDoOne(id: todo.id)
                            .environmentObject(self.userData)
                            .padding(.top)
                    }
                    
                }
//                ZStack {
//                    Image(systemName: "car")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300)
//                        .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
//                        .opacity(0.3)
//                    VStack {
//                        ForEach(self.userData.todoList){
//                            ToDoOne(id: $0.id)
//                                .environmentObject(self.userData)
//                        }
//                    }
//                }
        }
            Spacer()
            Button(action: ({
                self.error = true
            })){
              Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(.red)
                .padding(.bottom)
            }
            .sheet(isPresented: self.$error, content: {
                SwiftUIView()
                    .environmentObject(self.userData)
            })
        }
    }
}
struct ToDoTop: View {
    @State var g:Bool = false
    @Binding var title:String
    @State var show:Bool = false
    @EnvironmentObject var userData:ToDo
    var body: some View {
        HStack {
            Button(action: {
                self.show.toggle()
            }){
                Image(systemName: "list.star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(.red)
                    .padding(8)
                    
            }
            .sheet(isPresented: self.$show, content: {
                showFilter(title: $title)
                    .environmentObject(self.userData)
            })
            Spacer()
            Text(title)
            Spacer()
            Button(action: {
                self.g = true
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 24)
                    .padding(8)
            })
            .fullScreenCover(isPresented: $g, content: {
                Search()
            })
            Image(systemName: "gearshape")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 24)
                .padding(8)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
