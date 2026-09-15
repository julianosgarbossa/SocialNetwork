//
//  RegisterScreen.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

protocol RegisterScreenDelegate: AnyObject {
    func tappedRegisterButton()
    func tappedLoginButton()
}

class RegisterScreen: UIView {
    
    private weak var delegate: RegisterScreenDelegate?
    
    func delegate(delegate: RegisterScreenDelegate) {
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
        label.text = "Compartilhe seus momentos."
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crie sua conta e comece a sua história."
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
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirmar Senha"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var confirmPasswordTextField: PaddedTextField = {
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar Conta", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.backgroundColor = .blue.withAlphaComponent(0.4)
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Já tem uma conta?"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var LoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func tappedRegisterButton(_ sender: UIButton) {
        delegate?.tappedRegisterButton()
    }
    
    @objc
    private func tappedLoginButton(_ sender: UIButton) {
        delegate?.tappedLoginButton()
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
        backgroundLoginView.addSubview(confirmPasswordLabel)
        backgroundLoginView.addSubview(confirmPasswordTextField)
        backgroundLoginView.addSubview(registerButton)
        addSubview(loginLabel)
        addSubview(LoginButton)
        
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
            backgroundLoginView.heightAnchor.constraint(equalToConstant: 375),
            
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
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 5),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 35),
            registerButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: backgroundLoginView.bottomAnchor, constant: 25),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -25),
            
            LoginButton.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
            LoginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 4),
            LoginButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
        confirmPasswordTextField.delegate = delegate
    }
    
    func isEnableRegisterButton(isEnable: Bool) {
        registerButton.backgroundColor = isEnable ? .blue : .blue.withAlphaComponent(0.4)
        registerButton.isEnabled = isEnable
    }
    
    func clearTextFields() {
        isEnableRegisterButton(isEnable: false)
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
