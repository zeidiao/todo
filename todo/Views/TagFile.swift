//
//  TagFile.swift
//  DATA
//
//  Created by 二爷 on 2020/9/20.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct tklsk: View {
    @Binding var tagNew:Bool
    @Binding var newTag:String
    @State var l:[String] = []
    @EnvironmentObject var userData:ToDo
    var body: some View {
        HStack {
            TextField("添加标签", text: $newTag, onCommit: {
                self.newTag = newTag.replacingOccurrences(of: " ", with: "")
                userData.tags.forEach { tag in
                    self.l.append(tag.str)
                }
                if !self.newTag.isEmpty && !self.l.contains(newTag) {
                    userData.TagsAdd(data: Tags(str: self.newTag))
                    self.newTag = ""
                }
                tagNew = false
            })
            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            Button(action: {
                self.newTag = newTag.replacingOccurrences(of: " ", with: "")
                userData.tags.forEach { tag in
                    self.l.append(tag.str)
                }
                if !self.newTag.isEmpty && !self.l.contains(newTag) {
                    userData.TagsAdd(data: Tags(str: self.newTag))
                    self.newTag = ""
                }
                tagNew = false
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
    }
}
