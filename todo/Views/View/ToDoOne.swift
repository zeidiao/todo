//
//  ToDoOne.swift
//  todo
//
//  Created by 二爷 on 2020/11/15.
//

import SwiftUI

struct ToDoOne: View {
    @State var sheet:Bool = false
    var id:Int = 0
    @EnvironmentObject var userData:ToDo
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 34)
                    .frame(width: 300)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                Spacer()
            }
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(34)
            .shadow(radius: 4)
            .overlay(
                HStack {
                    Text(self.userData.todoList[id].title)
                    .padding(.leading)
                    Spacer()
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 26)
                        .foregroundColor(.red)
                        .onTapGesture(count: 1, perform: {
                            self.userData.delete(id: self.id)
                    })
                    Image(systemName: self.userData.todoList[id].isCheckd ? "bolt.circle" : "bolt.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 29)
                        .foregroundColor(.red)
                        .padding(.trailing)
                        .onTapGesture(count: 1, perform: {
                            self.userData.check(id: self.id)
                        })
                }
            )
                .padding(.horizontal)
        }
        .actionSheet(isPresented: $sheet, content: {
            ActionSheet(title: Text("你想干哈"), buttons: [
                .default(Text("移动")){},
                .default(Text("修改")){},
                .destructive(Text("删除")){
                    userData.delete(id: self.id)
                },
                .cancel(Text("取消")){
                    sheet = false
                }
            ])
        })
        .onTapGesture {
            sheet.toggle()
        }
    }
}

struct ToDoOne_Previews: PreviewProvider {
    static var previews: some View {
        ToDoOne()
    }
}
