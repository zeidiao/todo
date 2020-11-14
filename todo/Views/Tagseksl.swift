//
//  Tagseksl.swift
//  DATA
//
//  Created by 二爷 on 2020/9/17.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct Tagseksl: View {
    @State var showAlert = false
    @EnvironmentObject var userData:ToDo
    @Binding var checktag:[String]
    @State var isR:Bool = false
    @State var newTag:String = ""
    @Environment(\.presentationMode)var prose
    var body: some View {
        VStack {
            HStack {
                TextField("添加标签", text: $newTag, onCommit: {
                    self.newTag = newTag.replacingOccurrences(of: " ", with: "")
                    userData.tags.forEach { tag in
                        if !self.newTag.isEmpty && self.newTag != tag.str {
                            userData.TagsAdd(data: Tags(str: self.newTag))
                            self.newTag = ""
                        }
                    }
                })
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                Button(action: {
                    self.newTag = newTag.replacingOccurrences(of: " ", with: "")
                    userData.tags.forEach { tag in
                        if !self.newTag.isEmpty && self.newTag != tag.str {
                            userData.TagsAdd(data: Tags(str: self.newTag))
                            self.newTag = ""
                        }
                    }
                }){
                    Image(systemName: "plus")
                        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
                }
            }
            .padding(.vertical,7)
            .padding(.horizontal,10)
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
            )
            .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)), lineWidth: 0.1)
            )
            GeometryReader {
                self.generateContent(geometry: $0)
            }
        }
        .padding(20)
        .navigationBarTitle("选择标签")
        .navigationBarItems(
            trailing:
                Button(action: {
                    if self.isR {
                        self.checktag.forEach{ tag in
                            userData.tags.forEach { T in
                                if tag == T.str {
                                    self.userData.deleteTags(id: T.id)
                                }
                            }
                        }
                    } else {
                        self.prose.wrappedValue.dismiss()
                    }
                }, label: {
                    Image(systemName: self.isR ? "trash" : "checkmark")
                        .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                        .padding()
                }))
    }
    func generateContent(geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading){
            ForEach(self.userData.tags){tag in
//                item(title: tag)
//                item(checktag: self.$checktag, title: tag)
                
                if !tag.delete {
                    item(checktag: self.$checktag, isR: self.$isR, isChecked: self.checktag.contains(tag.str), title: tag.str)
                    
                        .padding(4)
                        .alignmentGuide(.leading, computeValue: {d in
                            if(abs(width - d.width) > geometry.size.width){
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag.str == self.userData.tags.filter{ $0.delete == false }.last!.str {
                                width = 0
                            } else{
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if tag.str == self.userData.tags.filter{ $0.delete == false }.last!.str {
                                height = 0
                            }
                            return result
                        })
                }
            }
        }
    }
}

struct item: View {
    @Binding var checktag:[String]
    @Binding var isR:Bool
    @State var isChecked:Bool = false
    var title:String = ""
    var body: some View {
            Text(title)
                .padding(.all,5)
                .font(.body)
                .background(isChecked ?  Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)))
                .foregroundColor(isChecked ? Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .cornerRadius(7)
                .onTapGesture(count: 1, perform: {
                    self.isChecked.toggle()
                    if self.isChecked {
                        self.checktag.append(self.title)
                    } else {
                        self.checktag.removeAll{$0 == self.title}
                    }
                })
                .onLongPressGesture {
                    self.isR = true
                }
    }
}

struct Tagseksl_Previews: PreviewProvider {
    static var previews: some View {
        Tagseksl(checktag: .constant(["生活","学习"]))
    }
}
