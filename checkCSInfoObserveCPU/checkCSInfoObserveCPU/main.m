//
//  main.m
//  ReadSignatureObserveCPU
//
//  Created by Yamin Tian on 5/16/21.
//

#import <Foundation/Foundation.h>
#import "checkStaticCSInfo.h"

int
main(
    int argc,
    const char *argv[])
{
    @autoreleasepool
    {
        // The test reads static codesign info of Xcode because it is a large bundle
        // Can be changed to other paths for testing
        NSString *fileName          = @"/Applications/Xcode.app/Contents/MacOS/Xcode";
        checkStaticCSInfo *myCSInfo = [checkStaticCSInfo new];

        NSLog(@"Reading code sign information of [%@]...", fileName);

        [myCSInfo checkStaticCSInfoOnPath:fileName withRequirement:"anchor trusted"];
    }
    return 0;
}
