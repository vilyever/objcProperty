//
//  VDProperty.m
//  objcProperty
//
//  Created by Deng on 16/8/5.
//  Copyright © Deng. All rights reserved.
//

#import "VDProperty.h"

#import <objc/runtime.h>


VDPropertyPrimitiveType const VDPropertyPrimitiveTypes[] = {
    VDPropertyPrimitiveTypeIntOrSignedOrEnumOrNSInteger,
    VDPropertyPrimitiveTypeUnsignedIntOrNSUinteger,
    VDPropertyPrimitiveTypeShort,
    VDPropertyPrimitiveTypeUnsignedShort,
    VDPropertyPrimitiveTypeLong,
    VDPropertyPrimitiveTypeUnsignedLong,
    VDPropertyPrimitiveTypeLongLong,
    VDPropertyPrimitiveTypeUnsignedLongLong,
    VDPropertyPrimitiveTypeCharOrBOOL,
    VDPropertyPrimitiveTypeUnsignedChar,
    VDPropertyPrimitiveTypeFloat,
    VDPropertyPrimitiveTypeDouble,
    VDPropertyPrimitiveTypeLongDouble,
    VDPropertyPrimitiveTypeBlock,
    VDPropertyPrimitiveTypeVoidPointer,
    VDPropertyPrimitiveTypeID,
    VDPropertyPrimitiveTypeSEL,
    VDPropertyPrimitiveTypeClass,
    VDPropertyPrimitiveTypeStruct,
    VDPropertyPrimitiveTypeUnion
};

NSInteger const VDPropertyPrimitiveTypesLength = 20;

NSString * const VDPropertyPrimitiveTypeName(VDPropertyPrimitiveType e) {
    switch (e) {
        case VDPropertyPrimitiveTypeIntOrSignedOrEnumOrNSInteger: return @"int/signed/enum/NSInteger";
        case VDPropertyPrimitiveTypeUnsignedIntOrNSUinteger: return @"unsigned int/NSUInteger";
        case VDPropertyPrimitiveTypeShort: return @"short";
        case VDPropertyPrimitiveTypeUnsignedShort: return @"unsigned short";
        case VDPropertyPrimitiveTypeLong: return @"long";
        case VDPropertyPrimitiveTypeUnsignedLong: return @"unsigned long";
        case VDPropertyPrimitiveTypeLongLong: return @"long long";
        case VDPropertyPrimitiveTypeUnsignedLongLong: return @"unsigned long long";
        case VDPropertyPrimitiveTypeCharOrBOOL: return @"char/BOOL";
        case VDPropertyPrimitiveTypeUnsignedChar: return @"unsigned char";
        case VDPropertyPrimitiveTypeFloat: return @"float";
        case VDPropertyPrimitiveTypeDouble: return @"double";
        case VDPropertyPrimitiveTypeLongDouble: return @"long double";
        case VDPropertyPrimitiveTypeBlock: return @"block";
        case VDPropertyPrimitiveTypeVoidPointer: return @"void";
        case VDPropertyPrimitiveTypeID: return @"id";
        case VDPropertyPrimitiveTypeSEL: return @"SEL";
        case VDPropertyPrimitiveTypeClass: return @"Class";
        case VDPropertyPrimitiveTypeStruct: return @"struct";
        case VDPropertyPrimitiveTypeUnion: return @"union";
        default: return @"";
    }
}

NSString * const VDPropertyPrimitiveTypeAttribute(VDPropertyPrimitiveType e) {
    switch (e) {
        case VDPropertyPrimitiveTypeIntOrSignedOrEnumOrNSInteger: return @"i";
        case VDPropertyPrimitiveTypeUnsignedIntOrNSUinteger: return @"I";
        case VDPropertyPrimitiveTypeShort: return @"s";
        case VDPropertyPrimitiveTypeUnsignedShort: return @"S";
        case VDPropertyPrimitiveTypeLong: return @"l";
        case VDPropertyPrimitiveTypeUnsignedLong: return @"L";
        case VDPropertyPrimitiveTypeLongLong: return @"q";
        case VDPropertyPrimitiveTypeUnsignedLongLong: return @"Q";
        case VDPropertyPrimitiveTypeCharOrBOOL: return @"c";
        case VDPropertyPrimitiveTypeUnsignedChar: return @"C";
        case VDPropertyPrimitiveTypeFloat: return @"f";
        case VDPropertyPrimitiveTypeDouble: return @"d";
        case VDPropertyPrimitiveTypeLongDouble: return @"D";
        case VDPropertyPrimitiveTypeBlock: return @"@?";
        case VDPropertyPrimitiveTypeVoidPointer: return @"v";
        case VDPropertyPrimitiveTypeID: return @"@";
        case VDPropertyPrimitiveTypeSEL: return @":";
        case VDPropertyPrimitiveTypeClass: return @"#";
        case VDPropertyPrimitiveTypeStruct: return @"struct"; // just set a value for dictionary's key
        case VDPropertyPrimitiveTypeUnion: return @"union"; // just set a value for dictionary's key
        default: return @"";
    }
}

