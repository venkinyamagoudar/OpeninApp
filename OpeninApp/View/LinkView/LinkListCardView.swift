//
//  LinkListCardView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct LinkListCardView: View {
    let link: Link
    var body: some View {
        VStack{
            HStack {
                HStack {
                    if let imageURL = URL(string: link.originalImage) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 48, height: 48)
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(.rect(cornerRadius: 8))
                        } placeholder: {
                            ProgressView()
                                .opacity(0.3)
                                .frame(width: 48, height: 48)
                        }
                        .frame(height: 48)
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                    }
                    VStack {
                        Text(link.webLink)
                            .foregroundStyle(.titleBlack)
                            .font(.custom("Figtree-Regular", size: 14))
                            .lineLimit(1)
                            .onTapGesture {
                                if let url = URL(string: link.webLink) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                        Text(link.createdAt.formatDate())
                            .foregroundStyle(.subtitle)
                            .font(.custom("Figtree-Regular", size: 12))
                    }
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(link.totalClicks)")
                        .foregroundStyle(.titleBlack)
                        .font(.custom("Figtree-Bold", size: 14))
                    Text("Clicks")
                        .foregroundStyle(.subtitle)
                        .font(.custom("Figtree-Regular", size: 12))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
            .background(Color.white)
            HStack {
                Text(link.smartLink)
                    .foregroundStyle(.accentBlue)
                    .lineLimit(1)
                    .onTapGesture {
                        if let url = URL(string: link.smartLink) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                Spacer()
                Button {
                    UIPasteboard.general.string = link.smartLink
                } label: {
                    Image(.copyButton)
                }
            }
            .padding(.horizontal, 15)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .foregroundStyle(.accentBlue)
                    .opacity(0.7)
                    .frame(height: 40)
                    .background {
                        Rectangle()
                            .foregroundStyle(.linkCellBackground)
                    }
            })
        }
        .background {
            Rectangle()
                .foregroundStyle(.linkCellBackground)
        }
        .padding(.vertical)
    }
}

#Preview {
    LinkListCardView(
        link: Link(
            urlID: 123,
            webLink: "https://example.com",
            smartLink: "https://smartlink.com",
            title: "Example Title",
            totalClicks: 100,
            originalImage: "example.jpg",
            thumbnail: nil,
            timesAgo: .the1YrAgo,
            createdAt: "2023-03-15T07:33:50.000Z",
            domainID: .inopenappCOM,
            urlPrefix: nil,
            urlSuffix: "suffix",
            app: "Example App",
            isFavourite: true
        ))
}
