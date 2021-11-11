//
//  CreateViewController.swift
//  MarubatsuApp
//
//  Created by user1 on 2021/11/08.
//

import UIKit

class CreateViewController: UIViewController {
    var questions: [[String:Any]] = []
    var answer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String:Any]]
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func topButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var addTextFiled: UITextField!
    
    @IBAction func sagmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            answer = false
        case 1:
            answer = true
        default:
            break
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if addTextFiled.text != ""{
            let userDefaults = UserDefaults.standard
            questions.append(
                [
                    "question": addTextFiled.text ?? "",
                    "answer": answer
                ]
            )
            userDefaults.set(questions, forKey: "add")
            addTextFiled.text = ""
            showAlert(title: "保存完了", message: "問題の保存が完了しました。")
        } else {
            showAlert(title: "ERROR", message: "問題を入力してください。")
        }
    }
    
    @IBAction func allDelletButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set([], forKey: "add")
        showAlert(title: "削除完了", message: "問題を全て削除しました。")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
