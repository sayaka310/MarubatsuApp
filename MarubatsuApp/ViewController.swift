//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by user1 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    var questions: [[String: Any]] = []
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String:Any]]
        }
        
        showQuestion()
        
        isEnableYesNoButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String:Any]]
        }
        
        showQuestion()
        
        isEnableYesNoButton()
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    func showQuestion() {
        
        if questions.count == 0 {
            questionLabel.text = "問題がありません。問題を作りましょう。"
        } else {
            let question = questions[currentQuestionNum]
            
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }
        
    }
    
    func checkAnswer(yourAnswer: Bool) {
        
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            
            if yourAnswer == ans {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解！")
            } else {
                // 不正解
                showAlert(message: "不正解…")
                
            }
        } else {
            print("答えが入ってません")
            return
        }
        
        // 問題を表示します。
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        //正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    func isEnableYesNoButton() {
        if questions.count == 0 {
            noButton.isEnabled = false
            noButton.alpha = 0.3
            yesButton.isEnabled = false
            yesButton.alpha = 0.3
        } else {
            noButton.isEnabled = true
            noButton.alpha = 1.0
            yesButton.isEnabled = true
            yesButton.alpha = 1.0
        }
    }
    
}
