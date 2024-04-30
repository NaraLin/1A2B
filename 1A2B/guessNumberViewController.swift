//
//  guessNumberViewController.swift
//  2A1B
//
//  Created by 林靖芳 on 2024/4/26.
//

import UIKit

class guessNumberViewController: UIViewController {
    
    @IBOutlet var chanceImageView: [UIImageView]!
    @IBOutlet var guessNumberLabel: [UILabel]!
    @IBOutlet var recordLabel: [UILabel]!
    
    @IBOutlet weak var seeAnswerButton: UIButton!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet var enterNumberButton: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    //建立變數:randomNumbers存題目，guessNumbers存你猜的數字
    var randomNumbers:[Int]=[]
    var guessNumbers:[Int]=[]
    //鍵盤數字輸入的index
    var index = 0
    //第幾次玩
    var playTimes = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定背景
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "wallpaper")
        view.insertSubview(backgroundImageView, at: 0)
        
        
        
        //設定樣式：chanceImageView
        for (i,_) in chanceImageView.enumerated(){
            chanceImageView[i].image = UIImage.init(systemName: "circle")
            chanceImageView[i].highlightedImage = UIImage.init(systemName: "circle.fill")
            chanceImageView[i].layer.borderWidth = 4
            chanceImageView[i].layer.cornerRadius = 9
            chanceImageView[i].layer.borderColor = UIColor.gray.cgColor
            chanceImageView[i].tintColor = UIColor(red: 1, green: 0.6, blue: 0.9, alpha: 0.8)
            //            chanceImageView[i].isHighlighted = true
        }
        
        //設定第一個chance圈圈的位置
        chanceImageView[0].frame = CGRect(x: 42, y: 72, width: 20, height: 20)
        
        //設定剩下8個chance圈圈的位置，以第一個圈圈為基準
        for i in 1...9{
            chanceImageView[i].frame = CGRect(x: chanceImageView[i-1].frame.maxX + 16, y: 72, width: 20, height: 20)
        }
        
        //設定樣式：guessNumberLabel
        for (i,_) in guessNumberLabel.enumerated(){
            guessNumberLabel[i].layer.borderWidth = 3
            guessNumberLabel[i].layer.cornerRadius = 20
            guessNumberLabel[i].textAlignment = .center
            guessNumberLabel[i].text = ""
            guessNumberLabel[i].font = UIFont(name: "Thonburi", size: 40)
            guessNumberLabel[i].backgroundColor = UIColor(red: 213/255, green: 176/255, blue: 219/255, alpha: 1)
            guessNumberLabel[i].layer.masksToBounds = true
        }
        
        guessNumberLabel[0].frame = CGRect(x: 58, y: 112, width: 60, height: 60)
        for i in 1...3{
            guessNumberLabel[i].frame = CGRect(x: guessNumberLabel[i-1].frame.maxX + 24, y: 112, width: 60, height: 60)
        }
        
        //設定樣式：recordLabel
        for (i,_) in recordLabel.enumerated(){
            recordLabel[i].layer.borderWidth = 2
            recordLabel[i].layer.borderColor = UIColor.lightGray.cgColor
            recordLabel[i].textAlignment = .center
            recordLabel[i].layer.cornerRadius = 20
            recordLabel[i].textColor = .black
            recordLabel[i].text = ""
            recordLabel[i].numberOfLines = 0
        }
        
        recordLabel[0].frame = CGRect(x: 82, y: 188, width: 120, height: 52)
        recordLabel[5].frame = CGRect(x: recordLabel[0].frame.maxX + 40, y: recordLabel[0].frame.minY, width: 120, height: 52)
        
        for i in 1...4{
            recordLabel[i].frame = CGRect(x: recordLabel[0].frame.minX, y: recordLabel[i-1].frame.maxY + 12, width: 120, height: 52)
        }
        
        for i in 6...9{
            recordLabel[i].frame = CGRect(x: recordLabel[5].frame.minX, y: recordLabel[i-1].frame.maxY + 12, width: 120, height: 52)
        }
        
        //設定樣式：seeAnswerButton
        seeAnswerButton.frame = CGRect(x: 96, y: 520, width: 106, height: 72)
        seeAnswerButton.layer.borderWidth = 4
        seeAnswerButton.layer.borderColor = UIColor.black.cgColor
        seeAnswerButton.layer.cornerRadius = 35
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = "看答案"
        configuration.attributedTitle?.font = UIFont(name: "Thonburi", size: 26)
        configuration.background.backgroundColor = UIColor.darkGray
        configuration.baseForegroundColor = .white
        seeAnswerButton.configuration = configuration
        seeAnswerButton.layer.masksToBounds = true
        
        
        
        //設定樣式：againButton
        againButton.frame = CGRect(x: seeAnswerButton.frame.maxX + 40, y: seeAnswerButton.frame.minY, width: 106, height: 72)
        againButton.layer.borderWidth = 4
        againButton.layer.cornerRadius = 35
        againButton.layer.borderColor = UIColor.black
            .cgColor
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = UIColor(red: 158/255, green: 96/255, blue: 167/255, alpha: 1)
        configuration.attributedTitle = " play\nagain"
        configuration.attributedTitle?.font = UIFont(name: "Thonburi", size: 24)
        configuration.titleAlignment = .center
        againButton.configuration = configuration
        againButton.layer.masksToBounds = true
        
        
        //設定樣式：enterNumberButton
        var number = 0
        
        for i in 0...9{
            configuration.baseForegroundColor = .black
            configuration.background.backgroundColor = .systemPink.withAlphaComponent(0.5)
            configuration.attributedTitle = AttributedString(String(number))
            number += 1
            configuration.attributedTitle?.font = UIFont(name: "Thonburi", size: 28)
            enterNumberButton[i].configuration = configuration
        }
        

        
        for i in 0...9{
            enterNumberButton[i].layer.cornerRadius = 30
            enterNumberButton[i].layer.borderWidth = 4
            enterNumberButton[i].frame.size.width = CGFloat(70)
            enterNumberButton[i].frame.size.height = CGFloat(60)
            enterNumberButton[i].layer.masksToBounds = true
            
        }
        
        enterNumberButton[1].frame.origin.x = 82
        enterNumberButton[1].frame.origin.y = 608
        
        for i in 2...3{
            enterNumberButton[i].frame.origin.x =  enterNumberButton[i-1].frame.maxX + 40
            enterNumberButton[i].frame.origin.y = enterNumberButton[i-1].frame.minY
        }
        
        for i in 4...9{
            enterNumberButton[i].frame.origin.x = enterNumberButton[i-3].frame.minX
            enterNumberButton[i].frame.origin.y = enterNumberButton[i-3].frame.maxY + 16
        }
        
        enterNumberButton[0].frame.origin.x = enterNumberButton[8].frame.minX
        enterNumberButton[0].frame.origin.y = enterNumberButton[8].frame.maxY + 16
     
        
        //設定樣式：clearButton
        clearButton.layer.cornerRadius = 30
        clearButton.layer.borderWidth = 4
        clearButton.frame.size.width = CGFloat(70)
        clearButton.frame.size.height = CGFloat(60)
        clearButton.layer.masksToBounds = true
        
        clearButton.frame.origin.x = enterNumberButton[7].frame.minX
        clearButton.frame.origin.y = enterNumberButton[7].frame.maxY + 16
        
        configuration.attributedTitle = "clear"
        configuration.attributedTitle?.font = UIFont(name: "Thonburi", size: 20)
        configuration.background.backgroundColor = .yellow
        clearButton.configuration = configuration
        
        //設定樣式：sendButton
        sendButton.layer.cornerRadius = 30
        sendButton.layer.borderWidth = 4
        sendButton.frame.size.width = CGFloat(70)
        sendButton.frame.size.height = CGFloat(60)
        sendButton.layer.masksToBounds = true
        sendButton.frame.origin.x = enterNumberButton[9].frame.minX
        sendButton.frame.origin.y = enterNumberButton[9].frame.maxY + 16
        
        configuration.attributedTitle = "send"
        configuration.attributedTitle?.font = UIFont(name: "Thonburi", size: 20)
        sendButton.configuration = configuration
        
        
        createRandomNumber()
        sendButton.isEnabled = false
      
        
    }
    
    @IBAction func seeAnswer(_ sender: Any) {
        
        //把答案輸出成字串，透果迴圈一個一個存入answer變數裡
        var answer = ""
        for i in 0...3{
            answer += String(randomNumbers[i])
        }
       
        //點選看答案按鈕，跳出alert視窗
        let controller = UIAlertController(title: answer, message: "ㄏㄡˊ～作弊！", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        present(controller, animated: true)
    }
   
    
    func createRandomNumber(){
        
        //先將 randomNumbers arrary 清空
        randomNumbers.removeAll()
        
        //隨機創造新的題目4個數字，不重複，加入 randomNumbers Array 裡
        for _ in 0...3{
            var randomnumber = Int.random(in: 0...9)
            
            while randomNumbers.contains(randomnumber){
                randomnumber = Int.random(in: 0...9)
            }
            randomNumbers.append(randomnumber)
        }
        
    }
    
    func play(){
        
        //設成初始值
        index = 0
        playTimes = 1
        guessNumbers = []

        //將label都清空
        guessNumberLabel.forEach { label in
            label.text = ""
        
        //recordLabel除了清空，也要將底色清除
        recordLabel.forEach { label in
                label.text = ""
                label.backgroundColor = .white
            }
        
        //數字按鍵可以按
        enterNumberButton.forEach { button in
                button.isEnabled = true
                
            }
        //Chance圈圈清空
        chanceImageView.forEach { imageView in
                imageView.isHighlighted = false
            }
        //重新新建立題目
        createRandomNumber()
        }
    }
    
    
    @IBAction func playAgain(_ sender: Any) {
        play()
    }
    
    //判斷幾Ａ幾Ｂ從按 Send 後判斷
    @IBAction func send(_ sender: UIButton) {
       
         
        var a = 0
        var b = 0
        
        //如果猜的數字等於答（位置相同，透過迴圈比較array每一個位置的數字），Ａ＋1
        //如果沒有在相同位置，再比較該數字有沒有含在答案array中
        for i in 0...3{
            if guessNumbers[i] == randomNumbers[i]{
                a += 1
            } else if randomNumbers.contains(guessNumbers[i]){
                b += 1
            }
            
            
        }
       
       
        //如果 a=4，跳出Alert通知過關，設定OK鍵再玩一次
        if a == 4{
            let controller = UIAlertController(title: "恭喜答對了！", message:"你只使用了\(playTimes)次機會", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "再玩一次", style: .default, handler: { _ in
                self.play()
            }))
            present(controller, animated: true)
        }
       
        //將輸入的數字與幾Ａ幾Ｂ的結果顯示於ResultLabel，透過迴圈將輸入的數字轉成string 存到變數 guessnumber 裡
        var guessNumber = ""
        
        for i in 0...3{
            guessNumber += String(guessNumbers[i])
        }
        
        //RecordLabel array從0開始顯示（＝玩的次數-1）
        recordLabel[playTimes-1].text = "\(guessNumber)\n\(a)a\(b)b"
        recordLabel[playTimes-1].backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
        recordLabel[playTimes-1].layer.masksToBounds = true
        
        //chanceImageView array從0開始，故 array index小於玩的次數都需要塗黑
        for i in 0...9{
            if i < playTimes {
                chanceImageView[i].isHighlighted = true
                
            }
        }
       
        //一輪結束後，guessNumbers array清空，送出後數字鍵即可恢復選擇，guessNumberLabel 也要清空
        guessNumbers = []
        enterNumberButton.forEach { button in
            button.isEnabled = true
        guessNumberLabel.forEach { label in
                label.text = ""
            }
            
        }
        //玩的次數＋1
        playTimes += 1
        
        //最多玩10次，所以大於10次會跳Alert
        if playTimes > 10 {
            
            enterNumberButton.forEach { button in
                button.isEnabled = false
                let controller = UIAlertController(title: "GameOver", message: "沒關係！再玩一次", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.play()
                }))
                present(controller, animated: true)
                
            }
        }
        
        //一輪結束後，index歸0，代表從第一個數字開始輸入，若沒有歸0，判斷index＝4會閃退(guessNumberLabel[4].text >> error)(index只有0-3)
        index = 0
        
        //下一輪開始，sendButton不能按
        sendButton.isEnabled = false
        
    }
    
    @IBAction func clear(_ sender: Any) {
        
        //guessNumberLabel array清空
        guessNumberLabel.forEach { label in
            label.text = ""
        }
        //清除後數字鍵可以按
        enterNumberButton.forEach { button in
            button.isEnabled = true
            
        }
        //guessNumbers array清空
        guessNumbers = []
        
        //清空後要從從第一個數字開始輸入，Index歸0
        index = 0
        
        
    }
    
    
    @IBAction func enterButton(_ sender: UIButton) {
      
        //將Button的attributedString轉成String，存入numberToString，再將numberToString存入guessNumberLabel array成員的text，讓數字顯示於label
        if let number = sender.configuration?.attributedTitle {
            let numberToString = NSAttributedString(number).string
            
            //(另一種轉換方法）
            //let numberToString1 = String(number.characters)
            guessNumberLabel[index].text = numberToString
            
            //將String轉成Int，存到guessNumbers array中，設定輸入過的文字就不可再選
            if let numberToInt = Int(numberToString){
                
                guessNumbers.append(numberToInt)
                enterNumberButton[numberToInt].isEnabled = false
            }
            
        }
            //guessNumbers array中成員不等於4，sendButton不能按
            if guessNumbers.count != 4{
                sendButton.isEnabled = false
            } else {sendButton.isEnabled = true
            }
        
        //一個數字輸入完後，index+1 換下一個數字
        index += 1
        
        //index>3，代表四個數字都已經輸入完成，數字按鍵不可以按
        if index > 3 {
            enterNumberButton.forEach { button in
                button.isEnabled = false
            }
            
        }
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "guess")
}
