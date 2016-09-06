//
//  SavePhotoViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/02/27.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SavePhotoViewController: UIViewController {

    var img : UIImage!      //引き伸ばし、中央に寄せる用の画像
    var img2: UIImage!      //結果と同じ用の画像
    
    @IBOutlet var imgview: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        let alert = UIAlertController(title: "保存", message: "画像を保存します。\nどのように保存しますか？", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "結果画面と同じようにして保存", style: .Default, handler: {action in
            self.imgview.contentMode = UIViewContentMode.ScaleAspectFit
            self.imgview.image = self.img2
            self.takephoto()
        }))
        alert.addAction(UIAlertAction(title: "席を中央に寄せて保存", style: .Default, handler: {action in
            self.imgview.contentMode = UIViewContentMode.ScaleAspectFit
            self.imgview.image = self.img
            self.takephoto()
        }))
        alert.addAction(UIAlertAction(title: "引き伸ばして保存", style: .Default, handler: {action in
            self.imgview.contentMode = UIViewContentMode.ScaleToFill
            self.imgview.image = self.img
            self.takephoto()
            
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .Default, handler: {action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // 写真を撮る関数
    //
    func takephoto(){
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.mainScreen().scale * 3)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        let alert = UIAlertController(title: "完了", message: "画像の保存が完了しました。", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
