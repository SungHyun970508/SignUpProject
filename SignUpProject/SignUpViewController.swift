//
//  SignUpViewController.swift
//  SignUpProject
//
//  Created by SCK INC on 2022/07/04.
//
import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
//    MARK:- Properties
    
    let textViewPlaceHolder = "자기소개를 입력해주세요."
    var userID: String!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    }()

    
// MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var isValidPWLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Target - Action 패턴으로 이미지뷰의 탭 제스처를 받아와서 touchToPickPhoto 함수를 액션으로 불러오기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        imageView.addGestureRecognizer(tapGesture)//이미지뷰에 제스처 인식기 연결
        imageView.isUserInteractionEnabled = true//사용자 액션과 반응하도록 true
        
        self.idTextField.delegate = self
        self.passWordTextField.delegate = self
        self.checkPassWordTextField.delegate = self
        self.textView.delegate = self
        self.activateNextBtn(isAct: false)
    }
     
    //화면 터치시 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    MARK: - ImagePicker Funcs
    //액션 메서드
    @objc func touchToPickPhoto(){
        print("제스처 인식")
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //이미지피커가 선택한 이미지를 이미지뷰에 띄워주는 코드
        if let profilImg: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = profilImg
            //label의 속성이 truncate tail로 되어있어서 마지막 라인의 뒷부분이 말줄임표로 처리되는 이슈 발생 -> linebreakmode를 wordwrap으로 변경
            profileLabel.text = "프로필 사진이 선택되었습니다"
            profileLabel.textColor = .tintColor
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - textsFuncs
    //textView에 placeHolder 만들기
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //세번째 화면으로 넘어가는 버튼 활성화하는 함수. 네가지 필드가 다 채워지고 패스워드가 일치할 경우 버튼 활성화
    func  activateNextBtn(isAct: Bool){
        switch isAct{
        case true:
            print("버튼 활성화")
            nextButton.isEnabled = true
        case false:
            print("버튼 비활성화")
            nextButton.isEnabled = false
        }
        
    }
    
    //Delegate 매서드 - 텍스트 뷰 값 확인
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == textViewPlaceHolder {
            print("텍스트뷰 nil")
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            self.activateNextBtn(isAct: false)
        }else if textView.text?.isEmpty == false{
            print("텍스트뷰 편집")
            if checkPassWordTextField.text == passWordTextField.text && checkPassWordTextField.text?.isEmpty == false && passWordTextField.text?.isEmpty == false {
                print("비밀번호 일치")
                checkPwAndShowLabel(isValid: true)
                UserInformation.shared.id = idTextField.text
                UserInformation.shared.password = passWordTextField.text
                self.activateNextBtn(isAct: true)
            }else{
                print("비밀번호 불일치")
                checkPwAndShowLabel(isValid: false)
                self.activateNextBtn(isAct: false)
            }
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(checkPassWordTextField.text?.isEmpty == true || passWordTextField.text?.isEmpty == true){
            print("패스워드 비어있음")
            checkPwAndShowLabel(isValid: true)
            self.activateNextBtn(isAct: false)
        }
        else if (checkPassWordTextField.text?.isEmpty == false && passWordTextField.text?.isEmpty == false) {
            
            if checkPassWordTextField.text! == passWordTextField.text!{ //패스워드가 일치할 경우
                print("비밀번호 일치")
                checkPwAndShowLabel(isValid: true)
                self.textViewDidEndEditing(textView)//텍스트 뷰에 입력값이 있는지 확인하기
            } else {
                checkPwAndShowLabel(isValid: false)
            }
        }
    }
    
    func checkPwAndShowLabel(isValid: Bool){
        if isValid == true {
            isValidPWLabel.text = ""
        } else {
            isValidPWLabel.text = "비밀번호가 일치하지 않습니다."
            isValidPWLabel.textColor = .red
        }
    }

//  MARK: IBActions
    //세그웨이에서 화면복귀법 = 따로 Outlet연결은 필요없고 코드만 작성하면 된다
    @IBAction func backToView2(_ unwindSegue: UIStoryboardSegue){
        print("화면이동")
    }

}
