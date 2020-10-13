//
//  ToTest.swift
//  FlexibleModelProtocolTests
//
//  Created by hanwe on 2020/10/13.
//

import UIKit
import XCTest
@testable import FlexibleModelProtocol

class ToTest: XCTestCase {
    
    
    
    var mockModel:MyModel? = nil
    
    override func setUpWithError() throws {
        self.mockModel = makeMockModel()
    }

    override func tearDownWithError() throws {
    }
    
    func makeMockModel() -> MyModel {
        var myModel:MyModel = MyModel()
        var mySubModel:MySubModel = MySubModel()
        let myRowModel1:MyRowModel = MyRowModel(idx: "3832", code: "a1", location: "London", company: "kangol")
        let myRowModel2:MyRowModel = MyRowModel(idx: "1138", code: "b6", location: "Seoul", company: "LG")
        mySubModel.row.append(myRowModel1)
        mySubModel.row.append(myRowModel2)
        let myResultModel:MyResultModel = MyResultModel(code: "200", message: "Success")
        mySubModel.result = myResultModel
        mySubModel.list_total_count = "101"
        myModel.lostArticleBizInfo = mySubModel
        return myModel
    }
    
    func testToJson() {
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        let jsonString:String = mock.toJson()
        if jsonString == "" {
            XCTAssertTrue(false)
        }
        else {
            print("jsonString:\(jsonString)")
            XCTAssertTrue(true)
        }
    }
    
    func testToXml() {
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        if let xmlString:String = mock.toXML() {
            print("xmlString:\(xmlString)")
            XCTAssertTrue(true)
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testToDictionary() {
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        if let dic:[String:Any] = mock.toDictionary() {
            print("dictionary:\(dic)")
            XCTAssertTrue(true)
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testToNSDictionary() {
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        if let nsDic:NSDictionary = mock.toNSDictionary() {
            print("NSDictionary:\(nsDic)")
            XCTAssertTrue(true)
        }
        else {
            XCTAssertTrue(false)
        }
    }
}
