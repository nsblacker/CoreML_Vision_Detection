//
//  DetectImageVC.swift
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/19.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DetectImageVC: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIPickerViewDelegate,UIPickerViewDataSource{

    var imageView:UIImageView!
    var imagePicker: UIPickerView!
    var imageArray = ["0.jpg" , "1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg"]
    var curImageFile: String!
    var vision: VisionManafer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        setupUI()
        vision = VisionManafer()
    }
    
    //Mark : -Actions
    @objc func runModel() {
        print("runModel")
        let cgImage = imageView!.image?.cgImage
//        vision.objDetectionUsingCoreML(cgImage: cgImage! ,completeHandler: { (request:VNRequest, type:VNRequestType ,error:Error?) -> Swift.Void in
//
//            guard let results = request.results as? [VNClassificationObservation]
//                else { fatalError("huh") }
//            //recogLabel.text = results[0].identifier
//            for classification in results {
//                //print(classification.identifier, classification.confidence)
//            }
//        })
        
//        vision.rectangleDetection(cgImage: cgImage! ,completeHandler:
//            { (request:VNRequest, type:VNRequestType ,error:Error?) -> Swift.Void in
//                
//            guard let results = request.results as? [VNRectangleObservation]
//                else { fatalError("huh") }
//                
//            for rectangle in results {
//                print(rectangle.boundingBox, rectangle.confidence)
//            }
//        })
        
//        vision.faceRectangleDetection(cgImage: cgImage! ,completeHandler: { (request: VNRequest, type: VNRequestType, error: Error?) in
//            guard let results = request.results as? [VNFaceObservation]
//            else { fatalError("huh") }
//            for face in results {
//                print(face.boundingBox, face.confidence)
//            }
//        })
        
//        vision.faceLandmarkDetection(cgImage: cgImage! , completeHandler: {
//            (request: VNRequest, type: VNRequestType, error: Error?) in
//            guard let results = request.results as? [VNFaceObservation]
//                else { fatalError("huh") }
//            for face in results {
//                print(face.boundingBox, face.landmarks, face.confidence)
//            }
//        })
        
        
        
    }
    
    func setupUI() {
        
        let openLibraryBtn = UIButton.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width/3, height: 40))
        openLibraryBtn.setTitle("Choose Photo", for: UIControlState.normal)
        openLibraryBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        openLibraryBtn.addTarget(self, action: #selector(openLibrary), for: UIControlEvents.touchUpInside)
        self.view.addSubview(openLibraryBtn)
        
        let openCameraBtn = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width/3, y: 100, width: self.view.frame.size.width/3, height: 40))
        openCameraBtn.setTitle("Open Camera", for: UIControlState.normal)
        openCameraBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        openCameraBtn.addTarget(self, action: #selector(openCamera), for: UIControlEvents.touchUpInside)
        self.view.addSubview(openCameraBtn)
        
        imagePicker = UIPickerView.init(frame: CGRect.init(x: self.view.frame.size.width*2/3, y: 100, width: self.view.frame.size.width/3, height: 60))
        imagePicker.dataSource = self
        imagePicker.delegate = self
        self.view.addSubview(imagePicker)
        
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 180, width: self.view.frame.size.width, height:self.view.frame.size.width ))
        imageView?.backgroundColor = UIColor.lightGray;
        self.view.addSubview(imageView!)
        
        let runBtn = UIButton.init(frame: CGRect.init(x: 0, y: imageView.frame.size.height + imageView.frame.origin.y + 20, width: self.view.frame.size.width/2, height: 40))
        runBtn.setTitle("Run Model", for: UIControlState.normal)
        runBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        runBtn.addTarget(self, action: #selector(runModel), for: UIControlEvents.touchUpInside)
        self.view.addSubview(runBtn)
    }
    
    @objc func openLibrary() {
        print("openLibrary")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func openCamera() {
        print("openCamera")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            print("camera can not be open")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView!.contentMode = .scaleToFill
            imageView!.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    //PickerDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageArray.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width/3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageArray[row];
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let str = imageArray[row]
        curImageFile = str
        let pickedImage = UIImage(named: curImageFile)
        imageView!.contentMode = .scaleToFill
        imageView!.image = pickedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
