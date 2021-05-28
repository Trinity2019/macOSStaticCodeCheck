# macOSStaticCodeCheck
This sample code demonstrates how to check static code signing information using `SecStaticCodeCheckValidityWithErrors` API and then demonstrates it's impact on the CPU usage when it is used on a large bundle.

Note that the purpose of this sample is not to question Apple’s implementation of `SecStaticCodeCheckValidity*` on the performance side. Instead, I want to demonstrate that code signing validation is CPU intensive.  We should carefully evaluate its impact on CPU/resource consumption and carefully choose when to use it and when not to use it.

## To clone this repo:
```
git clone git@github.com:Trinity2019/macOSStaticCodeCheck.git
```

## Build:
Open `checkCSInfoObserveCPU.xcodeproj` project and build with `Xcode`.

## Test Result:
![checkCSInfoObserveCPU_400_CPU](https://user-images.githubusercontent.com/56367679/119930386-30a11600-bf34-11eb-975f-5ce0252bfe71.png)


## Spindump output is [here](./checkCSInfoObserveCPU.txt)
