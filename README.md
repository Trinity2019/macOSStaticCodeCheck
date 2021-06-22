# macOS Static Code Signing Check
This sample code is associated with my blog post [Practical CPU time performance tuning for security software: Part 1](https://www.elastic.co/blog/practical-cpu-time-performance-tuning-security-software?hfdgl). It demonstrates how to check static code signing information using `SecStaticCodeCheckValidityWithErrors` API and then demonstrates it's impact on the CPU usage when it is used on a large bundle.

Note that the purpose of this sample is not to question Apple’s implementation of `SecStaticCodeCheckValidity*` on the performance side. Instead, I want to demonstrate that code signing validation is CPU intensive.  We should carefully evaluate its impact on CPU/resource consumption and carefully choose when to use it and when not to use it.

## To clone this repo:
```
git clone git@github.com:Trinity2019/macOSStaticCodeCheck.git
```

## Build:
Open `checkCSInfoObserveCPU.xcodeproj` project and build with `Xcode`.

## std output of the program:
```2021-06-01 20:36:15.784 checkCSInfoObserveCPU[51925:3972133] Reading code sign information of [/Applications/Xcode.app/Contents/MacOS/Xcode]...
2021-06-01 20:38:29.230 checkCSInfoObserveCPU[51925:3972133] SecStaticCodeCheckValidityWithErrors returned err code =  -67054
2021-06-01 20:38:29.230 checkCSInfoObserveCPU[51925:3972133] SecStaticCodeCheckValidityWithErrors took 134 seconds to finish.
2021-06-01 20:38:29.248 checkCSInfoObserveCPU[51925:3972133] Signature status: a sealed resource is missing or invalid
2021-06-01 20:38:29.248 checkCSInfoObserveCPU[51925:3972133] Team ID =  59GAB85EFG
2021-06-01 20:38:29.248 checkCSInfoObserveCPU[51925:3972133] Signing ID =  com.apple.dt.Xcode
```
Note: For simplicity, the code assumes `Xcode` is installed at this path: `/Applications/Xcode.app/Contents/MacOS/Xcode` and hardcoded it in the main function. You can also change the hardcoded path to something else for testing purposes.

## CPU Test Result:
![checkCSInfoObserveCPU_400_CPU](https://user-images.githubusercontent.com/56367679/119930386-30a11600-bf34-11eb-975f-5ce0252bfe71.png)
Note: Above result was obtained from a physical macbook pro with 8 cores. Depending on the hardware spec, if you run the same program on different machines, %CPU consumption may differ. For example, I've also tested the same program on a virtual machine with 4 cores, and the %CPU consumption range was 100~200%.


## Spindump output is [here](./checkCSInfoObserveCPU.txt)
