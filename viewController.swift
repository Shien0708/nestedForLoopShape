import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var removeTimer = Timer()
    var timer = Timer()
    let player = AVPlayer()
    var random = Int.random(in: 1...10)
    var circle = ""
    var songIndex = 0
    
    var fileUrl = Bundle.main.url(forResource: myMusic[0].name, withExtension: "mp3")
    var playerItem : AVPlayerItem?
    
    var tintColor = UIColor()
    var viewColor = UIColor()
   
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var shapeTextView: UITextView!
    @IBOutlet weak var controlSizeSlider: UISlider!
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageColorView: UIView!
    
    @IBOutlet weak var blackSettingButton: UIButton!
    @IBOutlet weak var blackPreButton: UIButton!
    @IBOutlet weak var blackNextButton: UIButton!
    
    @IBOutlet weak var blackPauseButton: UIButton!
    @IBOutlet weak var blackPlayButton: UIButton!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var shapeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var backgroundSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingView.isHidden = true
        pauseButton.isHidden = true
        blackPreButton.isHidden = true
        blackNextButton.isHidden = true
        blackPlayButton.isHidden = true
        blackPauseButton.isHidden = true
        blackSettingButton.isHidden = true
        
        replaceMusic()
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        player.volume = sender.value
        
    }
    
    func replaceMusic(){
        playerItem = AVPlayerItem(url: fileUrl!)
        
        player.replaceCurrentItem(with: playerItem)
        musicImageView.image = UIImage(named: myMusic[songIndex].image)
       
        songNameLabel.text = myMusic[songIndex].name
    }
    
    @objc func removeText(){
        shapeTextView.text = ""
    }
    
    @IBAction func playMusic(_ sender: UIButton) {
        
        if sender == playButton {
            pauseButton.isHidden = false
            playButton.isHidden = true
        } else if sender == blackPlayButton {
            blackPlayButton.isHidden = true
            blackPauseButton.isHidden = false
        }
        
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 0.11, target: self, selector: #selector(removeText), userInfo: nil, repeats: true)
        removeTimer = Timer.scheduledTimer(timeInterval: 0.11, target: self, selector: #selector(buildShape), userInfo: nil, repeats: true)
       
    }
    
    
    @IBAction func pause(_ sender: UIButton) {
        
        switch sender {
        case pauseButton:
            playButton.isHidden = false
            pauseButton.isHidden = true
        default:
            blackPlayButton.isHidden = false
            blackPauseButton.isHidden = true
        }
        
        player.pause()
        timer.invalidate()
        removeTimer.invalidate()
    }
    
    func chooseEmoji()->String {
        
        var emoji = chooseColor()
        
        if emojiTextField.text != ""{
            emoji = emojiTextField.text!
        }
        
        return emoji
    }
    
    func chooseColor()->String{
        switch colorSegmentedControl.selectedSegmentIndex {
        case 0:
            return "🔴"
        case 1:
            return "🟡"
        default:
            return "🟢"
            
        }
    }
    
    func makeTrangle(emoji: String){
        for i in 1...random {
            
            var n = 0
            
            if i == 1 {
                for _ in 0...10-random {
                        shapeTextView.text += "\n"
                }
            }
           
            for _ in 1...i {
                shapeTextView.text += emoji
                n += 1
            }
            
            if n > 1 {
                for _ in 2...n {
                    shapeTextView.text += emoji
                }
                
            }
            shapeTextView.text += "\n"
        }
    }
    
    func makeDiamond(emoji: String){
        var n = 0
        var k = 0
        
        for i in 1...random {
            
            if i == 1 {
                shapeTextView.text += "\n"
            }
            for _ in 1...i {
                shapeTextView.text += emoji
                n += 1
                k = n
            }
           
            if n > 1 {
                for _ in 2...n {
                    shapeTextView.text += emoji
                }
            }
            shapeTextView.text += "\n"
            n = 0
        }
        
        
        for _ in 1...random {
            
            if k > 1{
                for _ in 2...k {
                        shapeTextView.text += emoji
                }
                
                k -= 1
                
                if k > 1 {
                    for _ in 2...k {
                        shapeTextView.text += emoji
                    }
                }
                shapeTextView.text += "\n"
            }
        }
    }
    
    func makeSquare(emoji: String) {
        for i in 1...random {
            if i == 1 {
                for _ in 0...12-random {
                    shapeTextView.text += "\n"
                }
            }
            
            for _ in 1...random {
                shapeTextView.text += emoji
            }
            
            shapeTextView.text += "\n"
        }
    }
    
    @objc func buildShape() {
        
        random = Int.random(in: 1...10)
        
        switch shapeSegmentedControl.selectedSegmentIndex {
        case 0:
            makeTrangle(emoji: chooseEmoji())
            
        case 1:
            random = Int.random(in: 1...6)
            makeDiamond(emoji: chooseEmoji())
            
        default:
            makeSquare(emoji: chooseEmoji())
         }
        
        imageColorView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0...1))
    }
        
        
    @IBAction func set(_ sender: UIButton) {
        
        if backgroundSegmentedControl.selectedSegmentIndex == 1 {
            blackSettingButton.isHidden = false
        } else {
            blackSettingButton.isHidden = true
        }
        
        switch sender {
        case settingButton, blackSettingButton:
            settingView.isHidden = false
            
        default:
            settingView.isHidden = true
        }
    }
    
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func changeSong(_ sender: UIButton) {
        
        if sender == nextButton || sender == blackNextButton {
            songIndex = (songIndex+1) % myMusic.count
        } else {
            songIndex = (songIndex-1+myMusic.count) % myMusic.count
        }
        
        switch sender {
        case preButton, nextButton:
            pauseButton.isHidden = false
            playButton.isHidden = true
            blackPlayButton.isHidden = true
            blackPauseButton.isHidden = true
            
        default:
            blackPauseButton.isHidden = false
            blackPlayButton.isHidden = true
            playButton.isHidden = true
            pauseButton.isHidden = true
        }
        
        fileUrl = Bundle.main.url(forResource: myMusic[songIndex].name, withExtension: "mp3")
        replaceMusic()
        timer.invalidate()
        removeTimer.invalidate()
        playMusic(sender)
        
    }
    
    func changeUIColor(){
        switch backgroundSegmentedControl.selectedSegmentIndex {
            
        case 0:
            
            if blackPlayButton.isHidden {
                pauseButton.isHidden = false
            } else {
                playButton.isHidden = false
            }
            
            blackPlayButton.isHidden = true
            blackPauseButton.isHidden = true
            blackPreButton.isHidden = true
            blackNextButton.isHidden = true
            view.backgroundColor = .black
            controlSizeSlider.minimumTrackTintColor = .white
            songNameLabel.textColor = .white
            shapeTextView.textColor = .white
            
        default:
            
            if playButton.isHidden {
                blackPauseButton.isHidden = false
            } else {
                blackPlayButton.isHidden = false
            }
            
            blackPreButton.isHidden = false
            blackNextButton.isHidden = false
            
            view.backgroundColor = .white
            controlSizeSlider.minimumTrackTintColor = .black
            songNameLabel.textColor = .black
            shapeTextView.textColor = .black
        }
    }
    
   
    @IBAction func changeBackgroundColor(_ sender: UISegmentedControl) {
       changeUIColor()
    }
    
    
}

