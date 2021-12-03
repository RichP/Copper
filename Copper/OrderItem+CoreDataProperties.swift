//
//  OrderItem+CoreDataProperties.swift
//  Copper
//
//  Created by user.admin on 30/11/2021.
//
//

import Foundation
import CoreData


extension OrderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        return NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }
    @NSManaged public var orderID: String
    @NSManaged public var createdAt: Date
    @NSManaged public var currency: String
    @NSManaged public var orderType: String
    @NSManaged public var orderStatus: String
    @NSManaged public var amount: Double

}

extension OrderItem : Identifiable {
    
    func updateProperties(from order: Order) {
        let milliseconds = Double(order.createdAt) ?? Date().timeIntervalSince1970
        self.createdAt = Date(timeIntervalSince1970: (milliseconds / 1000.0))
        self.orderStatus = order.orderStatus.rawValue
        self.orderType = order.orderType.rawValue
        self.currency = order.currency.rawValue
        self.orderID = order.orderID
        self.amount = Double(order.amount) ?? 0
    }

}