NSString * const PropertyAttributeItemSeparator = @",";

NSString * const PropertyAttributeTypePrefix = @"T";
NSString * const PropertyAttributePointer = @"^";
NSString * const PropertyAttributeObjCTypePrefix = @"@\"";
NSString * const PropertyAttributeObjCTypeSuffix = @"\"<"; // < for protocol
NSString * const PropertyAttributeMutablePrefix = @"Mutable";

NSString * const PropertyAttributeReadonly = @"R";

NSString * const PropertyAttributeStrongOrRetain = @"&";
NSString * const PropertyAttributeCopy = @"C";
NSString * const PropertyAttributeWeak = @"W";

NSString * const PropertyAttributeDynamic = @"D";

NSString * const PropertyAttributeNonatomic = @"N";

NSString * const PropertyAttributeGetterPrefix = @"G";
NSString * const PropertyAttributeSetterPrefix = @"S";

NSString * const PropertyProtocolPrefix = @"<";
NSString * const PropertyProtocolSuffix = @">";

NSString * const PropertyStructPrefix = @"{";
NSString * const PropertyStructSuffix = @"}";

NSString * const PropertyUnionPrefix = @"(";
NSString * const PropertyUnionSuffix = @")";


@interface VDProperty ()

- (void)__i__initVDProperty;

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, strong, readwrite) Class type;
@property (nonatomic, copy, readwrite) NSString *typeName;
@property (nonatomic, assign, readwrite) VDPropertyPrimitiveType primitiveType;

/** 所属类,声明此property的类 */
@property (nonatomic, strong, readwrite) Class ownerClass;

/** 若为Struct */
@property (nonatomic, copy, readwrite) NSString *structName;

/** 若为Union */
@property (nonatomic, copy, readwrite) NSString *unionName;

/** 所有的protocol Name */
@property (nonatomic, strong, readwrite) NSArray *protocols;

@property (nonatomic, assign, readwrite) BOOL isIgnore;
@property (nonatomic, assign, readwrite) BOOL isReadonly;
@property (nonatomic, assign, readwrite) BOOL isStrong; // or retain
@property (nonatomic, assign, readwrite) BOOL isWeak;
@property (nonatomic, assign, readwrite) BOOL isCopy;
@property (nonatomic, assign, readwrite) BOOL isAssign;
@property (nonatomic, assign, readwrite) BOOL isDynamic;
@property (nonatomic, assign, readwrite) BOOL isNonatomic;
@property (nonatomic, assign, readwrite) BOOL isPrimitive;
@property (nonatomic, assign, readwrite) BOOL isID;
@property (nonatomic, assign, readwrite) BOOL isSEL;
@property (nonatomic, assign, readwrite) BOOL isMutable;
@property (nonatomic, assign, readwrite) BOOL isStruct;
@property (nonatomic, assign, readwrite) BOOL isUnion;
@property (nonatomic, assign, readwrite) BOOL isPointer;

@property (nonatomic, assign, readwrite) VDPropertyAccessorType getterType;
@property (nonatomic, copy, readwrite) NSString *getterSelectorName;

@property (nonatomic, assign, readwrite) VDPropertyAccessorType setterType;
@property (nonatomic, copy, readwrite) NSString *setterSelectorName;

@end


@implementation VDProperty

#pragma mark Constructor
+ (NSArray *)propertiesWithClass:(Class)objClass {
    return [self propertiesWithClass:objClass traceToAncestorClass:objClass];
}

