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
    
    func setupTimeoutInterval() {
        request.timeoutInterval = 5
    }
    
    func changeQuoteData(data: QuotesModelCodable) {
        for index in 0..<quote.count {
            if quote[index].c == data.c {
                if let c = data.c {
                    quote[index].c = c
                }
                
                if let chg = data.chg {
                    quote[index].chg = chg
                }
                
                if let pcp = data.pcp {
                    quote[index].pcp = pcp
                }
                
                if let ltp = data.ltp {
                    quote[index].ltp = ltp
                }
                
                if let name = data.name {
                    quote[index].name = name
                }
                
                if let ltr = data.ltr {
                    quote[index].ltr = ltr
                }
            }
        }
    }
    
    func updateQuotes(text: String) {
        let data = text.trim().replacingText(replacingText: "\"q\",").data(using: .utf8)!
        
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
}
