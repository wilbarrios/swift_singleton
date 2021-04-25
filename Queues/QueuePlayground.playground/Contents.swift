import UIKit

DispatchQueue.global().sync {
    sleep(2)
    print("sync: Inside")
}

print("sync: Outside")

DispatchQueue.global().async {
    sleep(2)
    print("async: Inside")
}

print("async: Outside")

DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { print("Delay 5 seconds") })
DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: { print("Delay 2 seconds") })

