//
//  TabBar.swift
//  todo
//
//  Created by 二爷 on 2020/11/25.
//

import SwiftUI

struct TabBar: View {
    
    @State var title:[String] = ["热榜","国际上是","文章","音乐","健康","游戏","上海","科技","关注","推荐","哈哈","美食家"]
    @State var selectIndex:Int = 0
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 0, content: {
                    ScrollViewReader(content: { proxy in
                        HStack(alignment: .center, spacing: 10, content: {
                            ForEach(0..<title.count) { index in
                                Text(title[index])
//                                    .frame(width:  50)
                                    .foregroundColor(selectIndex == index ? Color.red : Color.black)
                                    .id(index)
                                    .background(
                                          GeometryReader { geometryProxy in
                                            Color.clear
                                                .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                                          }
                                        )
                                    .onPreferenceChange(SizePreferenceKey.self) { newSize in
                                        print("\(title[index]) size is: \(newSize)")
                                        }
                                    .onChange(of: selectIndex, perform: { _ in
                                        if title.count - selectIndex > 3 {
                                            withAnimation(.default) {
                                                proxy.scrollTo(selectIndex,anchor: .center)
                                            }
                                        }
                                    })
                                    .onTapGesture {
                                        self.selectIndex = index
                                            
                                    }
                            }
                        })
                        .padding(.horizontal)
                    })
                    
                    VStack {
                        Image(systemName: "circle.fill")
                            .scaleEffect(0.4)
                            .foregroundColor(.red)
                            .offset(x: CGFloat(selectIndex*50))
                            .animation(.default)
                    }
                    .frame(width: 50)
                })
            })
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
