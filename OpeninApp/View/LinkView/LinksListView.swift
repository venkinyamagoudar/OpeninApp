//
//  LinksListView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct LinksListView: View {
    @ObservedObject var viewModel: LinkViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.selectedLinks = .topLinks
                } label: {
                    Text("Top Links")
                        .foregroundStyle(viewModel.selectedLinks == .topLinks ? .titleWhite : .titleBlack)
                        .font(.custom("Figtree-Medium", size: 16))
                        .padding(.all, 10)
                        .background(viewModel.selectedLinks == .topLinks ? .accentBlue : .clear)
                        .clipShape(.capsule)
                }
                Button {
                    viewModel.selectedLinks = .recentLinks
                } label: {
                    Text("Recent Links")
                        .foregroundStyle(viewModel.selectedLinks == .recentLinks ? .titleWhite : .titleBlack)
                        .font(.custom("Figtree-Medium", size: 16))
                        .padding(.all, 10)
                        .background(viewModel.selectedLinks == .recentLinks ? .accentBlue : .clear)
                        .clipShape(.capsule)
                }
                Spacer()
                Button {
                    viewModel.searchbutton.toggle()
                } label: {
                    Image(.searchButton)
                        .resizable()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.horizontal)
            if viewModel.searchbutton {
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                    TextField("Search", text: $viewModel.searchTerm)
                        .foregroundStyle(.titleBlack)
                        .font(.custom("Figtree-Medium", size: 16))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.subtitle), lineWidth: 1)
                        .foregroundStyle(.clear)
                }
                .padding(.horizontal)
                .onChange(of: viewModel.searchTerm) { oldValue, newValue in
                    
                }
            }
            switch viewModel.selectedLinks {
                case .topLinks:
                    ScrollView(showsIndicators: false) {
                        if let topLinks = viewModel.dashboardData?.data.topLinks {
                            ForEach(topLinks) { link in
                                LinkListCardView(link: link)
                            }
                        }
                    }
                case .recentLinks:
                    ScrollView(showsIndicators: false) {
                        if let recentLinks = viewModel.dashboardData?.data.recentLinks {
                            ForEach(recentLinks) { link in
                                LinkListCardView(link: link)
                            }
                        }
                    }
            }
            VStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(.link)
                        Text("View All Links")
                            .foregroundStyle(.titleBlack)
                            .font(.custom("Figtree-Medium", size: 16))
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
                .padding(.top)
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    LinksListView(viewModel: LinkViewModel())
}

enum LinksModel {
    case topLinks
    case recentLinks
}

