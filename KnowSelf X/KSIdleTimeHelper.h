//
//  IdleTimeHelper.h
//  KnowSensor X
//
//  Created by David Ganster on 23/02/14.
//  This code was pasted from:
//  http://www.danandcheryl.com/2010/06/how-to-check-the-system-idle-time-using-cocoa .
//  The original author considers it public domain.
//

#ifndef KnowSensor_X_IdleTimeHelper_h
#define KnowSensor_X_IdleTimeHelper_h

#include <IOKit/IOKitLib.h>

/**
 Returns the number of seconds the machine has been idle or -1 if an error occurs.
 The code is compatible with Tiger/10.4 and later (but not iOS).
 */
int64_t SystemIdleTime(void) {
    int64_t idlesecs = -1;
    io_iterator_t iter = 0;
    if (IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IOHIDSystem"), &iter) == KERN_SUCCESS) {
        io_registry_entry_t entry = IOIteratorNext(iter);
        if (entry) {
            CFMutableDictionaryRef dict = NULL;
            if (IORegistryEntryCreateCFProperties(entry, &dict, kCFAllocatorDefault, 0) == KERN_SUCCESS) {
                CFNumberRef obj = CFDictionaryGetValue(dict, CFSTR("HIDIdleTime"));
                if (obj) {
                    int64_t nanoseconds = 0;
                    if (CFNumberGetValue(obj, kCFNumberSInt64Type, &nanoseconds)) {
                        idlesecs = (nanoseconds >> 30); // Divide by 10^9 to convert from nanoseconds to seconds.
                    }
                }
                CFRelease(dict);
            }
            IOObjectRelease(entry);
        }
        IOObjectRelease(iter);
    }
    return idlesecs;
}

#endif
