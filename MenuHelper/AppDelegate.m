#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.button.title = @"📆";
    self.statusItem.menu = [[NSMenu alloc] init];
    [self.statusItem.menu addItemWithTitle:@"Insert Date" action:@selector(insertDate:) keyEquivalent:@""];
    [self.statusItem.menu addItem:[NSMenuItem separatorItem]];  // separator
    [self.statusItem.menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
}

- (void)insertDate:(id)sender {
    // Logic for inserting the current date where the cursor is located.
    // 1. Get the current date as a string
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
        
        // 2. Copy to clipboard
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
        [pasteboard setString:currentDate forType:NSStringPboardType];
        
        // 3. Simulate a 'paste' command
        // You need to ensure your app has accessibility permissions to simulate key presses.
        CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
        CGEventRef pasteKeyDown = CGEventCreateKeyboardEvent(source, (CGKeyCode)9, YES); // 'v' key down
        CGEventRef pasteKeyUp = CGEventCreateKeyboardEvent(source, (CGKeyCode)9, NO);   // 'v' key up
        CGEventSetFlags(pasteKeyDown, kCGEventFlagMaskCommand); // Add Command key flag to the event (Command + v)
        CGEventSetFlags(pasteKeyUp, kCGEventFlagMaskCommand);   // Add Command key flag to the event (Command + v)
        CGEventPost(kCGHIDEventTap, pasteKeyDown);
        CGEventPost(kCGHIDEventTap, pasteKeyUp);
        CFRelease(pasteKeyUp);
        CFRelease(pasteKeyDown);
        CFRelease(source);
    
}

@end
