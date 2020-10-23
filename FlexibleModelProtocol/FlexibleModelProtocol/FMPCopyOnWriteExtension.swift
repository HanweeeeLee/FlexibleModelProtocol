//
//  CopyOnWriteManager.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/22.
//

public protocol CopyOnWriteModelProtocol {
    associatedtype ModelType: FlexibleModelProtocol
    var dataWrapper: DataWrapper<ModelType> { get set }
    var data:ModelType { get set }
//    init(originModel:ModelType)
}

extension CopyOnWriteModelProtocol {
    
//    init(dataWrapper:DataWrapper<ModelType>) {
//        self.init(dataWrapper: dataWrapper)
//    }
//    init() {
//        self.init()
//    }
    
//    init(originModel:ModelType) {
//
//        self.init(originModel: originModel)
//        self.dataWrapper = DataWrapper(data: originModel)
//    }
    
    
    
//    convenience init(originModel:FlexibleModelProtocol) {
//        self.dataWrapper = dataWrapper()
//    }
    
    var data: ModelType {
        get {
            return self.dataWrapper.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                self.dataWrapper = DataWrapper(data: newValue)
            } else {
                self.dataWrapper.data = newValue
            }
        }
    }
}

public class DataWrapper<T:FlexibleModelProtocol>:Equatable {
    public static func == (lhs: DataWrapper<T>, rhs: DataWrapper<T>) -> Bool {
        return lhs === rhs
    }
    
    var data: T

    init(data: T) {
      self.data = data
    }
}
