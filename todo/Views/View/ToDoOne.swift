//
//  ToDoOne.swift
//  todo
//
//  Created by 二爷 on 2020/11/15.
//

import SwiftUI

struct ToDoOne: View {
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
    }
}

struct ToDoOne_Previews: PreviewProvider {
    static var previews: some View {
        ToDoOne()
    }
}
