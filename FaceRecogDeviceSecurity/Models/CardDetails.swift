//

import Foundation
import SwiftUI

public struct CardDetails: Hashable, Identifiable {
    //Listed the common properties of the Card
    public var number: String?
    public var name: String?
    public var expiryDate: String?
    public var cvcNumber: String?
    public var type: CardType
    public var industry: CardIndustry
    
    //initialise the properties
    public init(numberWithDelimiters: String? = nil, name: String? = nil, expiryDate: String? = nil, cvcNumber: String? = nil) {
        self.number = numberWithDelimiters
        self.name = name
        self.expiryDate = expiryDate
        self.cvcNumber = cvcNumber
        self.type = CardType(number: numberWithDelimiters?.replacingOccurrences(of: " ", with: ""))
        self.industry = .init(firstDigit: numberWithDelimiters?.first)
    }
    
    public var id: Int { hashValue }
}

public enum CardType: String, CaseIterable, Identifiable {
    //Catered to particular card types
    case masterCard = "MasterCard"
    case visa = "Visa"
    case amex = "Amex"
    case discover = "Discover"
    case dinersClubOrCarteBlanche = "Diner's Club/Carte Blanche"
    case unknown
    
    //initialising the card type based on the count of numbers in the card.
    public init(number: String?) {
        guard let count = number?.count, count >= 14 else {
            self = .unknown
            return
        }
        switch number?.first {
        case "3":
            if count == 15 {
                self = .amex
            } else if count == 14 {
                self = .dinersClubOrCarteBlanche
            } else {
                self = .unknown
            }
        case "4": self = (count == 13 || count == 16) ? .visa : .unknown
        case "5": self = count == 16 ? .masterCard : .unknown
        case "6": self = count == 16 ? .discover : .unknown
        default: self = .unknown
        }
    }
    
    public var id: Int { hashValue }
    
    //returning images of the detected card type from the assets folder.
    public var image: Image? {
        switch self {
        case .masterCard: return Image("mastercard-\(Color.isDarkInterfaceStyle ? "white" : "dark")-bg", bundle: .main)
        case .visa: return Image("visa", bundle: .main)
        case .amex: return Image("amex", bundle: .main)
        case .discover: return Image("discover", bundle: .main)
        case .dinersClubOrCarteBlanche: return Image("dinersclub", bundle: .main)
        case .unknown: return nil
        }
    }
}

public enum CardIndustry: String, CaseIterable, Identifiable {
    //Defined types of industry where card is used.
    case industry = "ISO/TC 68 and other industry assignments"
    case airlines = "Airlines"
    case airlinesFinancialAndFuture = "Airlines, financial and other future industry assignments"
    case travelAndEntertainment = "Travel and entertainment"
    case bankingAndFinancial = "Banking and financial"
    case merchandisingAndBanking = "Merchandising and banking/financial"
    case petroleum = "Petroleum and other future industry assignments"
    case healthcareAndTelecom = "Healthcare, telecommunications and other future industry assignments"
    case national = "For assignment by national standards bodies"
    case unknown
    
    //initialising the card industry based on the first digit
    public init(firstDigit: String.Element?) {
        switch firstDigit {
        case "0": self = .industry
        case "1": self = .airlines
        case "2": self = .airlinesFinancialAndFuture
        case "3": self = .travelAndEntertainment
        case "4", "5": self = .bankingAndFinancial
        case "6": self = .merchandisingAndBanking
        case "7": self = .petroleum
        case "8": self = .healthcareAndTelecom
        case "9": self = .national
        default: self = .unknown
        }
    }
    
    public var id: Int { hashValue }
}
