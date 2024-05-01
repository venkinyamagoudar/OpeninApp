//
//  LinkViewModel.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import Foundation

class LinkViewModel: ObservableObject {

    @Published var dashboardData: DashboardDataModel?
    @Published var error: Error?
    @Published var selectedLinks: LinksType = .topLinks
    @Published var searchbutton: Bool = false
    @Published var searchTerm: String = ""
    @Published var greeting: String = ""
    @Published var isLoading: Bool = false
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
    private let apiManager: APIManager
    private let memoryCache: MemoryCache
    private let diskCache: DiskCache
    private let cacheIdentifier = "dashboardDataCache"
    
    // Initializes the LinkViewModel with necessary dependencies and starts the timer.
    init() {
        self.apiManager = APIManager.shared
        self.memoryCache = MemoryCacheImpl()
        self.diskCache = DiskCacheImpl()
        startTimer()
    }
    
    // Deinitializes the timer.
    deinit {
        timer?.invalidate()
    }
    
    /// Description: Starts the timer for updating the greeting message.
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateGreeting()
        }
        timer?.fire()
    }
    
    /// Description: Updates the greeting message based on the current time.
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
    
    /// Description: Fetches data either from the network or cache based on network availability.
    func fetchDataAPIManager() {
        isLoading = true
        if NetworkReachability.shared.isNetworkAvailable() {
            fetchDataFromNetwork()
        } else {
            fetchDataFromCache()
        }
        isLoading = false
    }
    
    /// Description: Fetches data from the cache if available.
    private func fetchDataFromCache() {
        guard let cachedData: DashboardDataModel = memoryCache.get(for: cacheIdentifier) ?? diskCache.get(for: cacheIdentifier) else {
            self.error = DataError.noDataAvailable
            return
        }
        self.dashboardData = cachedData
    }
    
    /// Description: Fetches data from the network.
    private func fetchDataFromNetwork() {
        let dashboardEndpoint = APIManager.DashboardEndPoint()
        apiManager.request(modelType: DashboardDataModel.self, type: dashboardEndpoint) { [weak self] result, statusCode, error in
            guard let self = self else { return }
            if let error = error {
                self.error = error
                return
            }
            guard let statusCode = statusCode else {
                self.error = DataError.unknown(nil)
                return
            }
            if APIManager.isValidHttp(code: statusCode), let result = result {
                // Cache data
                self.dashboardData = result
                self.memoryCache.set(value: result, for: self.cacheIdentifier)
                self.diskCache.set(value: result, for: self.cacheIdentifier)
                
                // Cache images
                self.cacheImages(from: result.data.recentLinks)
                self.cacheImages(from: result.data.topLinks)
            } else {
                self.error = DataError.invalidResponse(nil, statusCode)
            }
        }
    }
    
    /// Description: Caches images from the provided links.
    /// - Parameter links: The links whose images are to be cached.
    private func cacheImages(from links: [Link]) {
        for link in links {
            guard let imageURL = URL(string: link.originalImage) else { continue }
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.memoryCache.set(value: data, for: link.originalImage)
                }
                if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                    let filePath = cacheDirectory.appendingPathComponent(link.originalImage)
                    do {
                        try data.write(to: filePath)
                    } catch {
                        print("Error writing image data to disk: \(error)")
                    }
                }
            }.resume()
        }
    }
}
