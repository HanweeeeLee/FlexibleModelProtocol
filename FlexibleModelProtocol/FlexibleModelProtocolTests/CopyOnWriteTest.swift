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
    
    struct TestModel:FlexibleModelProtocol {
        var name:String = ""
    }
    
    struct MyModel:CopyOnWriteModelProtocol {
        var dataWrapper: DataWrapper<CopyOnWriteTest.TestModel>
        
        typealias MyType = TestModel
        
//        var dataWrapper: DataWrapper<CopyOnWriteTest.TestModel>
//
//        typealias MyType = TestModel
//        var data: MyType
    }
    override func setUpWithError() throws {
//        var test:MyModel = MyModel(dataWrapper: DataWrapper(data: TestModel()), data: TestModel())
        
        
    }

    override func tearDownWithError() throws {
    }
    
    func testToExample() {
        var cowData1:MyModel = MyModel(dataWrapper: DataWrapper(data: TestModel(name: "하잇")))
        var cowData2 = cowData1
        var struct1 = TestModel()
        var struct2 = struct1
        print("!! cowData2의 dataWrapper는 cowData1와 동일한 참조를 가지고 있습니다.")
        print("cowData1.data.strValue: \(cowData1.data.name)")
        print("cowData2.data.strValue: \(cowData2.data.name)\n")
        XCTAssertEqual(cowData1.dataWrapper, cowData2.dataWrapper)

         // cowData2의 dataWrapper가 새로운 struct값과 함께 새롭게 할당됩니다.
        cowData2.data.name = "i'm UserData2"

        print("!! cowData2의 dataWrapper는 cowData1와 다른 참조를 가지고 있습니다.")
        print("cowData1.data.strValue: \(cowData1.data.name)")
        print("cowData2.data.strValue: \(cowData2.data.name)\n")
        XCTAssertNotEqual(cowData1.dataWrapper, cowData2.dataWrapper)

    }
}
