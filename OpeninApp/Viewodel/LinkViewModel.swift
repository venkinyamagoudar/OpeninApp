//
//  LinkViewModel.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import Foundation

class LinkViewModel: ObservableObject {
    let networkManager = NetworkManager.shared
    
    @Published var dashboardData: DashboardDataModel?
    @Published var error: NetworkManager.NetworkError?
    @Published var selectedLinks: LinksModel = .topLinks
    @Published var searchbutton: Bool = false
    @Published var searchTerm: String = ""
    @Published var greeting: String = ""
    @Published var clickData =
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
    private var timer: Timer?
    
    init() {
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }
    
    func fetchData() {
        let endpoint = "https://api.inopenapp.com/api/v1/dashboardNew"
        networkManager.fetchData(from: endpoint) { [weak self] (result: Result<DashboardDataModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dashboardData = data
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateGreeting()
        }
        timer?.fire()
    }
    
    private func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<5:
            greeting = "Good Night"
        case 5..<12:
            greeting = "Good morning"
        case 12..<17:
            greeting = "Good Afternoon"
        default:
            greeting = "Good Evening"
        }
    }
}
