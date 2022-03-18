//
//  NetworkManager.swift
//  Bitcoin
//
//  Created by Alexey on 17.03.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(_ completion: @escaping(Bitcoin) -> Void) {
        guard let url = URL(string: Link.bitcoinRateApi.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
        
            do {
                let bitcoin = try JSONDecoder().decode(Bitcoin.self, from: data)
                DispatchQueue.main.async {
                    completion(bitcoin)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
