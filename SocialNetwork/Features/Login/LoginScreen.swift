//
//  LoginScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

protocol LoginScreenDelegate: AnyObject {
    func tappedRecoveryPasswordButton()
    func tappedLoginButton()
    func tappedRegisterButton()
}

class LoginScreen: UIView {
    
    private weak var delegate: LoginScreenDelegate?
    
    func delegate(delegate: LoginScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SocialNetwork"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var peopleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "people-logo")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Que bom ter você aqui."
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Entre para ver as novidades."
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var backgroundLoginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var emailTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "email@exemplo.com"
        textField.textColor = .darkGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .appBackground
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var passwordTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "••••••••••"
        textField.textColor = .darkGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .appBackground
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var recoveryPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueceu sua senha?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(tappedRecoveryPasswordButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.backgroundColor = .blue.withAlphaComponent(0.4)
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não tem conta?"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar conta", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func tappedRecoveryPasswordButton(_ sender: UIButton) {
        delegate?.tappedRecoveryPasswordButton()
    }
    
    @objc
    private func tappedLoginButton(_ sender: UIButton) {
        delegate?.tappedLoginButton()
    }
    
    @objc
    private func tappedRegisterButton(_ sender: UIButton) {
        delegate?.tappedRegisterButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .appBackground
        
        addSubview(logoImageView)
        addSubview(appNameLabel)
        addSubview(peopleLogoImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(backgroundLoginView)
        backgroundLoginView.addSubview(emailLabel)
        backgroundLoginView.addSubview(emailTextField)
        backgroundLoginView.addSubview(passwordLabel)
        backgroundLoginView.addSubview(passwordTextField)
        backgroundLoginView.addSubview(recoveryPasswordButton)
        backgroundLoginView.addSubview(loginButton)
        addSubview(registerLabel)
        addSubview(registerButton)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 70),
            logoImageView.widthAnchor.constraint(equalToConstant: 70),
            
            appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            appNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            peopleLogoImageView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 25),
            peopleLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            peopleLogoImageView.heightAnchor.constraint(equalToConstant: 70),
            peopleLogoImageView.widthAnchor.constraint(equalToConstant: 210),
            
            titleLabel.topAnchor.constraint(equalTo: peopleLogoImageView.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            backgroundLoginView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            backgroundLoginView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundLoginView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundLoginView.heightAnchor.constraint(equalToConstant: 300),
            
            emailLabel.topAnchor.constraint(equalTo: backgroundLoginView.topAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            recoveryPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            recoveryPasswordButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            recoveryPasswordButton.heightAnchor.constraint(equalToConstant: 16),
            
            loginButton.topAnchor.constraint(equalTo: recoveryPasswordButton.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            registerLabel.topAnchor.constraint(equalTo: backgroundLoginView.bottomAnchor, constant: 25),
            registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -35),
            
            registerButton.centerYAnchor.constraint(equalTo: registerLabel.centerYAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 4),
            registerButton.heightAnchor.constraint(equalTo: recoveryPasswordButton.heightAnchor)
        ])
    }
    
    func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    func isEnableLoginButton(isEnable: Bool) {
        loginButton.backgroundColor = isEnable ? .blue : .blue.withAlphaComponent(0.4)
        loginButton.isEnabled = isEnable
    }
    
    func clearTextFields() {
        isEnableLoginButton(isEnable: false)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
