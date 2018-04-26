//
//  ViewController.swift
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/19.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let funtionSelect = ["图片识别","视频识别","相机识别"];
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funtionSelect.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "CellID")
        }
        
        cell?.textLabel?.text = funtionSelect[indexPath.row];
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = DetectImageVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        case 1:
            let vc = DetectVideoVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        case 2:
            let vc = DetectCameraVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        default:
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

