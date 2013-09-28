//
//  KSActivity+Addons.h
//  KnowSensor X
//
//  Created by David Ganster on 28/09/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSActivity.h"

@interface KSActivity (Addons)

+ (KSActivity *) createOrFetchWithData:(NSDictionary *)data
                             inContext:(NSManagedObjectContext *)context;

@end
