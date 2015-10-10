
#ifndef Wikipedia_Global_h
#define Wikipedia_Global_h

#import "WMFLogging.h"
#import "WMFGCDHelpers.h"
#import "WMFMath.h"
#import "NSError+WMFExtensions.h"
#import "NSObjectUtilities.h"
#import "WMFOutParamUtils.h"
#import "UIColor+WMFStyle.h"

@import libextobjc;
@import KVOController;
@import BlocksKit;

// Need to import it this way since umbrella header doesn't have AnyPromise declarations
#import <PromiseKit/PromiseKit.h>

#import "WMFBlockDefinitions.h"
#import "WMFComparison.h"

#import "WMFArticlePresenter.h"

static inline NSString* localizedStringForKeyFallingBackOnEnglish(NSString* key){
    NSString* outStr = NSLocalizedString(key, nil);
    if (![outStr isEqualToString:key]) {
        return outStr;
    }

    static NSBundle* englishBundle = nil;

    if (!englishBundle) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        englishBundle = [NSBundle bundleWithPath:path];
    }
    return [englishBundle localizedStringForKey:key value:@"" table:nil];
}

#define MWLocalizedString(key, throwaway) localizedStringForKeyFallingBackOnEnglish(key)

// Need to do this here since we're only including Tweaks in certain configurations
#ifndef FB_TWEAK_ENABLED
    #if NDEBUG
        #define FB_TWEAK_ENABLED 0
    #else
        #define FB_TWEAK_ENABLED 1
    #endif
#endif

#ifndef PIWIK_ENABLED
    #if NDEBUG
        #define PIWIK_ENABLED 0
    #else
        #define PIWIK_ENABLED 1
    #endif
#endif

#endif
