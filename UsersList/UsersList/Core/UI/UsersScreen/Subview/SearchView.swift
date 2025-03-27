//
//  SearchView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchQuery: String
    
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(Icons.searchIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            TextField(text, text: $searchQuery)
                .font(.system(size: 16))
                .foregroundColor(.colorText)
                .tint(.colorText)
                .padding(.trailing, 24)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchQuery.isEmpty {
                            Button(action: {
                                searchQuery = ""
                            }) {
                                Image(systemName: "xmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white).opacity(0.8)
                            }
                        }
                    }
                )
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    SearchView(searchQuery: .constant("a"), text: "asd")
}
