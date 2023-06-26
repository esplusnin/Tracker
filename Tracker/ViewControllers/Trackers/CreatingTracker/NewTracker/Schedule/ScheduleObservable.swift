//
//  ScheduleObservable.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import Foundation

@propertyWrapper
final class ScheduleObservable<Value> {
    private var onChange: ((Value) -> Void)? = nil
    
    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }
    
    var projectedValue: ScheduleObservable<Value> {
        return self
    }
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}
