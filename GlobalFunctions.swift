//
//  GlobalFunctions.swift
//  Call2Fix
//
//  Created by Afsal on 21/05/20.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation
import Kingfisher
import Alamofire
import AJMessage
import AVFoundation
import  SwiftyJSON

func showImageURL(elementURL:URL,img:UIImageView)
{
     let url = elementURL
    KingfisherManager.shared.retrieveImage(with: url) { result in
        let image = try? result.get().image
        if let image = image {
            img.image = image
        }
    }
}


struct keyboard
{
    static var keyboardHeight = 0
    static var editingAddressBegan = false
}

func errorNotification(title:String,message:String)
{
    let customRed = UIColor(red: 190.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    var config = AJMessageConfig.shared
    config.setBackgroundColor(customRed, status: .success)
    config.setImage(UIImage(named:"Caution"), status: .info)
    AJMessage.show(title: "\(title)", message: "\(message)", config: config)
}

func successNotification(title:String,message:String)
{
    let customGreen = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 0.0/255.0, alpha: 1)
    var config = AJMessageConfig.shared
    config.setBackgroundColor(customGreen, status: .success)
    config.setImage(UIImage(named:"Caution"), status: .info)
    AJMessage.show(title: "\(title)", message: "\(message)", config: config)
}

func stringToBytes(_ string: String) -> [UInt8]? {
    let length = string.count
    if length & 1 != 0 {
        return nil
    }
    var bytes = [UInt8]()
    bytes.reserveCapacity(length/2)
    var index = string.startIndex
    for _ in 0..<length/2 {
        let nextIndex = string.index(index, offsetBy: 2)
        if let b = UInt8(string[index..<nextIndex], radix: 16) {
            bytes.append(b)
        } else {
            return nil
        }
        index = nextIndex
    }
    return bytes
}

func getArrayOfBytesFromImage(imageData:Data) ->[UInt8]{

    let count = imageData.count / MemoryLayout<UInt8>.size
    var byteArray = [UInt8](repeating: 0, count: count)
    imageData.copyBytes(to: &byteArray, count:count)
    return byteArray

}



func toggleFlash() {
    guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
    guard device.hasTorch else { return }

    do {
        try device.lockForConfiguration()

        if (device.torchMode == AVCaptureDevice.TorchMode.on) {
            device.torchMode = AVCaptureDevice.TorchMode.off
        } else {
            do {
                try device.setTorchModeOn(level: 1.0)
            } catch {
                print(error)
            }
        }

        device.unlockForConfiguration()
    } catch {
        print(error)
    }
}


func videoPreviewImage(url: URL) -> UIImage? {
    let asset = AVURLAsset(url: url)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    if let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 2, preferredTimescale: 60), actualTime: nil) {
        return UIImage(cgImage: cgImage)
    }
    else {
        return nil
    }
}


func dateToMonth(date:String) -> String
{
    // 10/2/2020
    
    let dateWithTime = date
    let dateTimeSplitArray = dateWithTime.split{$0 == " "}.map(String.init)
    
    let dateOnly = dateTimeSplitArray[0]
    let dateSplitArray = dateOnly.split{$0 == "/"}.map(String.init)
    
    
    let month = dateSplitArray[0]
    let day = dateSplitArray[1]
    let year = dateSplitArray[2]
    
    var actualDate = ""
    
    if month == "1"
    {
        actualDate = "Jan \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "2"
    {
        actualDate = "Feb \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "3"
    {
        actualDate = "Mar \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "4"
    {
        actualDate = "Apr \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "5"
    {
        actualDate = "May \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "6"
    {
        actualDate = "Jun \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "7"
    {
        actualDate = "Jul \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "8"
    {
        actualDate = "Aug \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "9"
    {
        actualDate = "Sep \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "10"
    {
        actualDate = "Oct \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "11"
    {
        actualDate = "Nov \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    else if month == "12"
    {
        actualDate = "Dec \(day) \(year) \(dateTimeSplitArray[1]) \(dateTimeSplitArray[2])"
    }
    
    return actualDate
}


func generateThumbnailForVideoAtURL(filePathLocal: URL) -> UIImage? {

let vidURL = filePathLocal
    let asset = AVURLAsset(url: vidURL as URL)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true

let timestamp = CMTime(seconds: 1, preferredTimescale: 60)

do {
    let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
    return UIImage(cgImage: imageRef)
}
catch let error as NSError
{
    print("Image generation failed with error \(error)")
    return nil
}

}


