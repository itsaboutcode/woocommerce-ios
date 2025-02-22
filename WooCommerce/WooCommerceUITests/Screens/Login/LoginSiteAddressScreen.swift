import UITestsFoundation
import XCTest

private struct ElementStringIDs {
    static let navBar = "WordPressAuthenticator.LoginSiteAddressView"
    static let nextButton = "Site Address Next Button"

    // TODO: clean up comments when unifiedSiteAddress is permanently enabled.

    // For original Site Address. This matches accessibilityIdentifier in Login.storyboard.
    // Leaving here for now in case unifiedSiteAddress is disabled.
    // static let siteAddressTextField = "usernameField"

    // For unified Site Address. This matches TextFieldTableViewCell.accessibilityIdentifier.
    static let siteAddressTextField = "Site address"
}

final class LoginSiteAddressScreen: BaseScreen {
    private let navBar: XCUIElement
    private let siteAddressTextField: XCUIElement
    private let nextButton: XCUIElement

    init() {
        let app = XCUIApplication()
        navBar = app.navigationBars[ElementStringIDs.navBar]
        siteAddressTextField = app.textFields[ElementStringIDs.siteAddressTextField]
        nextButton = app.buttons[ElementStringIDs.nextButton]

        super.init(element: siteAddressTextField)
    }

    func proceedWith(siteUrl: String) -> GetStartedScreen {
        siteAddressTextField.tap()
        siteAddressTextField.typeText(siteUrl)
        nextButton.tap()

        return GetStartedScreen()
    }

    static func isLoaded() -> Bool {
        return XCUIApplication().buttons[ElementStringIDs.nextButton].exists
    }
}
