//
//  NetworkReachability.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI
import Network

class NetworkReachability {
    var pathMonitor: NWPathMonitor!
    var path: NWPath?
    lazy var pathUpdateHandler: ((NWPath) -> Void) = { path in
        self.path = path
        if path.status == NWPath.Status.satisfied {
            debugPrint("NetworkReachability - Connected")
        } else if path.status == NWPath.Status.unsatisfied {
            debugPrint("NetworkReachability - unsatisfied")
        } else if path.status == NWPath.Status.requiresConnection {
            debugPrint("NetworkReachability - requiresConnection")
        }
    }

    let backgroudQueue = DispatchQueue.global(qos: .background)

    static let shared = NetworkReachability()

    init() {
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = self.pathUpdateHandler
        pathMonitor.start(queue: backgroudQueue)
    }

    func isNetworkAvailable() -> Bool {
        if let path = self.path {
            if path.status == NWPath.Status.satisfied {
                return true
            }
        }
        return false
    }
}
