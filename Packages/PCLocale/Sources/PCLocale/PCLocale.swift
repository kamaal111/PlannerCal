//
//  PCLocale.swift
//  
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI

public struct PCLocale {
    public enum Keys: String {
        case APP_TITLE
        case NOW
        case ADD_ITEM
        case TITLE_INPUT_FIELD_LABEL
        case DATE_LABEL
        case NOTES
        case TITLE_INPUT_FIELD_PLACEHOLDER
    }

    static public func getLocalizableString(of key: Keys, with variables: CVarArg...) -> String {
        let bundle = Bundle.module
        let keyRawValue = key.rawValue
        return NSLocalizedString(keyRawValue, bundle: bundle, comment: "")
    }
}

public extension Text {
    init(localized: PCLocale.Keys) {
        self.init(PCLocale.getLocalizableString(of: localized))
    }
}
