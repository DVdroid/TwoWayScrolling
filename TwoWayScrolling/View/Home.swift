//
//  Home.swift
//  TwoWayScrolling
//
//  Created by Vikash Anand on 23/11/23.
//

import SwiftUI
struct Home: View {
    
    @State private var currentTab = ""
    @Namespace var animationNameSpace
    @Environment(\.colorScheme) var scheme
    @State var onTapCurrentTab: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                    }
                    
                    Text("McDonald's - Town")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                
                //Scroll View Reader
                //To scroll tab automatically when user scrolls...
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(tabsItems) { tab in
                                VStack {
                                    Text(tab.tab)
                                        .foregroundColor(currentTab == tab.id ? .black : .gray)
                                    
                                    //For matched geometry effect
                                    if currentTab == tab.id {
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "TAB", in: animationNameSpace)
                                            .frame(height: 2)
                                            .padding(.horizontal, -5)
                                    } else {
                                        Capsule()
                                            .fill(.clear)
                                            .frame(height: 2)
                                            .padding(.horizontal, -5)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        onTapCurrentTab = tab.id
                                        proxy.scrollTo(tab.id, anchor: .topTrailing)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .onChange(of: currentTab) { _ in
                        withAnimation{
                            proxy.scrollTo(currentTab, anchor: .topTrailing)
                        }
                    }
                }
                .padding(.top)
            }
            .padding([.top])
            //Divider...
            .background(scheme == .dark ? Color.black: Color.white)
            .overlay(
                Divider()
                    .padding(.horizontal, -15),
                alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                //ScrollView reader to scroll to the content...
                ScrollViewReader { proxy in
                    VStack(spacing: 15) {
                        ForEach(tabsItems) { tab in
                            //Menu card view ...
                            MenuCardView(tab: tab, currentTab: $currentTab)
                                .padding(.top)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .onChange(of: onTapCurrentTab) { newValue in
                        withAnimation(.easeInOut){
                            proxy.scrollTo(onTapCurrentTab, anchor: .topTrailing)
                        }
                    }
                }
            }
            //Setting coordinate space name for offset
            .coordinateSpace(name: "SCROLL")
        }
        //Setting first tab
        .onAppear {
            currentTab = tabsItems.first?.id ?? ""
        }
    }
}

#Preview {
    Home()
}
