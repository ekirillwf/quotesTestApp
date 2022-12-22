//
//  QuotesModel.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 21.12.2022.
//

struct QuotesModel {
    var name: String?
    var descLastActive: (String?, String?)
    var changingPercantage: Double?
    var changingLastDeal: (Double?, Double?)
}

enum QuotesType: String, CaseIterable {
    case spIdx = "SP500.IDX"
    case aaplUS = "AAPL.US"
    case rsti = "RSTI"
    case gazp = "GAZP"
    case mrkz = "MRKZ"
    case rual = "RUAL"
    case hydr = "HYDR"
    case mrks = "MRKS"
    case sber = "SBER"
    case fees = "FEES"
    case tgka = "TGKA"
    case vtbr = "VTBR"
    case anHUS = "AN H.US"
    case viclUS = "VICL.US"
    case burhUS = "BURG.US"
    case nblUS = "NBL.US"
    case yetiUS = "YETI.US"
    case wsfsUS = "WSFS.US"
    case nioUS = "NIO.US"
    case dxcUS = "DXC.US"
    case micUS = "MIC.US"
    case hsbcUS = "HSBC.US"
    case expnEU = "EXPN.EU"
    case gskEU = "GSK.EU"
    case shpEU = "SHP.EU"
    case manEU = "MAN.EU"
    case dbEU = "DB1.EU"
    case MUVEU = "MUV2.EU"
    case tateEU = "TATE.EU"
    case kgfEU = "KGF.EU"
    case mggtEU = "MGGT.EU"
    case sgGDEU = "SG GD.EU"
}


final class QuotesModelCodable: Codable {
    
    var chg: Double? = 0
    var ltp: Double? = 0
    var name: String? = ""
    var ltr: String? = ""
    var pcp: Double? = 0
    var c: String? = ""
    
    private enum CodingKeys: String, CodingKey {
        case chg
        case ltp
        case name
        case ltr
        case pcp
        case c
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chg = try? container.decode(Double?.self, forKey: .chg)
        ltp = try? container.decode(Double?.self, forKey: .ltp)
        name = try? container.decode(String?.self, forKey: .name)
        ltr = try? container.decode(String?.self, forKey: .ltr)
        pcp = try? container.decode(Double?.self, forKey: .pcp)
        c = try? container.decode(String?.self, forKey: .c) 
    }
}
