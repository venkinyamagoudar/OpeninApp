//
//  MainTabView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var tabViewHeight = CGFloat.zero
    @ObservedObject var viewModel: LinkViewModel = LinkViewModel()

    init() {
        UITabBar.appearance().backgroundColor =  UIColor.white
        UITabBar.appearance().barTintColor =  UIColor.white
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                TabBarItem(height: $tabViewHeight) {
                    DashboardView(viewModel: viewModel)
                }
                .tabItem {
                    Label("Links", image: .link)
                }
                TabBarItem(height: $tabViewHeight, content: {
                    CoursesView()
                        .background(Color(uiColor: .secondarySystemBackground))
                })
                .tabItem {
                    Label("Courses", image: .courses)
                }
                Spacer()
                TabBarItem(height: $tabViewHeight, content: {
                    CampaignsView()
                        .background(Color(uiColor: .secondarySystemBackground))
                })
                .tabItem {
                    Label("Campaigns", image: .campaigns)
                }
                TabBarItem(height: $tabViewHeight, content: {
                    ProfileView()
                        .background(Color(uiColor: .secondarySystemBackground))
                })
                .tabItem {
                    Label("Profile", image: .profile)
                }
            }
            AddTabItem(height: tabViewHeight)
        }
        .onAppear{
            viewModel.fetchDataAPIManager()
        }
    }
}

#Preview {
    MainTabView()
}

struct TabBarItem<V: View>: View {
    @Binding var height: CGFloat
    @ViewBuilder var content: () -> V
    var body: some View {
        GeometryReader { gp in
            content()
                .onAppear {
                    height = gp.safeAreaInsets.bottom
                }
                .onChange(of: gp.size, initial: true, {
                    height = gp.safeAreaInsets.bottom
                })
        }
    }
}

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let h = -rect.maxY * 0.35
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.midX / 2.0, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: h), control1: CGPoint(x: rect.midX * 0.85, y: rect.minY), control2: CGPoint(x: rect.midX * 0.85, y: h))
        path.addCurve(to: CGPoint(x: rect.midX * 3.0 / 2.0, y: rect.minY), control1: CGPoint(x: rect.midX * 1.15, y: h), control2: CGPoint(x: rect.midX * 1.15, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}

struct AddTabItem: View {
    let height: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            TabBarShape()
                .frame(maxWidth: .infinity, maxHeight: height)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .overlay(
            Button(action: {
                AddView()
                    .background(Color(uiColor: .secondarySystemBackground))
            }, label: {
                Circle().foregroundColor(.blue)
                    .frame(height: 65).aspectRatio(contentMode: .fit)
                    .shadow(color: .blue.opacity(0.6), radius: 5, y: 3)
                    .overlay(Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white))
                
            })
                .offset(y: -7.5)
            , alignment: .bottom)
    }
}
