//
//  SignUpViewController.swift
//  ragistration
//
//  Created by R&W on 04/03/34.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController{
    
    
    var arrUser: [Users] = []
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var userNameTextFieald: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    
    var arrOfGender: [String] = ["Male","Female","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [userNameTextFieald,dateOfBirth,eMailTextField,phoneNumber,passwordTextField,registerButton,genderTextField].forEach{
            setCornerRadius(view: $0, cornerRadius: 10)
        }
        setup()
    }
    func setCornerRadius(view: UIView, cornerRadius: CGFloat){
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    private func displayValidation(massage: String){
        let alert: UIAlertController = UIAlertController(title: "Error", message: massage, preferredStyle: .alert)
        let okButten: UIAlertAction = UIAlertAction(title: "ok", style: .default)
        let cancelButten: UIAlertAction = UIAlertAction(title: "cancel", style: .destructive)
        alert.addAction(okButten)
        alert.addAction(cancelButten)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func ragistration(_ sender: UIButton) {
        if userNameTextFieald.text == "" && dateOfBirth.text == "" &&   eMailTextField.text == "" &&   phoneNumber.text == "" && passwordTextField.text == "" {
            displayValidation(massage: "Please fill all requierd validation")
        }else if userNameTextFieald.text == "" {
            displayValidation(massage: "Please enter user name")
        } else if dateOfBirth.text == "" {
            displayValidation(massage: "Please enter date of birth")
        } else if eMailTextField.text == "" {
            displayValidation(massage: "Please enter E-Mail")
        } else if phoneNumber.text == "" {
            displayValidation(massage: "Please enter phone number")
        } else if passwordTextField.text == "" {
            displayValidation(massage: "Please enter password")
        } else if phoneNumber.text?.count != 10{
            displayValidation(massage: "incorrect password")
        }
        
        let homeScreenViewController = storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        navigationController?.pushViewController(homeScreenViewController, animated: true)
        homeScreenViewController.name = userNameTextFieald.text ?? ""
        homeScreenViewController.arrUserDetails = arrUser
        
        
    }
    private func setup(){
        userNameTextFieald.delegate = self
        dateOfBirth.delegate = self
        eMailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumber.delegate =  self
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag{
        case 0: return true
        case 1: return true
        case 2:return false
        case 3: return true
        case 4: return true
        case 5: return true
        default:
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension SignUpViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrOfGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOfGender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected option \(arrOfGender[row])")
        genderTextField.text = arrOfGender[row]
    }
    
}
extension SignUpViewController{
    private func getUser(){
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else {return}
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let apiData = data else {return}
            do{
                self.arrUser = try JSONDecoder().decode([Users].self, from: apiData)
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}

