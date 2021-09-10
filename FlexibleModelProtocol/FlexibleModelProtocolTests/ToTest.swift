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
    
    
    
    var mockModel: MyModel? = nil
    
    override func setUpWithError() throws {
        self.mockModel = makeMockModel()
    }

    override func tearDownWithError() throws {
    }
    
    func makeMockModel() -> MyModel {
        let myRowModel1: MyRowModel = MyRowModel(idx: "3832", code: "a1", location: "London", company: "kangol")
        let myRowModel2: MyRowModel = MyRowModel(idx: "1138", code: "b6", location: "Seoul", company: "LG")
        let myResultModel: MyResultModel = MyResultModel(code: "200", message: "Success")
        let mySubModel: MySubModel = MySubModel(list_total_count: "101", result: myResultModel, row: [myRowModel1, myRowModel2])
        let myModel: MyModel = MyModel(lostArticleBizInfo: mySubModel)
        return myModel
    }

    func testToJson() {
        XCTAssertNotNil(self.mockModel)
        guard let mock = self.mockModel else {
            return
        }
        let jsonString: String = mock.toJson()
        XCTAssertNotEqual(jsonString, "")
        print("jsonString:\(jsonString)")
    }

    func testToXml() {
        XCTAssertNotNil(self.mockModel)
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        let xmlString: String? = mock.toXML()
        XCTAssertNotNil(xmlString)
        XCTAssertNotEqual(xmlString, "")
        print("xmlString:\(String(describing: xmlString))" )
    }

    func testToDictionary() {
        XCTAssertNotNil(self.mockModel)
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        let dic: [String:Any]? = mock.toDictionary()
        XCTAssertNotNil(dic)
        XCTAssertGreaterThan(dic?.count ?? -1, 0)
        print("dictionary:\(String(describing: dic))" )
    }

    func testToNSDictionary() {
        XCTAssertNotNil(self.mockModel)
        guard let mock = self.mockModel else {
            XCTAssertTrue(false)
            return
        }
        let nsDic: NSDictionary? = mock.toNSDictionary()
        XCTAssertNotNil(nsDic)
        XCTAssertGreaterThan(nsDic?.count ?? -1, 0)
        print("NSDictionary:\(String(describing: nsDic))" )
    }
}
