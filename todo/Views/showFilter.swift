//
//  showFilter.swift
//  DATA
//
//  Created by 二爷 on 2020/10/12.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct showFilter: View {
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var prose
    var j:[Sil] = [Sil(col: .purple,img: "star",id: 0,count: 6,name: "重要"),
            Sil(col: .red,img: "calendar",id: 1,count: 0,name: "已计划日程"),
            Sil(col: .green,img: "person.fill",id: 2,count: 1,name: "只有我能做"),
            Sil(col: .blue,img: "music.note.house.fill",id: 3,count: 3,name: "任务"),
    ]
    
    @State var tagNew:Bool = false
    @State var newTag:String = ""
    @Binding var title:String
    func tagCount(tags:String) -> Int {
        var count = 0
        
        self.userData.todoList.forEach { (SingleToDo) in
            if  !SingleToDo.delete && SingleToDo.tags.contains(tags){
                count += 1
            }
        }
        return count
    }
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing:15) {
                    ForEach(j){ tag in
                        gu(col: tag.col, name: tag.name, img: tag.img, count: tag.count)

                    }
                }
                .padding(.vertical,15)
                .padding(.horizontal,20)
                
                List {
                    ForEach(self.userData.tags){ tag in
                        if !tag.delete {
                            Button(action: {
                                self.prose.wrappedValue.dismiss()
                                self.title = tag.str
                            }, label: {
                                Filter(go: tag.str, conut: tagCount(tags: tag.str))
                                    .foregroundColor(.black)
                            })
                        }
                    }
                    .onDelete(perform: { indexSet in
                        userData.deleteTags(id: indexSet.last!)
                    })
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.horizontal,-18)
                if !tagNew {
                    HStack {
                        Button(action: { self.tagNew.toggle() }, label: {
                            Image(systemName: "plus")
                            Text("新建清单")
                        })
                        .padding()
                    }
                } else if tagNew {
                    tklsk(tagNew: $tagNew, newTag: $newTag)
                        .padding()
                }
            }
            .navigationBarTitle(Text("选择标签"),displayMode: .inline)
            .navigationBarItems(
            leading:
            Image(systemName: "arrow.backward.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .onTapGesture {
                    self.prose.wrappedValue.dismiss()
                }
            )
        }
    }
}
struct Filter: View {
    var go:String = ""
    var conut:Int = 0
    var body: some View {
        VStack {
            HStack {
                Text(self.go)
                Spacer()
                Text("\(conut)")
            }
            .padding(.horizontal,15)
        }
    }
}
struct gu: View {
    var col:Color
    var name:String
    var img:String
    var count:Int
    var body: some View {
        HStack (spacing:15) {
            Image(systemName: img)
                .resizable()
                .scaledToFit()
                .frame(width: 19)
                .foregroundColor(col)
            Text(name)
            Spacer()
            Text(String(count))
        }
    }
}

struct showFilter_Previews: PreviewProvider {
    static var previews: some View {
        showFilter(title: .constant("昌"))
    }
}
