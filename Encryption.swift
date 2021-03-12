import UIKit
import CommonCrypto
import Foundation
import UIKit
import IDZSwiftCommonCrypto
import CryptoSwift

class encryption {
    
    static let K = "VmtZcDNzNnY5eSRCJkUpSA=="
    static let KDT = Data(base64Encoded: encryption.K, options: .ignoreUnknownCharacters)
    static let KBA = [UInt8](KDT!)
    
    
    static var encryptedParam = ""
    static var encryptedIv = ""
    
    static var encryptedDataBase64 = ""
    static var encryptedIvBase64 = ""
    
    static var decryptedData = ""
}




func encryptAPI(dictionary: [String:Any])
{
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
    let jsonObject = json(from: dictionary)
    let jsonObjectByteArray: [UInt8] = Array(jsonObject!.utf8)
    
    let iv = try! Random.generateBytes(byteCount: 16)
    let ivData = Data(bytes: iv)
    encryption.encryptedIv = ivData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    
    
    do {
        let encrypted = try AES(key: encryption.KBA, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(jsonObjectByteArray)
        
        let data = Data(bytes: encrypted)
        encryption.encryptedParam = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    } catch {
        print(error)
    }

}




func decryptAPI()
{

    let ivData = Data(base64Encoded: "\(encryption.encryptedIvBase64)", options: .ignoreUnknownCharacters)
    let ivByteArray = [UInt8](ivData!)
    
    
    let dataAPI = Data(base64Encoded: "\(encryption.encryptedDataBase64)", options: .ignoreUnknownCharacters)
    let dataByteArray = [UInt8](dataAPI!)
    
    do {

        let decrypted = try AES(key: encryption.KBA, blockMode: CBC(iv: ivByteArray), padding: .pkcs7).decrypt(dataByteArray)
        let decryptedJsonString = String(bytes: decrypted, encoding: String.Encoding.utf8)
     //   print("\(decryptedJsonString)")
        encryption.decryptedData = decryptedJsonString!
        
    }
    
    catch {
        print(error)
    }

}
