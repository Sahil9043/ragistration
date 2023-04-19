//
//  NewPasswordViewController.swift
//  ragistration
//
//  Created by R&W on 23/02/34.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var confurmPassword: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var creatNewPassword: UILabel!
    @IBOutlet weak var creatPassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        [confurmPassword,enterPasswordTextField,creatNewPassword,changePassword].forEach{
            setCornerRadius(view: $0, cornerRadius: 10)
        }

    }
    func setCornerRadius(view: UIView, cornerRadius: CGFloat){
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    @IBAction func changePasswordTab(_ sender: UIButton) {
        if enterPasswordTextField.text == "" {
            displayValidation(massage: "Please enter password")
        } else if enterPasswordTextField.text?.count ?? 0 < 8{
            displayValidation(massage: "Password is short")
        } else if confurmPassword.text == ""{
            displayValidation(massage: "Please enter confurm password")
        } else if confurmPassword.text?.count ?? 0 < 8{
            displayValidation(massage: "Password is short")
        }
        
        if enterPasswordTextField.text != confurmPassword.text{
            displayValidation(massage: "Password is incorrect")
        }
 
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! LoginViewController
        navigationController?.pushViewController(viewController, animated: true)
        viewController.password = enterPasswordTextField.text
}
    private func displayValidation(massage: String){
        let alert: UIAlertController = UIAlertController(title: "Error", message: massage, preferredStyle: .alert)
        let okButten: UIAlertAction = UIAlertAction(title: "ok", style: .default)
        let cancelButten: UIAlertAction = UIAlertAction(title: "cancel", style: .destructive)
        
        alert.addAction(okButten)
        alert.addAction(cancelButten)
        present(alert, animated: true, completion: nil)
        
    }
}
