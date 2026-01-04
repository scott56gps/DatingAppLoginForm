//
//  File.swift
//  FormValidation
//
//  Created by Scott Nicholes on 12/11/25.
//

import Foundation
import SwiftUI

struct ReactiveForm: View {
    @ObservedObject var model: ReactiveFormModel
    @State var showSuccess: Bool = false
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isConfirmPasswordFocused: Bool

    var body: some View {
        Form {
            Text("Form Valid: \(model.isFormValid ? "Valid" : "Invalid")")
            TextField("Email", text: $model.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .padding()
                .focused($isEmailFocused)
                .onChange(of: model.email) { _ in
                    model.emailIsTouched = true
                }
            if (model.emailIsTouched && !isEmailFocused) {
                ForEach(model.$email.errors, id: \.message) { error in
                    Text(error.message)
                        .foregroundStyle(Color(.systemRed))
                }
            }
                
            SecureField("Password", text: $model.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .padding()
                .focused($isPasswordFocused)
                .onChange(of: model.password) { _ in
                    model.passwordIsTouched = true
                }
            if (model.passwordIsTouched && !isPasswordFocused) {
                ForEach(model.$password.errors, id: \.message) { error in
                    Text(error.message)
                        .foregroundStyle(Color(.systemRed))
                }
            }
            
            SecureField("Confirm Password", text: $model.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .padding()
                .focused($isConfirmPasswordFocused)
                .onChange(of: model.confirmPassword) { _ in
                    model.confirmPasswordIsTouched = true
                }
            if (model.confirmPasswordIsTouched && !isConfirmPasswordFocused && model.passwordsMatchError != nil) {
                VStack {
                    ForEach(
                        model.$confirmPassword.errors,
                        id: \.message
                    ) { error in
                        Text(error.message)
                            .foregroundStyle(Color(.systemRed))
                    }
                    if let message = model.passwordsMatchError?.message {
                        Text(message)
                            .foregroundStyle(Color(.systemRed))
                    }
                }
            }
                            
            Button("Submit") {
                model.makeRequest()
                showSuccess = true
            }
            .disabled(!model.isFormValid)
            .padding()
            
            if showSuccess {
                Text("Form Submitted!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
}

