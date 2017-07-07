# Simple-Animation-iOS

In GravitySquareView, it include a CMMotionManager, use a CMMotionManager object to access accelerometer data, rotation-rate data, magnetometer data, and other device-motion data. 

GravitySquareView is easy to use. In the ViewController , just init it and invoke start function. 

The iOS simulator does not simulate any motion. You have to use a physical device to test anything with CMMotionManager.

# Example:
```
    let screenSize = UIScreen.main.bounds
    gravitySquareView = GravtitySquareView(frame: CGRect(x: screenSize.width/2, y: screenSize.height/2, width: 80, height: 80))
    gravitySquareView?.backgroundColor = UIColor.darkGray
    self.view.addSubview(gravitySquareView!)
    gravitySquareView?.start()

```
    



