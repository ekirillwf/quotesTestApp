//
//  QuotesViewModel.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 21.12.2022.
//

import Foundation

class QuotesViewModel {
    var quote: [QuotesModelCodable] = []
    
    var request = URLRequest(url: URL(string: "wss://wss.tradernet.ru")!)
    var isConnected: Bool = false
    
    func changeQuoteData(data: QuotesModelCodable) {
        for index in 0..<quote.count {
            if quote[index].c == data.c {
                quote[index] = data
            }
        }
    }
    
    func updateQuotes(text: String) {
        let data = replacingOccurrences(text: text).data(using: .utf8)!
        
        do {
            let f = try JSONDecoder().decode([QuotesModelCodable].self, from: data)
            if quote.isEmpty {
                quote.append(f[0])
            }
            
            if !quote.contains(where: { $0.c == f[0].c }) {
                quote.append(f[0])
            } else {
                changeQuoteData(data: f[0])
            }
            
        } catch {
            print(error)
        }
    }
    
    func replacingOccurrences(text: String) -> String {
        var string = text
        string = string.replacingOccurrences(of: "\"q\",", with: "", options: [.caseInsensitive, .regularExpression])
        return string
    }
}
