//
//  RecordSoundExtension.swift
//  PitchPerfect
//
//  Created by Faisal Albellaihi on 03/11/2018.
//  Copyright © 2018 FAISAL Albellaihi. All rights reserved.
//

import UIKit
import AVFoundation
extension RecordSoundViewController  {

    func Record(){
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func stop(){
        audioRecorder.stop()
        try! session.setActive(false)
    }
    
}