+ (NSArray *)propertiesWithClass:(Class)objClass traceToAncestorClass:(__unsafe_unretained Class)ancestorClass {
    if (!ancestorClass
        || ![objClass isSubclassOfClass:ancestorClass]) {
        ancestorClass = objClass;
    }
    
    NSMutableArray *propertyInstances = [ [NSMutableArray alloc] init];
    
    Class class = objClass;
    NSScanner *scanner = nil;
    NSString *propertyType = nil;
    
    // 抓取所有property，包括当前类到ancestorClass的所有父类
    while (class != [ancestorClass superclass] ) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        NSInteger currentIndex = 0;
        
        for (unsigned int i = 0; i < propertyCount; i++) {
            VDProperty *propertyInstance = [ [VDProperty alloc] init];
            propertyInstance.ownerClass = class;
            
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            propertyInstance.name = @(propertyName);
            
            // 获取属性
            const char *attrs = property_getAttributes(property);
            NSString *propertyAttributes = @(attrs);
            NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:PropertyAttributeItemSeparator];
            
            propertyInstance.isReadonly = [attributeItems containsObject:PropertyAttributeReadonly];
            
            propertyInstance.isStrong = [attributeItems containsObject:PropertyAttributeStrongOrRetain];
            propertyInstance.isWeak = [attributeItems containsObject:PropertyAttributeWeak];
            propertyInstance.isCopy = [attributeItems containsObject:PropertyAttributeCopy];
            
            propertyInstance.isDynamic = [attributeItems containsObject:PropertyAttributeDynamic];
            
            propertyInstance.isNonatomic = [attributeItems containsObject:PropertyAttributeNonatomic];
            
            for (NSString *subAttribute in attributeItems) {
                if ([[subAttribute substringToIndex:1] isEqualToString:PropertyAttributeGetterPrefix]) {
                    propertyInstance.getterType = VDPropertyAccessorTypeCustom;
                    propertyInstance.getterSelectorName = [subAttribute substringFromIndex:1];
                }
                else if ([[subAttribute substringToIndex:1] isEqualToString:PropertyAttributeSetterPrefix]) {
                    propertyInstance.setterType = VDPropertyAccessorTypeCustom;
                    propertyInstance.setterSelectorName = [subAttribute substringFromIndex:1];
                }
            }
            
            scanner = [NSScanner scannerWithString:propertyAttributes];
            [scanner scanUpToString:PropertyAttributeTypePrefix intoString: nil];
            [scanner scanString:PropertyAttributeTypePrefix intoString:nil];
            
            if ([scanner scanString:PropertyAttributeObjCTypePrefix intoString:&propertyType]) { // id 或 Obj-C类型
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:PropertyAttributeObjCTypeSuffix]
                                        intoString:&propertyType];
                if ([propertyType isEqualToString:PropertyAttributeObjCTypePrefix]) {
                    propertyInstance.isID = YES;
                    propertyInstance.isPrimitive = YES;
                    propertyInstance.primitiveType = VDPropertyPrimitiveTypeID;
                    propertyInstance.typeName = VDPropertyPrimitiveTypeName(VDPropertyPrimitiveTypeID);
                }
                else {
                    propertyInstance.type = NSClassFromString(propertyType);
                    propertyInstance.typeName = propertyType;
                    propertyInstance.isPointer = YES;
                    propertyInstance.isMutable = ([propertyType rangeOfString:PropertyAttributeMutablePrefix].location != NSNotFound);
                }
                
                // 获取protocol
                NSMutableArray *protocols = [NSMutableArray new];
                while ([scanner scanString:PropertyProtocolPrefix intoString:NULL] ) {
                    NSString *protocolName = nil;
                    [scanner scanUpToString:PropertyProtocolSuffix intoString: &protocolName];
                    [protocols addObject:protocolName];
                    if ([protocolName isEqualToString:NSStringFromProtocol(@protocol(VDPropertyIgnore))]) {
                        propertyInstance.isIgnore = YES;
                    }
                    [scanner scanString:PropertyProtocolSuffix intoString:NULL];
                }
                
                propertyInstance.protocols = [NSArray arrayWithArray:protocols];
                
            }
            else if ([scanner scanString:PropertyStructPrefix intoString: &propertyType]) { // Struct
                [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                    intoString:&propertyType];
                propertyInstance.isStruct = YES;
                propertyInstance.isPrimitive = YES;
                propertyInstance.primitiveType = VDPropertyPrimitiveTypeStruct;
                propertyInstance.structName = propertyType;
                propertyInstance.typeName = VDPropertyPrimitiveTypeName(VDPropertyPrimitiveTypeStruct);
            }
            else if ([scanner scanString:PropertyUnionPrefix intoString: &propertyType]) { // Union
                [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                    intoString:&propertyType];
                propertyInstance.isUnion = YES;
                propertyInstance.isPrimitive = YES;
                propertyInstance.primitiveType = VDPropertyPrimitiveTypeUnion;
                propertyInstance.unionName = propertyType;
                propertyInstance.typeName = VDPropertyPrimitiveTypeName(VDPropertyPrimitiveTypeUnion);
            }
            else { // primitive
                NSMutableDictionary *propertyAttributePrimitives = [NSMutableDictionary new];
                for (int i = 0; i < (sizeof(VDPropertyPrimitiveTypes) / sizeof(VDPropertyPrimitiveType)); i++) {
                    VDPropertyPrimitiveType primitiveType = VDPropertyPrimitiveTypes[i];
                    [propertyAttributePrimitives setObject:VDPropertyPrimitiveTypeName(primitiveType) forKey:VDPropertyPrimitiveTypeAttribute(primitiveType)];
                }
                
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                        intoString:&propertyType];
                
                if ([propertyType containsString:PropertyAttributePointer]) {
                    propertyInstance.isPointer = YES;
                    propertyType = [propertyType stringByReplacingOccurrencesOfString:PropertyAttributePointer withString:@""];
                }
                
                propertyInstance.isPrimitive = YES;
                propertyInstance.typeName = propertyAttributePrimitives[propertyType];
                propertyInstance.primitiveType = [propertyAttributePrimitives[propertyType] integerValue];
            }
            
            [propertyInstances insertObject:propertyInstance atIndex:currentIndex];
            currentIndex++;
        }
        
        free(properties);
        class = [class superclass];
    }
    
    return [NSArray arrayWithArray:propertyInstances];
}

