//
//  KSProject+Addons.h
//  KnowSensor X
//
//  Created by David Ganster on 25/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSProject.h"

@interface KSProject (Addons)

+ (KSProject *) createOrFetchWithData:(NSDictionary *)data
                            inContext:(NSManagedObjectContext *)context;

@end
