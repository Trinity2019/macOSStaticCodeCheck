//
//  checkStaticCSInfo.h
//  checkCSInfoObserveCPU
//
//  Created by Yamin Tian on 5/25/21.
//

#ifndef checkCSInfo_h
#define checkCSInfo_h

@interface checkStaticCSInfo : NSObject

/**
 * @brief Check validity and reads static codesign information of the code object specified by
 *        a file system path.
 *
 * @param[in] path a file system path
 * @param[in] requirement the text string form of a code requirement. Such as: "anchor trusted"
 */

- (void)checkStaticCSInfoOnPath:(NSString *)path withRequirement:(const char *)requirement;

@end

#endif /* checkStaticCSInfo_h */
