//
//  ViewController.swift
//  SignUpProject
//
//  Created by SCK INC on 2022/07/04.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    //MARK: - Properties
    
    var userID: String?
    var userPW: String?
    var userInfoDic = [String:String]()//USerDefaults에 저장된 ID,PW값을 저장하기 위한 딕셔너리 변수
    
//   MARK: - IBOutlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UserInformation.shared.userInformation = UserDefaults.standard.dictionary(forKey: "userINFO") as? [String:String] ?? [:]//화면 로드시 userdefaults의 딕셔너리 데이터 불러오기
        
    }
    
    //화면 터치시 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func setUserId(_ sender: UIStoryboardSegue){
        if let from = sender.source as? ThirdViewController{
            userID = from.userID
            idField.text = userID
            idField.textColor = .black
        }
        
    }
    
    //MARK: - UserDefaults값을 사용한 로그인 구현
    @IBAction func setLogin(_ sender : UIButton){
        print("로그인 검사")
        
        userInfoDic = UserInformation.shared.userInformation//새 딕셔너리에 받아온 userdefaults 데이터를 선언 해줘야함
        print(userInfoDic.count)
        for (key,value) in userInfoDic {
            print("id: \(key), pw: \(value)")
        }
        
        //옵셔널 바인딩. idField에서 id의 값이 userdefaults의 딕셔너리 형식에 존재한다면 pw 검사 .
        if let isValidUser = userInfoDic[idField.text!]{
            print(isValidUser)
            if passwordField.text == (isValidUser) {
               
                let alert = UIAlertController(title: "로그인 되었습니다.", message: "", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alert.addAction(confirm)
                
                present(alert, animated: true, completion: nil)
            } else { // nil 일 경우 비밀번호 alert 띄우기
                print("경고창 띄우기")
         
                let wrongPwAlert = UIAlertController(title: "비밀번호가 틀립니다.", message: "", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                wrongPwAlert.addAction(confirm)
            
                present(wrongPwAlert, animated: true, completion: nil)
            }
        } else { //nil일 경우 회원가입을 하지 않은 사용자 이므로 회원가입 알람
            print("경고창 띄우기")
     
            let signUpAlert = UIAlertController(title: "회원가입이 필요합니다.", message: "", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            signUpAlert.addAction(confirm)
            
            present(signUpAlert, animated: true, completion: nil)
        }
    }
    
    
    //세그워이로 화면전환시 unwindSegue를 통해 이전화면으로 돌아가도록 함. 스토리보드상에서 exit와 연결.
    @IBAction func backToView1(_ unwindSegue: UIStoryboardSegue){
        print("첫 화면으로 초기화")
    }

    // 로그인 버튼 터치시 alert문구 띄우기
//    @IBAction func showAlert(_ sender: Any){
//        print("경고창 띄우기")
//
//        let alert = UIAlertController(title: "회원가입이 필요합니다.", message: "", preferredStyle: .alert)
//        let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
//
//        alert.addAction(confirm)
//
//        //present로 화면에 띄워주기
//        present(alert, animated: true, completion: nil)
//    }
   
}
