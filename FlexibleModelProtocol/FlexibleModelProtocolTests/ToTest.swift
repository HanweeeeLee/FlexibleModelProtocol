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
        var myModel: MyModel = MyModel()
        var mySubModel: MySubModel = MySubModel()
        let myRowModel1: MyRowModel = MyRowModel(idx: "3832", code: "a1", location: "London", company: "kangol")
        let myRowModel2: MyRowModel = MyRowModel(idx: "1138", code: "b6", location: "Seoul", company: "LG")
        mySubModel.row.append(myRowModel1)
        mySubModel.row.append(myRowModel2)
        let myResultModel: MyResultModel = MyResultModel(code: "200", message: "Success")
        mySubModel.result = myResultModel
        mySubModel.list_total_count = "101"
        myModel.lostArticleBizInfo = mySubModel
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
