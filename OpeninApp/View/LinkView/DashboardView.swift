//
//  ContentView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: LinkViewModel
    var body: some View {
        VStack {
            dashboardNavigation
            dashboardBody
        }
        .background {
            Color.blue
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private var dashboardNavigation: some View {
        HStack {
            Text("Dashboard")
                .foregroundStyle(Color(.titleWhite))
                .font(.custom("Figtree-SemiBold", size: 24))
            Spacer()
            Button {
                
            } label: {
                Image(.settingButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    @ViewBuilder
    private var dashboardBody: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                if true {
                    GreetingUserView(viewModel: viewModel)
                    CustomChartView(viewModel: viewModel)
                    LinkAnalyticsView(viewModel: viewModel)
                    LinksListView(viewModel: viewModel)
                    SupportButtonView(image: .whatsappIcon, title: "Talk with us", color: .whatsapp)  {
                        if let url = URL(string: "wa.me/\(String(describing: viewModel.dashboardData?.supportWhatsappNumber))") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    SupportButtonView(image: .questionIcon, title: "Frequently Asked Question", color: .question, action: {})
                } else {
                    ProgressView()
                        .padding(.top, 250)
                }
            }
        }
        .background {
            Color(.background)
                .frame(width: UIScreen.main.bounds.width)
                .clipShape(.rect(cornerRadius: 16, style: .continuous))
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    DashboardView(viewModel: LinkViewModel())
}
