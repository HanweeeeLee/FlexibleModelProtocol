//
//  FromTest.swift
//  FlexibleModelProtocolTests
//
//  Created by hanwe on 2020/10/13.
//

import UIKit
import XCTest
@testable import FlexibleModelProtocol

class FromTest: XCTestCase {
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func testFromJson() {
        if let path = Bundle(for: type(of: self)).path(forResource: "SampleJson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let myModel: MyModel = MyModel.fromJson(jsonData: data, object: MyModel()) {
                    let mainModel = myModel.lostArticleBizInfo
                    XCTAssertNotEqual(mainModel.list_total_count, "")
                    XCTAssertNotEqual(mainModel.result.code, "")
                    XCTAssertNotEqual(mainModel.result.message, "")
                    XCTAssertGreaterThan(mainModel.row.count, 0)
                }
                else {
                    XCTAssertTrue(false)
                }
            } catch {
                XCTAssertTrue(false)
            }
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testFromJson2() {
        if let path = Bundle(for: type(of: self)).path(forResource: "SampleJson2", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let myModel: MyRowModel2 = MyRowModel2.fromJson(jsonData: data, object: MyRowModel2(location: "New Your", company: "Coach")) {
                    XCTAssertNotEqual(myModel.code, "")
                    XCTAssertNotEqual(myModel.company, "")
                    XCTAssertNotEqual(myModel.idx, "")
                    XCTAssertNotEqual(myModel.location, "")
                    XCTAssertNotEqual(myModel.location, "New Your")
                    XCTAssertNotEqual(myModel.company, "Coach")
                }
                else {
                    XCTAssertTrue(false)
                }
            } catch {
                XCTAssertTrue(false)
            }
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testFromXml() {
        if let path = Bundle(for: type(of: self)).path(forResource: "SampleXML", ofType: "xml") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let myModel: MyModel = MyModel.fromXML(xmlData: data, object: MyModel()) {
                    let mainModel = myModel.lostArticleBizInfo
                    XCTAssertNotEqual(mainModel.list_total_count, "")
                    XCTAssertNotEqual(mainModel.result.code, "")
                    XCTAssertNotEqual(mainModel.result.message, "")
                    XCTAssertGreaterThan(mainModel.row.count, 0)
                }
                else {
                    XCTAssertTrue(false)
                }
            } catch {
                XCTAssertTrue(false)
            }
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
}
