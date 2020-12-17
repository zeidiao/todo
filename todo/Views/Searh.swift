//
//  Searh.swift
//  todo
//
//  Created by 二爷 on 2020/11/15.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var userData:ToDo
    @State var saerh:String = ""
    @Environment(\.presentationMode)var prose
    var body: some View {
        HStack(alignment: .center, spacing: 14, content: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            TextField("搜索", text: $saerh)
            Text("取消")
                .onTapGesture {
                    self.prose.wrappedValue.dismiss()
                }
            VStack {
                
            }
        })
        .padding(.horizontal)
        ForEach(self.userData.todoList){ todo in
            if !todo.delete && todo.title.contains(saerh) {
                ToDoOne(id: todo.id)
                    .environmentObject(self.userData)
                    .padding(.top)
            }
        }
        Spacer()
    }
}

struct Searh_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
