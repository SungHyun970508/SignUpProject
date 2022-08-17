//
//  ThirdViewController.swift
//  SignUpProject
//
//  Created by SCK INC on 2022/07/12.
//

import UIKit


class ThirdViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Properties
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    //^는 시작을 의미 0-9사이의 4자리 숫자가 들어간다라는 조건
    let phoneRegEx = "^010-?([0-9]{4})-?([0-9]{4})"
    let phoneRegEx2 = "^010?([0-9]{8})"
    let date = Date()
    //전화번호 형식인지 판단하기 위한 bool 변수
    var isValidPh = false
    var userID: String!
    var userPW: String!
   
    
    //MARK: - Outlets
    @IBOutlet weak var phNumTextField: UITextField!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var idLabel: UILabel!

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = UserInformation.shared.id
        userPW = UserInformation.shared.password
        idLabel.text = userID
        self.phNumTextField.delegate = self
        
        //sigleton 인스턴스에 딕셔너리 객체를 생성해서 id / pw 쌍으로 저장
        UserInformation.shared.userInformation[userID] = userPW
        
        //UserDefaults에 딕셔너리 형태로 저장 key : "userINFO"
        UserDefaults.standard.set(UserInformation.shared.userInformation, forKey: "userINFO")
    }
    
    //MARK: - IBActions
    @IBAction func showAlert(_ sender: Any){
        let alert = UIAlertController(title: "회원가입이 완료 되었습니다.", message: "", preferredStyle: .alert)
        let signUpAction = UIAlertAction(title: "확인", style: .cancel, handler: { _ in self.performSegue(withIdentifier: "goToV1", sender: self) })//handler에 closer로 performSegue함수를 사용. 

        alert.addAction(signUpAction)
        
        //present로 화면에 띄워주기
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        datePicker.maximumDate = date//UIDatePicker의 maximumDate 프로퍼티를 이용해 datepicker의 최대값을 현재 date 값으로 지정.
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)//date 포맷 스트링으로 변환
        
        self.birthLabel.text = dateString
    }
    
    //MARK: - keyboardFunc
    //화면 터치시 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - checkPhoneNumFuncs
    //swift 정규표현식으로 핸드폰 번호 형식인지 확인하는 함수
    func isValidPhone(phone: String?) -> Bool{
        print("번호 형식 검사")
        guard phone != nil else {
            return false
        }
        
        let predWithDash = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx2)
        
        if predWithDash.evaluate(with: phone) == true || pred.evaluate(with: phone) == true {
            return true
        } else {
            return false
        }

    }
    
    //전화번호 형식이 아닐 경우 알람 띄우기
    func showPhAlert(isValid: Bool?){
        if isValid != true {
            let alert = UIAlertController(title: "전화번호 형식이 아닙니다. 다시 입력해주세요", message: "", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .destructive, handler: nil)
            
            alert.addAction(confirm)
            
            //present로 화면에 띄워주기
            present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - signUpBtnFuncs
    //텍스트필드와 생일을 입력했을 경우에 가입 버튼 활성화하기
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("가입이전")
        isValidPh = isValidPhone(phone: phNumTextField.text)
        if phNumTextField.text?.isEmpty == false && birthLabel.text?.isEmpty == false  && isValidPh == true{
            print("가입완료")
            signUpBtn.isEnabled = true
            
        } else if isValidPh == false {
            print("핸드폰 번호형식 아님")
            showPhAlert(isValid: isValidPh)
            signUpBtn.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phNumTextField.becomeFirstResponder()
    }
    
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

