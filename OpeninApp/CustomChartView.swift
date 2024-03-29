//
//  CustomChartView.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import SwiftUI
import Charts

struct CustomChartView: View {
    @State var clickData =
    [
        ClickData(year: 2024, month: 1, day: 1, clickCount: 34),
        ClickData(year: 2024, month: 2, day: 1, clickCount: 56),
        ClickData(year: 2024, month: 3, day: 1, clickCount: 78),
        ClickData(year: 2024, month: 4, day: 1, clickCount: 75),
        ClickData(year: 2024, month: 5, day: 1, clickCount: 100),
        ClickData(year: 2024, month: 6, day: 1, clickCount: 50),
        ClickData(year: 2024, month: 7, day: 1, clickCount: 45),
        ClickData(year: 2024, month: 8, day: 1, clickCount: 100),
        ClickData(year: 2024, month: 9, day: 1, clickCount: 45)
    ]
    
    var body: some View {
        
        let curColor = Color(hue: 0.33, saturation: 0.81, brightness: 0.76)
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    .blue.opacity(0.3),
                    .white
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
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
                ForEach(clickData) { item in
                    LineMark(
                        x: .value("Month", item.date),
                        y: .value("Count", item.clickCount)
                    )
                }
                ForEach(clickData) { item in
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
    CustomChartView()
}

struct ClickData: Identifiable {
    let id = UUID()
    let date: Date
    let clickCount: Int
    
    init(year: Int, month: Int, day: Int, clickCount: Int) {
        self.clickCount = clickCount
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
    }
}
