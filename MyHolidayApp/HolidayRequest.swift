//
//  HolidayRequest.swift
//  holidayApp
//
//  Created by user199544 on 12/8/21.
//

import Foundation
import UIKit
enum HolidayError:Error{
    case noDataAvailable
    case canNotProcessData
}
struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "bdb20a61e74e2320f56e3ca624b8e5c52cd04559"
    init(countryCode:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=2022"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
        func getHolidays(completion: @escaping(Result<[HolidayDetail],HolidayError>) -> Void){
            let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _,_ in
                guard let jsonData = data else {
//                    let alert = UIAlertController(title: "Invalid Country Code", message: "Enter correct Country Code", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
//                    (alert, animated: true)
                    completion(.failure(.noDataAvailable))
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                    let holidayDetails = holidayResponse.response.holidays
                    completion(.success(holidayDetails))
                }catch{
                    completion(.failure(.canNotProcessData))
                }
            }
            dataTask.resume()
        }
        
    }

