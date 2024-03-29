//
//  MainTabView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MainTabView()
}

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomTabBarView()
    }
}

struct CustomTabBarView: View {
    var body: some View {
        HStack {
            TabBarItem(imageName: "mail", title: "Links")
            Spacer()
            TabBarItem(imageName: "fast-forward", title: "Courses")
            Spacer()
            AddTabItem()
            Spacer()
            TabBarItem(imageName: "magazine", title: "Campaigns")
            Spacer()
            TabBarItem(imageName: "user", title: "Profile")
        }
        .frame(height: 61)
        .padding(.horizontal, 20)
        .background(Color.white)
        
    }
}
struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addArc(center: CGPoint(x: rect.width/2, y: rect.height), radius: 20, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
        return path
    }
}

struct TabBarItem: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.caption)
        }
        .foregroundColor(Color.black)
        .frame(width: 80, height: 61)
    }
}

struct AddTabItem: View {
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .offset(y: -25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
