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
    }
}
struct ToDoOneNew: View {
    var id:Int = 0
    @EnvironmentObject var userData:ToDo
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            HStack(alignment: .center, spacing: 0, content: {
                Button(action: { userData.check(id: self.id) }, label: {
                    Image(systemName: userData.todoList[id].isCheckd ? "circle" : "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(.black)
                        .padding(.trailing)
                })
                Text(self.userData.todoList[id].title)
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "star")
                        .foregroundColor(.black)
                })
            })
            .padding()
        }
    }
}

extension View {
    func leftOrReght(todo: SingleToDo ,userData: ToDo) -> some View {
        ZStack {
            Color(todo.offset < 0 ? .red : .blue )
            Color(todo.offset > 0 ? .brown : .clear)
                .offset(x: todo.offset / 2)
            HStack(spacing: 30) {
                Button(action: {}, label: {
                    Image(systemName: "sun.max")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.white)
                })
                Button(action: {}, label: {
                    Image(systemName: "list.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(.white)
                })
                Spacer()
                Button(action: { userData.delete(id: todo.id) }, label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.white)
                })
            }
            .padding(.horizontal)
            self
                .offset(x: todo.offset)
                .gesture(
                    DragGesture()
                        // 滑动
                        .onChanged({ (value) in
                            withAnimation(.default) {
                                if todo.direction == "left" && value.translation.width > 0 {
                                    userData.todoList[todo.id].offset = -60 + value.translation.width
                                } else if todo.direction == "right" && value.translation.width < 0 {
                                    userData.todoList[todo.id].offset = 100 + value.translation.width
                                } else {
                                    userData.todoList[todo.id].offset = value.translation.width
                                    userData.reset(id:todo.id)
                                }
                            }
                        })
                        // 滑动结束
                        .onEnded({ (value) in
                            withAnimation(.default) {
                                if todo.direction.isEmpty && value.translation.width < -30 {
                                    userData.todoList[todo.id].offset = -60
                                    userData.todoList[todo.id].direction = "left"
                                } else if todo.direction.isEmpty && value.translation.width > 30 {
                                    userData.todoList[todo.id].offset = 100
                                    userData.todoList[todo.id].direction = "right"
                                } else {
                                    userData.todoList[todo.id].offset = 0
                                    userData.todoList[todo.id].direction = ""
                                }
                            }
                        })
            )
        }
        .cornerRadius(6)
        .padding(.horizontal)
    }
}




struct ToDoOne_Previews: PreviewProvider {
    static var previews: some View {
        ToDoOne()
    }
}
