//
//  BTCRate.swift
//  Bitcoin
//
//  Created by Alexey on 17.03.2022.
//

struct Bitcoin: Decodable {
    let time: Time
    let chartName: String?
    let bpi: Rate
}

struct Time: Decodable {
    let updateduk: String?
}

struct Rate: Decodable {
    let USD: Сurrency
    let EUR: Сurrency
}

struct Сurrency: Decodable {
    let code: String?
    let rate_float: Float?
}

enum Link: String {
    case bitcoinRateApi = "https://api.coindesk.com/v1/bpi/currentprice.json"
}
