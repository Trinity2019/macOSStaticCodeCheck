//
//  checkStaticCSInfo.m
//  checkCSInfoObserveCPU
//
//  Created by Yamin Tian on 5/25/21.
//


#import <Foundation/Foundation.h>
#import <Security/Security.h>

#import "checkStaticCSInfo.h"

@implementation checkStaticCSInfo

- (void)checkStaticCSInfoOnPath:(NSString *)path withRequirement:(const char *)requirement
{
    // Sec* API return status
    OSStatus status = !errSecSuccess;

    // input parameters for SecStaticCodeCheckValidity
    SecStaticCodeRef pStaticCode      = NULL;
    CFStringRef pAnchor               = NULL;
    SecRequirementRef pSecRequirement = NULL;

    // codesigning info details
    CFStringRef pStatusCFstr     = NULL;
    CFDictionaryRef pSigningInfo = NULL;
    CFStringRef pTeamId          = NULL;
    CFStringRef pSigningId       = NULL;

#ifdef DEBUG
    struct timespec start = {0};
    struct timespec end   = {0};
    uint64_t duration     = 0;
#endif

    if ((NULL == path) || (NULL == requirement))
    {
        NSLog(@"Invalid input.");
        goto Exit;
    }

    // Prepare input parameters for SecStaticCodeCheckValidity
    status = SecStaticCodeCreateWithPath(
        (__bridge CFURLRef)([NSURL fileURLWithPath:path]), kSecCSDefaultFlags, &pStaticCode);
    if (errSecSuccess != status)
    {
        NSLog(@"SecStaticCodeCreateWithPath failure. Err code =  %@",
            [NSNumber numberWithInt:status]);
        goto Exit;
    }

    // Anchor trusted
    pAnchor = CFStringCreateWithCString(NULL, "anchor trusted", kCFStringEncodingUTF8);
    if (NULL == pAnchor)
    {
        NSLog(@"Failed to CFStringCreateWithCString");
        goto Exit;
    }

    if (errSecSuccess !=
        SecRequirementCreateWithString(pAnchor, kSecCSDefaultFlags, &pSecRequirement))
    {
        NSLog(@"Failed to SecRequirementCreateWithString");
        goto Exit;
    }

#ifdef DEBUG
    clock_gettime(CLOCK_MONOTONIC, &start);
#endif

    // Static code sign check with no particular flags (default behavior)
    status = SecStaticCodeCheckValidityWithErrors(
        pStaticCode, (kSecCSDefaultFlags), pSecRequirement, NULL);
    if (errSecSuccess != status)
    {
        NSLog(@"SecStaticCodeCheckValidityWithErrors returned err code =  %@",
            [NSNumber numberWithInt:status]);
    }
#ifdef DEBUG
    clock_gettime(CLOCK_MONOTONIC, &end);

    // Not counting nanos for now. Will add later.
    duration = end.tv_sec - start.tv_sec;

    NSLog(@"SecStaticCodeCheckValidityWithErrors took %llu seconds to finish.", duration);
#endif

    pStatusCFstr = SecCopyErrorMessageString(status, NULL);
    NSLog(@"Signature status: %@", pStatusCFstr);

    // Copy the code signing info
    status = SecCodeCopySigningInformation(pStaticCode, kSecCSSigningInformation, &pSigningInfo);
    if (errSecSuccess != status)
    {
        NSLog(@"SecCodeCopySigningInformation returned err code =  %@",
            [NSNumber numberWithInt:status]);
        goto Exit;
    }

    // Get team_id
    pTeamId = (CFStringRef)CFDictionaryGetValue(pSigningInfo, kSecCodeInfoTeamIdentifier);
    if (NULL != pTeamId)
    {
        NSLog(@"Team ID =  %@", pTeamId);
    }

    // Get signing_id
    pSigningId = (CFStringRef)CFDictionaryGetValue(pSigningInfo, kSecCodeInfoIdentifier);
    if (NULL != pSigningId)
    {
        NSLog(@"Signing ID =  %@", pSigningId);
    }


Exit:
    // Cleanups
    if (NULL != pAnchor)
    {
        CFRelease(pAnchor);
        pAnchor = NULL;
    }

    if (NULL != pSecRequirement)
    {
        CFRelease(pSecRequirement);
        pSecRequirement = NULL;
    }

    if (NULL != pStatusCFstr)
    {
        CFRelease(pStatusCFstr);
        pStatusCFstr = NULL;
    }

    if (NULL != pStaticCode)
    {
        CFRelease(pStaticCode);
        pStaticCode = NULL;
    }

    // pTeamId and pSigningId are freed when pSigningInfo is freed
    if (NULL != pSigningInfo)
    {
        CFRelease(pSigningInfo);
        pSigningInfo = NULL;
    }

    return;
}

@end
