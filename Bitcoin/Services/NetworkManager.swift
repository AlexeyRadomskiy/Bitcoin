//
//  NetworkManager.swift
//  Bitcoin
//
//  Created by Alexey on 17.03.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchDataWithAlamofire(_ completion: @escaping(Result<Bitcoin, Error>) -> Void) {
        AF.request(Link.bitcoinRateApi.rawValue).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let bitcoin = Bitcoin.getBitcoinRate(from: value)
                    DispatchQueue.main.async {
                        completion(.success(bitcoin))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
    }
}
