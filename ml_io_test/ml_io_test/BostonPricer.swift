//
//  BostonPricer.swift
//  ml_io_test
//
//  Created by Andrey Batutin on 7/17/17.
//  Copyright © 2017 Andrey Batutin. All rights reserved.
//

@objc class BostonPricer:NSObject {
    var model: MLModel
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }
    convenience override init() {
        let bundle = Bundle(for: BostonPricer.self)
        let assetPath = bundle.url(forResource: "BostonPricer", withExtension:"mlmodelc")
        try! self.init(contentsOf: assetPath!)
    }
    func prediction(input: BostonPricerInput) throws -> BostonPricerOutput {
        let outFeatures = try model.prediction(from: input)
        let result = BostonPricerOutput(price: outFeatures.featureValue(for: "price")!.doubleValue)
        return result
    }
    func prediction(crime: Double, rooms: Double) throws -> BostonPricerOutput {
        let input_ = BostonPricerInput(crime: crime, rooms: rooms)
        return try self.prediction(input: input_)
    }
}
