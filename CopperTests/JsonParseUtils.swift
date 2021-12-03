//
//  JsonParseUtils.swift
//  CopperTests
//
//  Created by user.admin on 01/12/2021.
//

import Foundation

@testable import Copper

final class JSONParseUtils {
    static func loadDataFromJsonFile(name: String) -> Data? {
        let bundle = Bundle(for: JSONParseUtils.self)
        guard let path = bundle.path(forResource: name, ofType: "json") else { return nil }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
