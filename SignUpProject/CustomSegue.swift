//
//  CustomSeque.swift
//  SignUpProject
//
//  Created by SCK INC on 2022/07/12.
//


import UIKit

//modal 화면에서 화면3으로 이동하기 위한 custom segue class
//오른쪽 화면이 왼쪽으로 이동하면서 등장
class CustomSegue: UIStoryboardSegue {
    override func perform() {
        //RightToLeft 화면 전환
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: { dst.view.transform = CGAffineTransform(translationX: 0, y: 0)}, completion: { finished in src.present(dst, animated: false, completion: nil)})
    }
}
