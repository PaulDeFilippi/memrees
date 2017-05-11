//
//  ViewController.swift
//  memrees
//
//  Created by Paul Defilippi on 4/29/17.
//  Copyright © 2017 Paul Defilippi. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class ViewController: UIViewController {

    @IBOutlet weak var helpLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func requestPhotoPermissions() {
        
        PHPhotoLibrary.requestAuthorization { [unowned self]
            authStatus in
            
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermission()
                    
                } else {
                    self.helpLbl.text = "Permission to access photos was declined; please enable it in Settings and tap Continue."
                }
            }
        }
        
    }
    
    // above func for first part of article
    
    func requestRecordPermission() {
        
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            
            DispatchQueue.main.async {
                if allowed {
                    
                    self.requestTranscribePermissions()
                        
                } else {
                    self.helpLbl.text = "Permission to record was declined; please enable it in Settings and tap Continue."
                }
                    
            }
        }
            
    }
    
    func requestTranscribePermissions() {
        
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorizationComplete()
                    
                } else {
                    self.helpLbl.text = "Permission to transcribe was denied; please enable it in Settings and tap Continue."
                }
            }
        }
        
    }
    
    func authorizationComplete() {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func requestPermissions(_ sender: Any) {
        
        requestPhotoPermissions()
        
    }

}

