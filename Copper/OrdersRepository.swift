//
//  OrdersRepository.swift
//  Copper
//
//  Created by Richard Pickup on 30/11/2021.
//

import Combine
import CoreData
import Foundation

enum OrdersViewModelState {
    case initial
    case loading
    case success
    case error
}


class OrderRepository: ObservableObject {
    private var orders: [OrderViewModel] = []
    
    @Published var state: OrdersViewModelState = .initial
    
    var cancellationToken: AnyCancellable?
    
    private let client: CopperClient?
    private let persistence: NSPersistentContainer!
    
    init(client: CopperClient, persistence: NSPersistentContainer = PersistenceController.shared.container) {
        self.client = client
        self.persistence = persistence
    }
    
    func fetchOrders() {
        self.state = .loading
        cancellationToken = client?.orders()
            .mapError({ (error) -> Error in
                self.state = .error
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                let workContext = self.persistence.newBackgroundContext()
                workContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                let mainContext = self.persistence.viewContext
                
                var index = 0
                let dtoItems = $0.orders
                let total = dtoItems.count
                
                workContext.performAndWait {
                    let insertRequest = NSBatchInsertRequest(entity: OrderItem.entity()){ (managedObject: NSManagedObject) -> Bool in
                        guard index < total else { return true }
                        if let order = managedObject as? OrderItem {
                            let data = dtoItems[index]
                            order.updateProperties(from: data)
                        }
                        index += 1
                        return false
                    }
                    insertRequest.resultType = NSBatchInsertRequestResultType.objectIDs
                    
                    let result = try? workContext.execute(insertRequest) as? NSBatchInsertResult
                    if let objectIDs = result?.result as? [NSManagedObjectID], !objectIDs.isEmpty {
                        let save = [NSInsertedObjectsKey: objectIDs]
                        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: save, into: [mainContext])
                    }
                }
                self.state = .success
            })
    }
}



extension OrderRepository {
    static var request: NSFetchRequest<OrderItem> {
        let request = NSFetchRequest<OrderItem>(entityName: "OrderItem")
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \OrderItem.createdAt,
                ascending: false)]
        request.fetchBatchSize = 1000
        return request
    }
}

