import UIKit
import AVFoundation


func thumbnailImageFor(fileUrl:URL) -> UIImage? {

    let video = AVURLAsset(url: fileUrl, options: [:])
    let assetImgGenerate = AVAssetImageGenerator(asset: video)
    assetImgGenerate.appliesPreferredTrackTransform = true

    let videoDuration:CMTime = video.duration
    let durationInSeconds:Float64 = CMTimeGetSeconds(videoDuration)

    let numerator = Int64(1)
    let denominator = videoDuration.timescale
    let time = CMTimeMake(value: numerator, timescale: denominator)

    do {
        let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        let thumbnail = UIImage(cgImage: img)
        return thumbnail
    } catch {
        print(error)
        return nil
    }
}
