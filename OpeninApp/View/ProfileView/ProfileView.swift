//
//  ProfileView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                Text("ProfileView")
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
