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
        case START_DATE_LABEL
        case END_DATE_LABEL
        case NOTES
        case TITLE_INPUT_FIELD_PLACEHOLDER
        case SAVE
        case TITLE_IS_EMPTY_ALERT_TITLE
        case TITLE_IS_EMPTY_ALERT_MESSAGE
        case END_DATE_BEFORE_START_ALERT_TITLE
        case END_DATE_BEFORE_START_ALERT_MESSAGE
        case DONE
        case CANCEL
        case EDIT
        case NO_SELECTION
        case UNFINISHED
        case GENERAL

        public var localized: String {
            PCLocale.getLocalizableString(of: self)
        }
    }

    static func getLocalizableString(of key: Keys, with variables: CVarArg...) -> String {
        let bundle = Bundle.module
        let keyRawValue = key.rawValue
        guard variables.isEmpty else { fatalError("Amount of variables are not supported") }
        return NSLocalizedString(keyRawValue, bundle: bundle, comment: "")
    }
}

public extension Text {
    init(localized: PCLocale.Keys) {
        self.init(PCLocale.getLocalizableString(of: localized))
    }
}
