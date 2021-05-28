# macOSStaticCodeCheck
This sample code demonstrates how to check static code signing information using `SecStaticCodeCheckValidityWithErrors` API and then observe it's impact on the CPU usage when it is used on a large bundle.

Note that the purpose of this sample is not to question Apple’s implementation of `SecStaticCodeCheckValidity*` on the performance side. Instead, I want to demonstrate that code signing validation is CPU intensive, especially when validating large bundles.  We should carefully evaluate its impact on CPU/resource consumption and carefully choose when to use it and when not to use it.

## To clone this repo:
```
git clone git@github.com:Trinity2019/macOSStaticCodeCheck.git
```

## Build:
Open `checkCSInfoObserveCPU.xcodeproj` project and build with `Xcode`.

## Test Result:


## [spindump output](./checkCSInfoObserveCPU.txt)
