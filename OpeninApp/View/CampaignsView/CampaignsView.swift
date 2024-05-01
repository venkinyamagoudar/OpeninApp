//
//  CampaignsView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct CampaignsView: View {
    var body: some View {
        VStack {
            Image(systemName: "speaker.wave.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("CampaignsView")
        }
        .padding()
    }
}

#Preview {
    CampaignsView()
}
