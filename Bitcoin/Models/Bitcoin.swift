//
//  BTCRate.swift
//  Bitcoin
//
//  Created by Alexey on 17.03.2022.
//

import Foundation

// MARK: - Bitcoin
struct Bitcoin: Decodable {
    let time: Time
    let chartName: String?
    let bpi: Rate
    
    init() {
        time = Time(value: [:])
        chartName = ""
        bpi = Rate(value: [:])
    }
    
    init(bitcoinData: [String: Any]) {
        
        let timeDict = bitcoinData["time"] as? [String: String] ?? [:]
        time = Time(value: timeDict)
        
        chartName = bitcoinData["chartName"] as? String
        
        let bpiDict = bitcoinData["bpi"] as? [String: Any] ?? [:]
        bpi = Rate(value: bpiDict)
    }
    
    static func getBitcoinRate(from data: Any) -> Bitcoin {
        guard let data = data as? [String: Any] else { return Bitcoin() }
        return Bitcoin(bitcoinData: data)
    }
}

// MARK: - Time
struct Time: Decodable {
    let updateduk: String?
    
    init(value: [String: String]) {
        updateduk = value["updateduk"]
    }
}

// MARK: - Rate
struct Rate: Decodable {
    let USD: Сurrency
    let EUR: Сurrency
    
    init(value: [String: Any]) {
        let USDDict = value["USD"] as? [String: Any] ?? [:]
        USD = Сurrency(value: USDDict)
        
        let EURDict = value["EUR"] as? [String: Any] ?? [:]
        EUR = Сurrency(value: EURDict)
    }
}

// MARK: - Currency
struct Сurrency: Decodable {
    let rate_float: Double?
    
    init(value: [String: Any]) {
        rate_float = value["rate_float"] as? Double ?? 0
    }
}

// MARK: - Constants
enum Link: String {
    case bitcoinRateApi = "https://api.coindesk.com/v1/bpi/currentprice.json"
}
