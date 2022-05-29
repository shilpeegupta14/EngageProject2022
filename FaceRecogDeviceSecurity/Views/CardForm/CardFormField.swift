//
//  CardFormField.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-07.
//

import Combine
import Foundation
import SwiftUI

public struct CardFormField: View {
    
    @Binding var text: String
    @State private var isEditing = false
    
    var onEdit: (() -> Void)?
    
    //initialised properties of card fields
    var fieldTitle: String
    var isSecure: Bool
    var autocapitalizationType: UITextAutocapitalizationType
    var isCreditCardNumber: Bool
    var isExpiryDate: Bool
    
    //initialising the card fields
    init(
        fieldTitle: String,
        text: Binding<String>,
        isSecure: Bool = false,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        onEdit: (() -> Void)? = nil,
        isCreditCardNumber: Bool = false,
        isExpiryDate: Bool = false
    ) {
        self.fieldTitle = fieldTitle
        self._text = text
        self.isSecure = isSecure
        self.autocapitalizationType = autocapitalizationType
        self.onEdit = onEdit
        self.isCreditCardNumber = isCreditCardNumber
        self.isExpiryDate = isExpiryDate
    }
    //designed the credit card form fields 
    public var body: some View {
        VStack(alignment: .leading) {
            Text(fieldTitle)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(isEditing ? .red : .primaryColor)
            
            Group {
                //creating a secure text field
                if isSecure {
                    SecureField("", text: $text, onCommit: { onEdit?() })
                } else {
                    TextField(
                        "",
                        text: $text,
                        onEditingChanged: { isEditing in
                            self.isEditing = isEditing
                            if !isEditing { onEdit?() }
                        }
                    )
                }
            }
            .font(.system(size: 20, weight: .bold, design: .monospaced))
            .foregroundColor(.textFieldTextColor)
            .autocapitalization(autocapitalizationType)
            .disableAutocorrection(true)
            .padding(.all, 6)
            .background(Color.textFieldColor)
            .cornerRadius(5)
        }
    }
}

//struct CardFormField_Previews: PreviewProvider {
//
//    @State var text: String
//
//    static var previews: some View {
//        CardFormField(fieldTitle: "Card number", text: $text)
//    }
//}
