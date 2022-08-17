//
//  UserInformation.swift
//  SignUpProject
//
//  Created by SCK INC on 2022/07/11.
//

import Foundation

//싱글턴 패턴으로 userinformation 구현
struct UserInformation {
    
    static var shared: UserInformation = UserInformation()
    //딕셔너리변수 사용
    var userInformation = [String:String]()
    
    var id: String?
    var password: String?


}
