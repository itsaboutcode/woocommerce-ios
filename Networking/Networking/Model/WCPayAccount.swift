/// Represent a WCPay accont Entity.
///
public struct WCPayAccount: Decodable {
    public static let gatewayID = "woocommerce-payments"

    public let status: WCPayAccountStatusEnum
    public let hasPendingRequirements: Bool
    public let hasOverdueRequirements: Bool
    public let currentDeadline: Date?
    /// An alphanumeric string set by the merchant, e.g. `MYSTORE.COM`
    /// See https://stripe.com/docs/statement-descriptors
    public let statementDescriptor: String
    /// A three character lowercase currency code, e.g. `usd`
    /// See https://stripe.com/docs/api/accounts/object#account_object-default_currency
    public let defaultCurrency: String
    public let supportedCurrencies: [String]
    /// A two character country code, e.g. `US`
    /// See https://stripe.com/docs/api/accounts/object#account_object-country
    public let country: String
    /// A boolean flag indicating if this Account is eligible for card present payments
    public let isCardPresentEligible: Bool

    public init(
        status: WCPayAccountStatusEnum,
        hasPendingRequirements: Bool,
        hasOverdueRequirements: Bool,
        currentDeadline: Date?,
        statementDescriptor: String,
        defaultCurrency: String,
        supportedCurrencies: [String],
        country: String,
        isCardPresentEligible: Bool
    ) {
        self.status = status
        self.hasPendingRequirements = hasPendingRequirements
        self.hasOverdueRequirements = hasOverdueRequirements
        self.currentDeadline = currentDeadline
        self.statementDescriptor = statementDescriptor
        self.defaultCurrency = defaultCurrency
        self.supportedCurrencies = supportedCurrencies
        self.country = country
        self.isCardPresentEligible = isCardPresentEligible
    }

    /// The public initializer for WCPay Account.
    ///
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.decode(WCPayAccountStatusEnum.self, forKey: .status)
        let hasPendingRequirements = try container.decode(Bool.self, forKey: .hasPendingRequirements)
        let hasOverdueRequirements = try container.decode(Bool.self, forKey: .hasOverdueRequirements)
        let currentDeadline = try container.decodeIfPresent(Date.self, forKey: .currentDeadline)
        let statementDescriptor = try container.decode(String.self, forKey: .statementDescriptor)
        let currencyContainer = try container.nestedContainer(keyedBy: CurrencyCodingKeys.self, forKey: .storeCurrencies)
        let defaultCurrency = try currencyContainer.decode(String.self, forKey: .defaultCurrency)
        let supportedCurrencies = try currencyContainer.decode([String].self, forKey: .supported)
        let country = try container.decode(String.self, forKey: .country)
        /// Ignore the state of the In-Person Payments Beta flag (`.cardPresentEligible`). Allow any site. See #5030
        /// let cardPresentEligible = try container.decodeIfPresent(Bool.self, forKey: .cardPresentEligible) ?? false

        self.init(
            status: status,
            hasPendingRequirements: hasPendingRequirements,
            hasOverdueRequirements: hasOverdueRequirements,
            currentDeadline: currentDeadline,
            statementDescriptor: statementDescriptor,
            defaultCurrency: defaultCurrency,
            supportedCurrencies: supportedCurrencies,
            country: country,
            isCardPresentEligible: true
        )
    }
}

public extension WCPayAccount {
    static let noAccount = WCPayAccount(
        status: .noAccount,
        hasPendingRequirements: false,
        hasOverdueRequirements: false,
        currentDeadline: nil,
        statementDescriptor: "",
        defaultCurrency: "",
        supportedCurrencies: [],
        country: "",
        isCardPresentEligible: false
    )
}

private extension WCPayAccount {
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case hasPendingRequirements = "has_pending_requirements"
        case hasOverdueRequirements = "has_overdue_requirements"
        case currentDeadline = "current_deadline"
        case statementDescriptor = "statement_descriptor"
        case storeCurrencies = "store_currencies"
        case country = "country"
        case cardPresentEligible = "card_present_eligible"
    }

    enum CurrencyCodingKeys: String, CodingKey {
        case defaultCurrency = "default"
        case supported = "supported"
    }
}
