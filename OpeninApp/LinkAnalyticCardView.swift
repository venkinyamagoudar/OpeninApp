//
//  LinkAnalyticCardView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct LinkAnalyticCardView: View {
    
    var cardItem : LinkAnalyticsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(cardItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(.bottom, 15)
            Text(cardItem.cardTitle)
                .foregroundColor(Color(.titleBlack))
                .font(.custom("Figtree-SemiBold", size: 16))
                .lineLimit(1)
            Text(cardItem.cardDescription)
                .foregroundColor(Color(.subtitle))
                .font(.custom("Figtree-Regular", size: 14))
                .lineLimit(1)
        }
        .foregroundColor(.white)
        .frame(width: 120, height: 120)
        .background(.titleWhite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}

#Preview {
    LinkAnalyticCardView(
        cardItem:
            LinkAnalyticsModel(
                image: .todayClicks,
                cardTitle: "123",
                cardDescription: "TODAY CLICKS"))
}
