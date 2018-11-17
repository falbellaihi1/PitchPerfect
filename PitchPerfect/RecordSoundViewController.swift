//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Faisal Albellaihi on 29/10/2018.
//  Copyright © 2018 FAISAL Albellaihi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    // Variables , Iboulets
    var Recording = false
    var audioRecorder: AVAudioRecorder!
    let session = AVAudioSession.sharedInstance()
    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var StopRecordingButton: UIButton!
 
   
    // MARK : View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        EnableButton()
        
    }
  
    
    // MARK: Button / label update function
    func EnableButton() {
        if (!Recording){
            StopRecordingButton.isEnabled = Recording;
            recordButton.isEnabled = !Recording;
        }
        if (Recording){
            recordButton.isEnabled = !Recording;
            StopRecordingButton.isEnabled = Recording;
        }
      
        
        RecordingLabel.text = Recording ? "Recording in Progress" : "Tap to Record"
    }
    
 
    // MARK: Record Audio function
    @IBAction func recordAudio(_ sender: AnyObject) {
        Recording = true
        EnableButton()
        Record()

        
    }
    // MARK: Stop Recording Function
    @IBAction func StopRecording(_ sender: AnyObject) {
        Recording = false
        EnableButton()
        stop()
    }
    // MARK: Audio recorder Finished?
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            // if the recording was successful then perform the segue with the specified identifier
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            // If something wrong with the recording display Alert
            let RecordingFailedAC = UIAlertController(title: NSLocalizedString("Recording Failed", comment: "Recording Failed Alert Controller" ), message: NSLocalizedString("Some thing went wrong while trying to record your voice please try again!", comment: "Recording Failed Alert controller message"), preferredStyle: .alert) // Localized Alert Controller
            let RecordingFailedAction = UIAlertAction(title:  NSLocalizedString("OK", comment: "Recording failed alert action"), style: .default) { (action) in} // Lozalized Alert Action
            RecordingFailedAC.addAction(RecordingFailedAction)
            self.present(RecordingFailedAC, animated: true){} // show the Alert
           
        }
    }

    
    // MARK : PREPARE for transisiton
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}


