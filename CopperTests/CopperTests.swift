//
//  CopperTests.swift
//  CopperTests
//
//  Created by Richard Pickup on 30/11/2021.
//

import XCTest
import CoreData
@testable import Copper

class CopperTests: XCTestCase {
    var repo: OrderRepository?
    let fetchRequest: NSFetchRequest<OrderItem> = OrderRepository.request
    let context = PersistenceController.preview.container.viewContext
    let mockClient = MockApiClient(fileName: "mockData")
    
    override func setUpWithError() throws {
        let persistence = PersistenceController.preview.container
        
        repo = OrderRepository(client: mockClient, persistence: persistence)
        repo?.fetchOrders()
    }
    
    override func tearDownWithError() throws {
        guard let objects = try? context.fetch(fetchRequest) else {
            return
        }
        
        for object in objects {
            context.delete(object)
        }
    }
    
    func testRepoHasSavedData() throws {
        // When
        guard let result = try? context.fetch(fetchRequest) else {
            XCTFail("Fetch request failed")
            return
        }
        let firstOrder = result.first
        
        // Then
        XCTAssertEqual(result.count, mockClient.orderData?.orders.count)
        XCTAssertEqual(result.count, 16)
        
        XCTAssertEqual(firstOrder?.orderID, "dfcf944148b63acd99a922d917361b69")
        XCTAssertEqual(firstOrder?.currency, "DASH")
        XCTAssertEqual(firstOrder?.orderType, "buy")
        XCTAssertEqual(firstOrder?.orderStatus, "processing")
        XCTAssertEqual(firstOrder?.amount, 48.61485402)
        XCTAssertEqual(firstOrder?.createdAt.timeIntervalSince1970, 1625675705.438)
    }
    
    
    func testFetchOrder() throws {
        // When
        guard let result = try? context.fetch(fetchRequest) else {
            XCTFail("Fetch request failed")
            return
        }
        guard let firstOrder = result.first,
              let lastOrder = result.last else {
                  XCTFail("Could not get results")
                  return
              }
        
        XCTAssertTrue(firstOrder.createdAt > lastOrder.createdAt)
    }
    
    
    func testViwModel() throws {
        // When
        guard let result = try? context.fetch(fetchRequest) else {
            XCTFail("Fetch request failed")
            return
        }
        guard let firstOrder = result.first else {
            XCTFail("No object found")
            return
        }
        let viewModel = OrderViewModel(orderData: firstOrder)
        
        XCTAssertEqual(viewModel.title, "BTC -> DASH")
        XCTAssertEqual(viewModel.dateString, "Jul 7, 2021  5:35 pm")
        XCTAssertEqual(viewModel.valueString, "+48.6149 DASH")
        XCTAssertEqual(viewModel.statusString, "Processing")
        
    }
    
    
}
