//
//  InfoScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import SafariServices
import UIKit

protocol InfoScreenDelegate: AnyObject {
    func configureVC()
}

final class InfoScreen: UIViewController {

    private var titleLabel: UILabel {

        let label = UILabel()
        label.text = "Contact"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .gray.withAlphaComponent(0.85)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }

    private var itemLabel: UILabel {

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.textColor = .black.withAlphaComponent(0.70)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }

    private var separator: UIView {

        let separator = UIView()
        separator.backgroundColor = .gray.withAlphaComponent(0.2)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        return separator

    }

    private var nextButton: UIButton {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "chevron.right"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private var verticalContactStackView: UIStackView {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 7.0
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return stackView

    }

    private var horizontalContactStackView: UIStackView {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let viewModel = InfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()

    }

}

extension InfoScreen: InfoScreenDelegate {

    func configureVC() {

        title = "Info"

        view.backgroundColor = UIColor(named: "BackgroundColor")

        setupScrollView()
    }

    func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)

        scrollView.snp.makeConstraints { make in

            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)

        }

        scrollStackViewContainer.snp.makeConstraints { make in

            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.width.equalTo(scrollView.snp.width)

        }

        configureContainerView()

    }

    private func configureContainerView() {

        let contactLabel = titleLabel
        contactLabel.text = "Contact"

        scrollStackViewContainer.addArrangedSubview(contactLabel)
        scrollStackViewContainer.isLayoutMarginsRelativeArrangement = true
        scrollStackViewContainer.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        scrollStackViewContainer.setCustomSpacing(5, after: contactLabel)

        let githubLabel = itemLabel
        githubLabel.text = "GitHub"
        let githubButton = nextButton

        let linkedInLabel = itemLabel
        linkedInLabel.text = "LinkedIn"
        let linkedInButton = nextButton

        let mailLabel = itemLabel
        mailLabel.text = "Mail"
        let mailButton = nextButton

        let githubStackView = horizontalContactStackView
        githubStackView.addArrangedSubview(githubLabel)
        githubStackView.addArrangedSubview(githubButton)

        githubStackView.addTapGesture {
            self.openGitHub()
        }

        let linkedInStackView = horizontalContactStackView
        linkedInStackView.addArrangedSubview(linkedInLabel)
        linkedInStackView.addArrangedSubview(linkedInButton)
        linkedInStackView.addTapGesture {
            self.openLinkedIn()
        }

        let mailStackView = horizontalContactStackView
        mailStackView.addArrangedSubview(mailLabel)
        mailStackView.addArrangedSubview(mailButton)
        mailStackView.addTapGesture {
            self.openMailApp(toEmail: "cumahaznedar@gmail.com", subject: "Crypto Vault", body: "Hello")
        }

        let contactContainer = verticalContactStackView

        let firstSeparator = separator
        let secondSeparator = separator

        contactContainer.addArrangedSubview(githubStackView)
        contactContainer.addArrangedSubview(firstSeparator)
        contactContainer.addArrangedSubview(linkedInStackView)
        contactContainer.addArrangedSubview(secondSeparator)
        contactContainer.addArrangedSubview(mailStackView)

        contactContainer.isLayoutMarginsRelativeArrangement = true
        contactContainer.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        scrollStackViewContainer.addArrangedSubview(contactContainer)

        let privacyLabel = titleLabel
        privacyLabel.text = "Privacy"

        scrollStackViewContainer.addArrangedSubview(privacyLabel)
        scrollStackViewContainer.setCustomSpacing(30, after: contactContainer)
        scrollStackViewContainer.setCustomSpacing(5, after: privacyLabel)


        let privacyAgreLabel = itemLabel
        privacyAgreLabel.text = "Privacy Agreement"
        let privacyAgre = nextButton

        let privacyAgreStackView = horizontalContactStackView
        privacyAgreStackView.addArrangedSubview(privacyAgreLabel)
        privacyAgreStackView.addArrangedSubview(privacyAgre)

        let userAgreeLabel = itemLabel
        userAgreeLabel.text = "User Agreement"
        let userAgreeButton = nextButton

        let userAgreeStackView = horizontalContactStackView
        userAgreeStackView.addArrangedSubview(userAgreeLabel)
        userAgreeStackView.addArrangedSubview(userAgreeButton)

        let privacyContainer = verticalContactStackView

        let thirdSeparator = separator

        privacyContainer.addArrangedSubview(privacyAgreStackView)
        privacyContainer.addArrangedSubview(thirdSeparator)
        privacyContainer.addArrangedSubview(userAgreeStackView)

        privacyContainer.isLayoutMarginsRelativeArrangement = true
        privacyContainer.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        scrollStackViewContainer.addArrangedSubview(privacyContainer)

        let systemLabel = titleLabel
        systemLabel.text = "System"

        scrollStackViewContainer.addArrangedSubview(systemLabel)
        scrollStackViewContainer.setCustomSpacing(30, after: privacyContainer)
        scrollStackViewContainer.setCustomSpacing(5, after: systemLabel)

        let LanguageLabel = itemLabel
        LanguageLabel.text = "Language"
        let LanguageButton = nextButton

        let deviceLabel = itemLabel
        deviceLabel.text = "Device"
        let deviceName = itemLabel
        deviceName.textColor = .gray
        deviceName.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        deviceName.text = UIDevice().name

        let versionLabel = itemLabel
        versionLabel.text = "Version"
        let versionName = itemLabel
        versionName.textColor = .gray
        versionName.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        versionName.text = Bundle.main.releaseVersionNumber

        let languageStackView = horizontalContactStackView
        languageStackView.addArrangedSubview(LanguageLabel)
        languageStackView.addArrangedSubview(LanguageButton)

        let deviceStackView = horizontalContactStackView
        deviceStackView.addArrangedSubview(deviceLabel)
        deviceStackView.addArrangedSubview(deviceName)

        let versionStackView = horizontalContactStackView
        versionStackView.addArrangedSubview(versionLabel)
        versionStackView.addArrangedSubview(versionName)


        let systemContainer = verticalContactStackView

        let fourthSeparator = separator
        let fifthSeparator = separator

        systemContainer.addArrangedSubview(languageStackView)
        systemContainer.addArrangedSubview(fourthSeparator)
        systemContainer.addArrangedSubview(deviceStackView)
        systemContainer.addArrangedSubview(fifthSeparator)
        systemContainer.addArrangedSubview(versionStackView)

        systemContainer.isLayoutMarginsRelativeArrangement = true
        systemContainer.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        scrollStackViewContainer.addArrangedSubview(systemContainer)
    }

    func openGitHub() {

        let safariViewController = SFSafariViewController(url: URL(string: "https://www.github.com/Ryuk-C")!)
        present(safariViewController, animated: true)

    }

    func openLinkedIn() {

        let safariViewController = SFSafariViewController(url: URL(string: "https://www.linkedin.com/in/cumahaznedar/")!)
        present(safariViewController, animated: true)

    }

    func openMailApp(toEmail: String, subject: String, body: String) {
        guard
            let subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let body = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else {
            print("Error: Can't encode subject or body.")
            return
        }

        let urlString = "mailto:\(toEmail)?subject=\(subject)&body=\(body)"
        let url = URL(string: urlString)!

        UIApplication.shared.open(url)
    }

}
