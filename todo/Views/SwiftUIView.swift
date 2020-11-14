//
//  SwiftUIView.swift
//  DATA
//
//  Created by 二爷 on 2020/9/9.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @EnvironmentObject var userData:ToDo
    @State var title:String = ""
    @State var tag:String = ""
    @State var a:String = ""
    @State var startDate:Date = Date()
    @State var endDate:Date = Date()
    @State var isCheckd:Bool = true
    @State var cloock:Bool = true
    @State var checktag:[String] = ["全部项目"]
    @State var important:Bool = false
    @Environment(\.presentationMode)var prose
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("项目名称")
                        TextField("例如: 读完 <<乔布斯自传>>", text: self.$title)
                            .padding(.leading,45)
                        Image(systemName:important ? "star.fill":"star")
                            .onTapGesture(count: 1, perform: {
                                important.toggle()
                            })
                            .padding(5)
                    }
//                    NavigationLink(destination: Tagseksl(checktag: self.$checktag)){
//                        Text("标签")
//                    }
                    NavigationLink(destination: Tagseksl( checktag: self.$checktag).environmentObject(self.userData)){
                        Text("标签")
                    } 
                }
                Section {
                    DatePicker(selection: self.$startDate, label: { Text("开始时间")})
                    DatePicker(selection: self.$endDate, label: { Text("开始时间")})
                }
                Section {
                    Toggle(isOn: self.$isCheckd) {
                    Text("记录进度")
                    }
                    if isCheckd {
                        HStack {
                            Text("进度单位")
                            TextField("例如: 章, 课, 小时等", text: self.$tag)
                            .padding(.leading,104)
                        }
                        HStack {
                            Text("进度总量")
                            TextField("必填", text: self.$a)
                                .padding(.leading,217)
                        }
                    }
                }
                if isCheckd {
                    Toggle(isOn: self.$cloock) {
                    Text("打卡项目")
                    }
                }
            }
            .navigationBarTitle(Text("新增项目"),displayMode: .inline)
            .navigationBarItems(
            leading:
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 18)
                .padding()
                .onTapGesture {
                    self.prose.wrappedValue.dismiss()
            }
            ,trailing:
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: 18)
                .padding()
                .onTapGesture {
                    self.userData.add(data: SingleToDo(title: self.title,tags: self.checktag,important:self.important))
                    self.prose.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
