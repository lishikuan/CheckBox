@interface JastorRuntimeHelper : NSObject {
	
}
+ (BOOL)isPropertyReadOnly:(Class)klass propertyName:(NSString*)propertyName;
+ (Class)propertyClassForPropertyName:(NSString *)propertyName ofClass:(Class)klass;


+ (NSString *)propertyTypeForPropertyName:(NSString *)propName ofObject:(NSObject *)object;
+ (NSArray *)propertyNames:(Class)klass;

@end
