//
//  ViewController.swift
//  ragistration
//
//  Created by R&W on 16/12/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    var password: String? = ""
    var arrUser: [Users] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()

        [loginButton,userNameTextField,passwordTextField,emailTextField].forEach{
            setCornerRadius(view: $0, cornerRadius: 7)
        }
    }
    func setCornerRadius(view: UIView, cornerRadius: CGFloat){
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    @IBAction func forgotPasswordTab(_ sender: UIButton) {
        let newPasswordViewContoller = storyboard?.instantiateViewController(withIdentifier: "NewPasswordViewController") as! NewPasswordViewController
        navigationController?.pushViewController(newPasswordViewContoller, animated: true)
    }
    
    @IBAction func loginButtonTab(_ sender: UIButton) {
        if emailTextField.text == "" && userNameTextField.text == "" && passwordTextField.text == ""{
            displayValidation(massage: "Please fill all requierd validation")
        }
        if passwordTextField.text?.count ?? 0 < 8{
            displayValidation(massage: "Password is short")
        }
//        if password != passwordTextField.text{
//            displayValidation(massage: "Enter correct password")
//        }
        if emailTextField.text == "" {
            displayValidation(massage: "Please enter E-Mail")
        } else if userNameTextField.text == "" {
            displayValidation(massage: "Please enter user name")
        } else if passwordTextField.text == ""{
            displayValidation(massage: "Please enter password")
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeScreenViewController: HomeScreenViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        //  homeScreenViewController.name = userNameTextField.text ?? ""
        homeScreenViewController.arrUserDetails = arrUser
        navigationController?.pushViewController(homeScreenViewController, animated: true)
    }
    private func displayValidation(massage: String){
        let alert: UIAlertController = UIAlertController(title: "Error", message: massage, preferredStyle: .alert)
        let okButten: UIAlertAction = UIAlertAction(title: "ok", style: .default)
        let cancelButten: UIAlertAction = UIAlertAction(title: "cancel", style: .destructive)
        
        alert.addAction(okButten)
        alert.addAction(cancelButten)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func signUpButtontab(_ sender: UIButton) {
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
extension LoginViewController{
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
struct Users: Decodable{
    var id: Int
    var name: String
    var email: String
    var status: String
    var gender: String
}
