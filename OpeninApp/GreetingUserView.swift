//
//  GreetingUserView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct GreetingUserView: View {
    
    @ObservedObject var viewModel: LinkViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.greeting)
                .foregroundStyle(Color(.subtitle))
                .font(.custom("Figtree-Regular", size: 16))
                .font(.custom("Figtree-SemiBold", size: 24))
            HStack{
                Text("Venkatesh")
                    .foregroundStyle(Color(.titleBlack))
                    .font(.title)
                Image(.greeting)
                    .resizable()
                    .frame(width: 24,height: 24)
                Spacer()
            }
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 30)
        .padding(.leading)
    }
}

#Preview {
    GreetingUserView(viewModel: LinkViewModel())
}
