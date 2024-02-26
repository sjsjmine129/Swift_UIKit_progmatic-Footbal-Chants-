//
//  AudioManagerViewModel.swift
//  Footbal Chants
//
//  Created by 엄승주 on 2/26/24.
//

import Foundation
import AVKit

class AudioManagerViewModel{
    
    private var chantAudioPlayer: AVAudioPlayer?
    
    func playback(_ team: Team){
        
        // when playing -> stop
        if team.isPlaying{
            chantAudioPlayer?.stop()
        }else{ // not playing -> start
            guard let path = Bundle.main.path(forResource: "\(team.id.chantFile).mp3", ofType: nil) else {
                return
            }// guard error of file name
            
            let url = URL(fileURLWithPath: path)
            
            do{
                chantAudioPlayer = try AVAudioPlayer(contentsOf: url)
                chantAudioPlayer?.numberOfLoops = -1 // infinite loop
                chantAudioPlayer?.play()
            }catch{
                print(error)
            }
        }
    }
}
