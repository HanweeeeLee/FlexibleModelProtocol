//
//  TestModel.swift
//  FlexibleModelProtocolTests
//
//  Created by hanwe on 2020/10/13.
//
@testable import FlexibleModelProtocol
import Foundation


struct MyModel: FlexibleModelProtocol {
    var lostArticleBizInfo:MySubModel = MySubModel()
}
struct MySubModel: FlexibleModelProtocol {
    var list_total_count:String = ""
    var result:MyResultModel = MyResultModel()
    var row:Array<MyRowModel> = Array()
}

struct MyResultModel: FlexibleModelProtocol {
    var code:String = ""
    var message:String = ""
}

struct MyRowModel: FlexibleModelProtocol {
    var idx:String = ""
    var code:String = ""
    var location:String = ""
    var company:String = ""
}


