//
//  ContentView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            dashboardHeader
            dashboardContent
        }
        .background {
            Color.blue
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private var dashboardHeader: some View {
        HStack {
            Text("Dashboard")
                .foregroundStyle(Color(.white))
                .font(.custom("Figtree-SemiBold", size: 24))
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "settings")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    @ViewBuilder
    private var dashboardContent: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
            }
        }
        .background {
            
        }
    }
}

#Preview {
    DashboardView()
}

