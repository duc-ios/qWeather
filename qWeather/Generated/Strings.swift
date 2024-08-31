// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// No Data
  internal static let noData = L10n.tr("Localizable", "no_data", fallback: "No Data")
  /// No Data.
  /// Enter a keyword to find your city.
  internal static let noDataEnterToSearchCity = L10n.tr("Localizable", "no_data_enter_to_search_city", fallback: "No Data.\nEnter a keyword to find your city.")
  /// Not found!
  internal static let notFound = L10n.tr("Localizable", "not_found", fallback: "Not found!")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok", fallback: "OK")
  internal enum Detail {
    /// Feels like %@
    internal static func feelsLike(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.feels_like", String(describing: p1), fallback: "Feels like %@")
    }
    /// Humidity: %@
    internal static func humidity(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.humidity", String(describing: p1), fallback: "Humidity: %@")
    }
    /// L:%@ - H:%@
    internal static func lh(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "detail.lh", String(describing: p1), String(describing: p2), fallback: "L:%@ - H:%@")
    }
    /// Pressure: %@
    internal static func pressure(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.pressure", String(describing: p1), fallback: "Pressure: %@")
    }
    /// Sunrise: %@
    internal static func sunrise(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.sunrise", String(describing: p1), fallback: "Sunrise: %@")
    }
    /// Sunset: %@
    internal static func sunset(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.sunset", String(describing: p1), fallback: "Sunset: %@")
    }
    /// Visibility: %@
    internal static func visibility(_ p1: Any) -> String {
      return L10n.tr("Localizable", "detail.visibility", String(describing: p1), fallback: "Visibility: %@")
    }
    /// Wind: %@ %@
    internal static func wind(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "detail.wind", String(describing: p1), String(describing: p2), fallback: "Wind: %@ %@")
    }
  }
  internal enum Error {
    /// Bad Request
    internal static let badRequest = L10n.tr("Localizable", "error.bad_request", fallback: "Bad Request")
    /// No network
    internal static let noNetwork = L10n.tr("Localizable", "error.no_network", fallback: "No network")
    /// Something went wrong
    internal static let somethingWentWrong = L10n.tr("Localizable", "error.something_went_wrong", fallback: "Something went wrong")
    /// Please try again later.
    internal static let tryAgain = L10n.tr("Localizable", "error.try_again", fallback: "Please try again later.")
    /// Unexpected Error
    internal static let unexpected = L10n.tr("Localizable", "error.unexpected", fallback: "Unexpected Error")
    /// Unimplemented
    internal static let unimplemented = L10n.tr("Localizable", "error.unimplemented", fallback: "Unimplemented")
  }
  internal enum Landing {
    /// Loading cities, please wait ...
    internal static let loading = L10n.tr("Localizable", "landing.loading", fallback: "Loading cities, please wait ...")
  }
  internal enum Onboarding {
    /// Get Started!
    internal static let getStarted = L10n.tr("Localizable", "onboarding.get_started", fallback: "Get Started!")
    internal enum Desc {
      /// Want to know the weather in a specific country? Just use our search feature to find any country instantly. Start typing the name, and we’ll help you find it.
      internal static let _1 = L10n.tr("Localizable", "onboarding.desc.1", fallback: "Want to know the weather in a specific country? Just use our search feature to find any country instantly. Start typing the name, and we’ll help you find it.")
      /// Keep your most-visited countries at your fingertips by marking them as favorites. Whether it’s for a planned trip or just curiosity, quickly access the weather in your favorite locations.
      internal static let _2 = L10n.tr("Localizable", "onboarding.desc.2", fallback: "Keep your most-visited countries at your fingertips by marking them as favorites. Whether it’s for a planned trip or just curiosity, quickly access the weather in your favorite locations.")
      /// Stay informed with our reliable weather forecasts. From daily to weekly predictions, qWeather provides the details you need to plan your day or week ahead.
      internal static let _3 = L10n.tr("Localizable", "onboarding.desc.3", fallback: "Stay informed with our reliable weather forecasts. From daily to weekly predictions, qWeather provides the details you need to plan your day or week ahead.")
    }
    internal enum Title {
      /// Search for Any Country
      internal static let _1 = L10n.tr("Localizable", "onboarding.title.1", fallback: "Search for Any Country")
      /// Save Your Favorite Countries
      internal static let _2 = L10n.tr("Localizable", "onboarding.title.2", fallback: "Save Your Favorite Countries")
      /// Get Accurate Weather Forecasts
      internal static let _3 = L10n.tr("Localizable", "onboarding.title.3", fallback: "Get Accurate Weather Forecasts")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
