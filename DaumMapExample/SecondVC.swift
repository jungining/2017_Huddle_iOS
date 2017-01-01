//
//  SecondVC.swift
//  seminar_2_hw
//
//  Created by YuJungin on 2016. 10. 23..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SecondVC : UIViewController, NetworkCallback {
    internal func networkResult(resultData: Any, code: Int) {
        
        
        let alert = UIAlertController(title: "", message: "\(resultData)", preferredStyle: .alert)
        
        alert.addAction(btnOk)
        present(alert, animated: true , completion: nil)
    }

    let btnOk = UIAlertAction(title: "확인", style: .default, handler: {_ in print("얍")})

//    let maleImage = UIImage(named: "ic_male")
//    let femaleImage  = UIImage(named: "ic_female")
//    let maleImageClicked = UIImage(named: "ic_male_check")
//    let femaleImageClicked  = UIImage(named: "ic_female_check")
    
    let maleImage = UIImage(named: "icon")
    let femaleImage  = UIImage(named: "icon")
    let maleImageClicked = UIImage(named: "icon")
    let femaleImageClicked  = UIImage(named: "icon")
  
    var IDdata = ""
    var PWdata = ""
    var Namedata = ""
    var Agedata = ""
    var IsWoman = true
    
    @IBAction func checkID(_ sender: AnyObject) {
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        model.checkID(id: id)
        
    }
    @IBOutlet var CompleteBtn: UIButton!

    @IBOutlet var imgContent: UIImageView!
      @IBOutlet var IdTextField: UITextField!
    @IBOutlet var PwTextField: UITextField!
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var AgeTextField: UITextField!
    
    @IBOutlet var maleImageToggleBtn: ToggleImageBtn!
    @IBOutlet var femaleImageToggleBtn: ToggleImageBtn!

    public var receivedinputIdData : String = ""
    public var receivedinputPasswdData : String = ""

    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 포토 갤러리로 넘어가는거 구현

        picker.allowsEditing = true
        picker.delegate = self // 딜리게이트구현. 지금처럼 하지 말고 extension 이용해서 딜리게이트 상속받기
        

//        maleImageToggleBtn.setBackgroundImage(maleImageClicked, for: UIControlState())
//        maleImageToggleBtn.setBtnClickedImg(clickedImage: maleImageClicked!)
//        maleImageToggleBtn.setBtnUnClickedImg(unClickedImage: maleImage!)
//        
//        femaleImageToggleBtn.setBackgroundImage(femaleImageClicked, for: UIControlState())
//        femaleImageToggleBtn.setBtnClickedImg(clickedImage: femaleImageClicked!)
//        femaleImageToggleBtn.setBtnUnClickedImg(unClickedImage: femaleImage!)
        
        CompleteBtn.isEnabled = false
        CompleteBtn.backgroundColor = UIColor( red :177/255 , green : 181/255, blue : 192/255, alpha : 1)
        

           }
    @IBAction func selectPhoto(_ sender: AnyObject) {
        // 새로운 화면창을 띄운다
        // 10.0부터 사진첩 열 때 허락 받아야함 -> Info.plist 오른쪽클릭 -> open as -> source code한 뒤 <key>와 <string> 입력 (딕셔너리형태라고 생각하면 됨. 키와 밸류, 키와 밸류 ...)
        present(picker, animated: true)
    }
    
    @IBAction func ValueChanged(_ sender: AnyObject) {
        if((IdTextField.text?.characters.count != 0) && (PwTextField.text?.characters.count != 0) && (NameTextField.text?.characters.count != 0) && (AgeTextField.text?.characters.count != 0) ){
            CompleteBtn.isEnabled = true
            CompleteBtn.backgroundColor = UIColor( red :238/255 , green : 203/255, blue : 44/255, alpha : 1)
            
        }
        else{
            CompleteBtn.isEnabled = false
            CompleteBtn.backgroundColor = UIColor( red :177/255 , green : 181/255, blue : 192/255, alpha : 1)
        }
        
    }
    func IsTextFieldEmpty(TextfieldCharacterCount : Int) -> Bool {
        
        if(TextfieldCharacterCount>0){
            return false
        }
        else{
            return true
        }
        
    }
    @IBAction func FCompleteBtn(_ sender: AnyObject) {
        
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        let pw = gsno(PwTextField.text)
        let ph = gsno(AgeTextField.text)
        let name = gsno(NameTextField.text)
        if let image = imgContent.image{
            let imageData = UIImageJPEGRepresentation(image, 0.5) // (데이터로 바꿔준 이미지, 품질)
            model.joinWithPhoto(id: id, pw: pw, ph: ph, name: name, imageData: imageData)
        }
        //model.joinWithPhoto(id: id, pw: pw, ph: ph, name: name, imageData: <#T##Data?#>)
      //  model.join(id: id, pw: pw, ph: ph, name: name,)
        
        
//            
//            let noldamTransitionDelegate = NoldamTrasitionDelegate()
//            transitioningDelegate = noldamTransitionDelegate
//            let pvc = storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
//            pvc.modalPresentationStyle = .custom
//            pvc.strDate = id
//            pvc.transitioningDelegate = noldamTransitionDelegate
//            present(pvc, animated: true)
    }
        
        


        
        
    
    func IsFemale(){
        if(maleImageToggleBtn.Btnstate == 1 && femaleImageToggleBtn.Btnstate == 0){
            IsWoman = true}
        else if (maleImageToggleBtn.Btnstate == 0 && femaleImageToggleBtn.Btnstate == 1){
            IsWoman = false}
    }
}

extension SecondVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // 이미지 선택하려다 취소했을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
    
    // 사진 선택 관련 딜리게이트
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("선택완료")
        // 새로운 이미지 프로퍼티를 만들어주고
        var newImage: UIImage
        
        //인자로 받은 info 딕셔너리 안에 만들어져 있는 거
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage{ // 크롭된 이미지
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 크롭 안 된 원본 이미지
            newImage = possibleImage
        } else {
            return
        }
        imgContent.roundedBorder()
        imgContent.image = newImage
        dismiss(animated: true, completion: nil) // present로 사진선택 들어왔기 때문에 dismiss 해주어야 함
    }
}
