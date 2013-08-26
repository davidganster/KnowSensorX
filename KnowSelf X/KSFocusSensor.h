//
//  KSFocusSensor.h
//  KnowSensor X
//
//  Created by David Ganster on 15/08/13.
//  Copyright (c) 2013 David Ganster. All rights reserved.
//

#import "KSSensor.h"

/** This class catches and handles all "focus-change" events.
 * It generates events when an application gets and loses the focus, and hands it to its delegate.
 * @author David Ganster
 */
@interface KSFocusSensor : KSSensor

@end
