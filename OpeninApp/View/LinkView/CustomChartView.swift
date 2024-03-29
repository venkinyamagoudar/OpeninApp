//
//  CustomChartView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI
import Charts

struct CustomChartView: View {
    @ObservedObject var viewModel: LinkViewModel
    private let curGradient = LinearGradient(
        gradient: Gradient (
            colors: [
                .blue.opacity(0.3),
                .white
            ]
        ),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack {
            HStack {
                Text("Overview")
                    .font(.custom("Figtree-Regular", size: 14))
                Spacer()
                HStack {
                    Text("Jan 24 - Aug 24")
                        .foregroundStyle(.black)
                        .font(.custom("Figtree-Regular", size: 12))
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 12, height: 12)
                }
                .padding(.all, 5)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        .opacity(0.5)
                        .foregroundStyle(.clear)
                }
            }
            .padding(.bottom, 10)
            Chart {
                ForEach(viewModel.clickData) { item in
                    LineMark(
                        x: .value("Month", item.date),
                        y: .value("Count", item.clickCount)
                    )
                }
                ForEach(viewModel.clickData) { item in
                    AreaMark(
                        x: .value("Month", item.date),
                        y: .value("Count", item.clickCount)
                    )
                    .foregroundStyle(curGradient)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.abbreviated))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 150)
        }
        .padding(.all, 10)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 8))
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    CustomChartView(viewModel: LinkViewModel())
}

