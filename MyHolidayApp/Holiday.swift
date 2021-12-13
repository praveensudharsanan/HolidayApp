//
//  Holiday.swift
//  holidayApp
//
//  Created by user199544 on 12/8/21.
//

import Foundation
struct HolidayResponse:Decodable {
    var response:Holidays
    
}
struct Holidays:Decodable {
    var holidays:[HolidayDetail]
    
}
struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
    
}

struct DateInfo:Decodable {
    var iso:String
    
}
