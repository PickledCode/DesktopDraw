#import "Finder.h"

FinderApplication * finderApplication() {
    return [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
}