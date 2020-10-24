//
//  CopyOnWriteTest.swift
//  FlexibleModelProtocolTests
//
//  Created by hanwe lee on 2020/10/22.
//

import UIKit
import XCTest
@testable import FlexibleModelProtocol

class CopyOnWriteTest: XCTestCase {
    
    struct TestModel: FlexibleModelProtocol {
        var name: String = ""
    }
    
    struct CowModel: CopyOnWriteModelProtocol {
        typealias ModelType = TestModel
        var dataWrapper: DataWrapper<CopyOnWriteTest.TestModel>? = nil
    }
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testMakeCopyOnWriteObject() {
        let cowData1: CowModel = CowModel(dataWrapper: DataWrapper(originModel: TestModel(name: "Any")))
        var cowData2 = cowData1
        XCTAssertEqual(cowData1.dataWrapper, cowData2.dataWrapper)
        cowData2.data?.name = "newData"
        XCTAssertNotEqual(cowData1.dataWrapper, cowData2.dataWrapper)
    }
    
    func testFlexibleModelToCoyOnWriteModel() {
        let model = TestModel(name: "David")
        var emptyValueCow = CowModel()
        if let cowData1 = model.toCopyOnWriteModel(object: &emptyValueCow) {
            var cowData2 = cowData1
            XCTAssertEqual(cowData1.dataWrapper, cowData2.dataWrapper)
            cowData2.data?.name = "newData"
            XCTAssertNotEqual(cowData1.dataWrapper, cowData2.dataWrapper)
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testCoyOnWriteModelToFlexibleModel() {
        let cowData:CowModel = CowModel(dataWrapper: DataWrapper(originModel: TestModel(name: "Any")))
        let flexibleModel: TestModel? = cowData.toFlexibleProtocolModel()
        XCTAssertNotNil(flexibleModel)
    }
}
