//
//  AuthViewController .swift
//  DZ54R
//
//  Created by merim kasenova on 27/5/23.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private lazy var loginTF: UITextField = {
        let field = UITextField ()
        field.placeholder = "Введите логин"
        return field
    }()
    
    private lazy var passwordTF: UITextField = {
        let field = UITextField ()
        field.placeholder = "Введите пароль"
        return field
    }()
    
    @objc private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("loginButton", for: .normal)
        button.addTarget(self, action: #selector(getter: loginButton),
                               for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        logonButton()
        read()
       
        func setupView() {
            
            view.addSubview(loginTF)
            view.addSubview(passwordTF)
            view.addSubview(loginButton)
            
            loginTF.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(180)
                make.leading.equalToSuperview().offset(30)
                make.trailing.equalToSuperview().inset(30)
                make.height.equalTo(40)
            }
            
            passwordTF.snp.makeConstraints { make in
                make.top.equalTo(loginTF.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(30)
                make.trailing.equalToSuperview().inset(30)
                make.height.equalTo(40)
            }
            
            loginButton.snp.makeConstraints { make in
                make.top.equalTo(passwordTF.snp.bottom).offset(30)
                make.trailing.equalToSuperview().inset(30)
            }
        }
    }
    

    func read() {
        let name = UserdefaultStorage.shared.getString(forKey: .productName)
        print("Produtc name is :\(name)")
        
        let data: Any? = KeyChainManager.shared.read(with: Keychain.service, Keychain.account)
        print("model isss: \(data)")
    }
    
    @objc
    private func logonButton() {
        if loginTF.text!.isEmpty && passwordTF.text!.isEmpty {
            colorTextField(loginTF)
            colorTextField(passwordTF)
        } else {
            loginTF.layer.borderWidth = 0
            passwordTF.layer.borderWidth = 0
            
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc,animated: true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func colorTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
    }
}
   
