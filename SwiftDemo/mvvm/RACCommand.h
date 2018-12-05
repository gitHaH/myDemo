//
//  RACCommand.h
//  SwiftDemo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MGJCommandCompletionBlock)(id error, id content);

// 1
typedef void(^MGJCommandConsumeBlock)(id input, MGJCommandCompletionBlock completionHandler);

// 2
typedef void(^MGJCommandCancelBlock)(void);

@interface MGJCommandResult : NSObject
// 3
@property (nonatomic) NSError *error;
// 4
@property (nonatomic) id content;
@end

@interface RACCommand : NSObject

// 5
@property (nonatomic, readonly) BOOL executing;
// 6
@property (nonatomic, readonly) MGJCommandResult *result;

- (instancetype)initWithConsumeHandler:(MGJCommandConsumeBlock )consumeHandler;
// 7
- (instancetype)initWithConsumeHandler:(MGJCommandConsumeBlock )consumeHandler cancelHandler:(MGJCommandCancelBlock )cancelHandler;

// 8
- (void)execute:(id)input;
// 9
- (void)cancel;
@end
