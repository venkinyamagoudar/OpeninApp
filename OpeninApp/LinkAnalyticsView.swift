//
//  LinkAnalyticsView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct LinkAnalyticsView: View {
    @ObservedObject var viewModel:LinkViewModel
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    LinkAnalyticCardView(
                        cardItem:
                            LinkAnalyticsModel(
                                image: .todayClicks,
                                cardTitle: String(viewModel.dashboardData?.todayClicks ?? 0),
                                cardDescription: "Today Clicks"))
                    LinkAnalyticCardView(
                        cardItem:
                            LinkAnalyticsModel(
                                image: .topLocation,
                                cardTitle: viewModel.dashboardData?.topLocation ?? "",
                                cardDescription: "Top location"))
                    LinkAnalyticCardView(
                        cardItem:
                            LinkAnalyticsModel(
                                image: .topSource,
                                cardTitle: viewModel.dashboardData?.topSource ?? "",
                                cardDescription: "Top source"))
                    LinkAnalyticCardView(
                        cardItem:
                            LinkAnalyticsModel(
                                image: .time,
                                cardTitle: "11:00 - 12:00",
                                cardDescription: "Best Time"))
                }
                .padding(.leading)
            }
            VStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(.analyticIcon)
                        Text("View Analytics")
                            .foregroundStyle(.titleBlack)
                            .font(.custom("Figtree-Bold", size: 16))
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.subtitle), lineWidth: 1)
                            .foregroundStyle(.clear)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LinkAnalyticsView(viewModel: LinkViewModel())
}
