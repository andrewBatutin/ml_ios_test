//
//  ViewController.swift
//  ml_io_test
//
//  Created by Andrey Batutin on 7/12/17.
//  Copyright © 2017 Andrey Batutin. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let img = UIImage(named:"see.jpg")!
       // detectScene(image: CIImage(image: img)!)
        room()
    }
    
    func room(){
        let m = BostonPricer()
        guard let modelOutput = try? m.prediction(crime: 0.04, rooms: 3) else {
            fatalError("Something went wrong with generating the model output.")
        }
        print(modelOutput.price)
    }

    func detectScene(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("we're fucked")
        }
        
        let request = VNCoreMLRequest(model: model){ [weak self] request, error in
            guard let res = request.results as? [VNClassificationObservation],
                let topResult = res.first else{
                    fatalError("we're fucked")
            }
            
            print(topResult.identifier)
            print(topResult.confidence)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do{
               try handler.perform([request])
            }catch{
                print(error)
            }
        }
    }
    
}

