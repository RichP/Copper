//
//  OrderViewModel.swift
//  Copper
//
//  Created by user.admin on 30/11/2021.
//

import Foundation

struct OrderViewModel {    
    let title: String
    let dateString: String
    let valueString: String
    let statusString: String
    
    init(orderData: OrderItem) {
        var symbol: String = "+"
        switch orderData.orderType {
        case "buy":
            symbol = "+"
            self.title = "BTC -> " + orderData.currency
        case "sell":
            symbol = "-"
            self.title = "BTC -> " + orderData.currency
        case "deposit":
            symbol = "+"
            self.title = "In " + orderData.currency
        case "withdraw":
            symbol = "-"
            self.title = "Out " + orderData.currency
        default:
            self.title = ""
        }
        
        /*
         Figma design also doesn't show the 'at' text could be a different locale used
         Would need to query with the designer.  Ideally dates and times should use the OS format.
         with as few custom date formatters as possible
         */
        self.dateString =  itemFormatter.string(from: orderData.createdAt).replacingOccurrences(of: "at", with: "")
        
        // Unsure on number format. Need to check with designer
        let formattedAmount = String(format: "%.4f", orderData.amount)
        
        self.valueString = symbol + formattedAmount + " " + orderData.currency
        
        self.statusString = orderData.orderStatus.capitalized
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        // In  Figma these are lower case
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()
}
