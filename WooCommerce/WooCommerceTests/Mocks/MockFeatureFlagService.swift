@testable import WooCommerce

struct MockFeatureFlagService: FeatureFlagService {
    private let isShippingLabelsM2M3On: Bool
    private let isInternationalShippingLabelsOn: Bool
    private let isShippingLabelsPaymentMethodCreationOn: Bool
    private let isShippingLabelsPackageCreationOn: Bool
    private let isShippingLabelsMultiPackageOn: Bool

    init(isShippingLabelsM2M3On: Bool = false,
         isInternationalShippingLabelsOn: Bool = false,
         isShippingLabelsPaymentMethodCreationOn: Bool = false,
         isShippingLabelsPackageCreationOn: Bool = false,
         isShippingLabelsMultiPackageOn: Bool = false) {
        self.isShippingLabelsM2M3On = isShippingLabelsM2M3On
        self.isInternationalShippingLabelsOn = isInternationalShippingLabelsOn
        self.isShippingLabelsPaymentMethodCreationOn = isShippingLabelsPaymentMethodCreationOn
        self.isShippingLabelsPackageCreationOn = isShippingLabelsPackageCreationOn
        self.isShippingLabelsMultiPackageOn = isShippingLabelsMultiPackageOn
    }

    func isFeatureFlagEnabled(_ featureFlag: FeatureFlag) -> Bool {
        switch featureFlag {
        case .shippingLabelsM2M3:
            return isShippingLabelsM2M3On
        case .shippingLabelsInternational:
            return isInternationalShippingLabelsOn
        case .shippingLabelsAddPaymentMethods:
            return isShippingLabelsPaymentMethodCreationOn
        case .shippingLabelsAddCustomPackages:
            return isShippingLabelsPackageCreationOn
        case .shippingLabelsMultiPackage:
            return isShippingLabelsMultiPackageOn
        default:
            return false
        }
    }
}