#pragma mark Public Method


#pragma mark Properties
- (BOOL)isAssign {
    return !self.isStrong && !self.isWeak && !self.isCopy;
}

- (NSString *)setterSelectorName {
    if (!_setterSelectorName
        && self.setterType == VDPropertyAccessorTypeOriginal) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        NSString *firstChar = [self.name substringToIndex:1];
        NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
        NSString *result = [NSString stringWithFormat:@"%@%@", [folded uppercaseString], [self.name substringFromIndex:1]];
        _setterSelectorName = [NSString stringWithFormat:@"set%@:", result];
    }
    
    return _setterSelectorName;
}

- (NSString *)getterSelectorName {
    if (!_getterSelectorName
        && self.getterType == VDPropertyAccessorTypeOriginal) {
        _getterSelectorName = self.name;
    }
    
    return _getterSelectorName;
}

#pragma mark Overrides
- (instancetype)init {
    self = [super init];
    
    // Initialization code
    [self __i__initVDProperty];

    return self;
}

- (void)dealloc {
    
}

- (NSString *)description
{
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:13];
    
    if (self.isIgnore) [attributes addObject:@"Ignore"];
    if (self.isNonatomic) [attributes addObject:@"nonatomic"];
    if (self.isStrong) [attributes addObject:@"strong"];
    if (self.isWeak) [attributes addObject:@"weak"];
    if (self.isCopy) [attributes addObject:@"copy"];
    if (self.isAssign) [attributes addObject:@"assign"];
    if (self.isReadonly) [attributes addObject:@"readonly"];
    if (self.isDynamic) [attributes addObject:@"dynamic"];
    //    if (self.isPrimitive) [attributes addObject:@"primitive"];
    //    if (self.isMutable) [attributes addObject:@"mutable"];
    //    if (self.isStruct) [attributes addObject:@"struct"];
    if (self.setterType == VDPropertyAccessorTypeCustom) [attributes addObject:[NSString stringWithFormat: @"setter=%@", self.setterSelectorName]];
    if (self.getterType == VDPropertyAccessorTypeCustom) [attributes addObject:[NSString stringWithFormat: @"getter=%@", self.getterSelectorName]];
    
    NSString *attributesString = @"";
    if (attributes.count > 0) attributesString = [NSString stringWithFormat:@"(%@)", [attributes componentsJoinedByString:@", "]];
    
    NSString *typeString = [NSString stringWithFormat:@"%@", self.typeName];
    if (self.structName) typeString = self.structName;
    if (self.unionName) typeString = self.unionName;
    
    NSString *protocolSting = @"";
    if (self.protocols.count > 0) protocolSting = [NSString stringWithFormat:@"<%@>", [self.protocols componentsJoinedByString:@","]];
    
    return [NSString stringWithFormat:@"<%@> @property %@ %@%@ %@%@", self.ownerClass, attributesString, typeString, protocolSting, self.isPointer ? @"*" : @"", self.name];
}


#pragma mark Delegates


#pragma mark Protected Method


#pragma mark Private Method
- (void)__i__initVDProperty {
    
}

@end
