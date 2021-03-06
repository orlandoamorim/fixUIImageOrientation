// Playground - noun: a place where people can play

import UIKit

func fixImageOrientation(src:UIImage)->UIImage {
    
    if src.imageOrientation == UIImageOrientation.Up {
        return src
    }
    
    var transform: CGAffineTransform = CGAffineTransformIdentity
    
    switch src.imageOrientation {
    case UIImageOrientation.Down, UIImageOrientation.DownMirrored:
        transform = CGAffineTransformTranslate(transform, src.size.width, src.size.height)
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        break
    case UIImageOrientation.Left, UIImageOrientation.LeftMirrored:
        transform = CGAffineTransformTranslate(transform, src.size.width, 0)
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        break
    case UIImageOrientation.Right, UIImageOrientation.RightMirrored:
        transform = CGAffineTransformTranslate(transform, 0, src.size.height)
        transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        break
    case UIImageOrientation.Up, UIImageOrientation.UpMirrored:
        break
    default:
        break
    }
    
    switch src.imageOrientation {
    case UIImageOrientation.UpMirrored, UIImageOrientation.DownMirrored:
        CGAffineTransformTranslate(transform, src.size.width, 0)
        CGAffineTransformScale(transform, -1, 1)
        break
    case UIImageOrientation.LeftMirrored, UIImageOrientation.RightMirrored:
        CGAffineTransformTranslate(transform, src.size.height, 0)
        CGAffineTransformScale(transform, -1, 1)
    case UIImageOrientation.Up, UIImageOrientation.Down, UIImageOrientation.Left, UIImageOrientation.Right:
        break
    default:
        break
    }
    
    
    var ctx:CGContextRef = CGBitmapContextCreate(nil, UInt(src.size.width), UInt(src.size.height), CGImageGetBitsPerComponent(src.CGImage), 0, CGImageGetColorSpace(src.CGImage), CGImageGetBitmapInfo(src.CGImage))
    
    CGContextConcatCTM(ctx, transform)
    
    switch src.imageOrientation {
    case UIImageOrientation.Left, UIImageOrientation.LeftMirrored, UIImageOrientation.Right, UIImageOrientation.RightMirrored:
        CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.height, src.size.width), src.CGImage)
        break
    default:
        CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.width, src.size.height), src.CGImage)
        break
    }
    
    let cgimg:CGImageRef = CGBitmapContextCreateImage(ctx)
    var img:UIImage = UIImage(CGImage: cgimg)
    
    return img
}