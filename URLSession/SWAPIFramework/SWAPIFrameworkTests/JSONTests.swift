//
//  JSONTests.swift
//  SWAPIFrameworkTests
//
//  Created by Wilmer Barrios on 17/03/21.
//

import Foundation
import XCTest

/// Tests for JSON related foundation classes (studing purposes only)
class JSONTests: XCTestCase {
    
    func test_serializeValidJSON() {
        let json = ["data": "Valid JSON"]
        XCTAssertTrue(JSONSerialization.isValidJSONObject(json))
        XCTAssertNotNil(try! JSONSerialization.data(withJSONObject: json))
    }
    
    func test_decodeJSON() { // fetched data from remote/local source
        let json = makeDecodableEntityJSON()
        let decoder = JSONDecoder()
//        decoder.dataDecodingStrategy = .base64
        let decodedData = try! decoder.decode(DecodableEntity.self, from: makeDataFromJSON(json))
        XCTAssertEqual(decodedData.id, makeAnyID())
    }
    
    func test_encodeJSON() { // Data to be sent
        let dataToBeSent = makeEncodableEntity()
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        {
//          "id" : "anyId",
//          "value" : "anyValue",
//          "description" : "anyDescription"
//        }
        
//        encoder.outputFormatting = .sortedKeys
//        {"description":"anyDescription","id":"anyId","value":"anyValue"}
        
//        encoder.outputFormatting = .withoutEscapingSlashes
//        {"id":"anyId","value":"anyValue","description":"anyDescription"}
        
        let encodedData = try! encoder.encode(dataToBeSent)
        print(String(data: encodedData, encoding: .utf8)!)
        XCTAssertFalse((String(data: encodedData, encoding: .utf8)!.isEmpty))
    }
    
    // MARK: Helpers
    
    private func makeEncodableEntity() -> EncodableEntity {
        EncodableEntity(
            id: makeAnyID(),
            description: "anyDescription",
            value: "anyValue")
    }
    
    private func makeAnyID() -> String {
        "anyId"
    }
    
    private func makeDecodableEntityJSON() -> [String: Any] {
        return [
            "id": makeAnyID(),
            "description": "anyDescription",
            "value": "anyValue"
        ]
    }
    
    private func makeDataFromJSON(_ json: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    // MARK: Testing entities
    private struct DecodableEntity: Decodable {
        let id: String
        let description: String
        let value: String
    }
    
    private struct EncodableEntity: Encodable {
        let id: String
        let description: String
        let value: String
    }
}
