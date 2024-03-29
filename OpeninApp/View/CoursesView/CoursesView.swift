//
//  CoursesView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI

struct CoursesView: View {
    var body: some View {
        VStack {
            Image(systemName: "book.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("CoursesView")
        }
    }
}

#Preview {
    CoursesView()
}
