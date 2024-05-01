//
//  ProgressLoader.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

/// Class responsible for managing and displaying a progress loader.
class ProgressLoader {
    
    /// Singleton instance of ProgressLoader.
    static let shared = ProgressLoader()
    
    /// The UIActivityIndicatorView used for indicating progress.
    private var activityIndicator: UIActivityIndicatorView!
    
    /// Initializes the ProgressLoader instance.
    private init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                activityIndicator.center = window.center
                window.addSubview(activityIndicator)
            }
        }
        activityIndicator.hidesWhenStopped = true
    }

    /// Function to start the activity indicator.
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if windowScene.windows.first != nil {
                    // window.isUserInteractionEnabled = false
                }
            }
        }
    }

    /// Function to stop the activity indicator.
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if windowScene.windows.first != nil {
                    // window.isUserInteractionEnabled = true
                }
            }
        }
    }
}
