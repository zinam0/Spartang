//
//  ContentView.swift
//  Spartang
//
//  Created by t2023-m0019 on 7/4/24.
//
import SwiftUI

struct ContentView: View {
    @State var currentTab: Int = 0
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                View1().tag(0)
                View2().tag(1)
                View3().tag(2)
                View4().tag(3)
                View5().tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .edgesIgnoringSafeArea(.all)
            
            TabBarView(currentTab: self.$currentTab)
                .padding(.top, 45)
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    var tabBarOptions: [String] = ["Cart", "안주", "탕", "술", "음료"]
    var body: some View {
        //        ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 0) {
            ForEach(Array(zip(self.tabBarOptions.indices,
                              self.tabBarOptions)),
                    id: \.0,
                    content: {
                index, name in
                TabBarItem(currentTab: self.$currentTab,
                           namespace: namespace.self,
                           tabBarItemName: name,
                           tab: index)
                
            }
            )
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .frame(width: 80)
            .frame(height: 80)
            
        }
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                    .font(.system(size: 20))
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}

struct View1: View {
    var body: some View {
        Color.red
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
    }
}

struct View2: View {
    var body: some View {
        Color.yellow
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
    }
}

struct View3: View {
    var body: some View {
        Color.green
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
    }
}

struct View4: View {
    var body: some View {
        Color.blue
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
    }
}

struct View5: View {
    var body: some View {
        Color.cyan
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
