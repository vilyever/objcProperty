//
//  NSObject+VDProperty.h
//  objcProperty
//
//  Created by Deng on 16/8/5.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDProperty.h"

@interface NSObject (VDProperty)

#pragma mark Constructor


#pragma mark Public Method
+ (NSArray *)vd_properties;
+ (NSArray *)vd_propertiesTraceToAncestorClass:(Class)ancestorClass;
+ (VDProperty *)vd_propertyWithName:(NSString *)propertyName;

#pragma mark Properties


#pragma mark Protected Method


#pragma mark Private Method


@end
