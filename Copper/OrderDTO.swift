// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(OrderResponse.self, from: jsonData)

import Foundation

// MARK: - Orders
struct OrderResponse: Codable {
    let orders: [Order]
}

// MARK: - Order
struct Order: Codable {
    let orderID: String
    let currency: Currency
    let amount: String
    let orderType: OrderType
    let orderStatus: OrderStatus
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case currency, amount, orderType, orderStatus, createdAt
    }
}

enum Currency: String, Codable {
    case algo = "ALGO"
    case bsc = "BSC"
    case btc = "BTC"
    case dash = "DASH"
    case doge = "DOGE"
    case eos = "EOS"
    case eth = "ETH"
    case mob = "MOB"
    case xrp = "XRP"
}

enum OrderStatus: String, Codable {
    case approved = "approved"
    case canceled = "canceled"
    case executed = "executed"
    case processing = "processing"
}

enum OrderType: String, Codable {
    case buy = "buy"
    case deposit = "deposit"
    case sell = "sell"
    case withdraw = "withdraw"
}
