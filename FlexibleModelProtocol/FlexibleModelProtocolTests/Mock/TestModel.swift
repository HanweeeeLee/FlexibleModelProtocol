//
//  TestModel.swift
//  FlexibleModelProtocolTests
//
//  Created by hanwe on 2020/10/13.
//
@testable import FlexibleModelProtocol
import Foundation


struct MyModel: FlexibleModelProtocol {
    typealias selfType = MyModel
    
    let lostArticleBizInfo: MySubModel
}
struct MySubModel: FlexibleModelProtocol {
    typealias selfType = MySubModel
    
    let list_total_count: String
    let result: MyResultModel
    let row: Array<MyRowModel>
}

struct MyResultModel: FlexibleModelProtocol {
    typealias selfType = MyResultModel
    
    let code: String
    let message: String
}

struct MyRowModel: FlexibleModelProtocol {
    typealias selfType = MyRowModel
    
    let idx: String
    let code: String
    let location: String
    let company: String
}


struct MyRowModel2: FlexibleModelProtocol {
    typealias selfType = MyRowModel2
    
    let idx: String
    let code: String
    let location: String
    let company: String
    
    init(location: String, company: String) {
        self.idx = ""
        self.code = ""
        self.location = location
        self.company = company
    }
}

