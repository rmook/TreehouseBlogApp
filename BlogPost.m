#import "BlogPost.h"

@implementation BlogPost

- (id) initWithTitle:(NSString *)title {
   self = [super init];
   if ( self ) {
      self.title = title;
      self.author = nil;
      self.thumbnail = nil;
   }
   return self;
}

+ (id) blogPostWithTitle:(NSString *)title {
   return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
   return [NSURL URLWithString:self.thumbnail];
}

- (NSString *) formattedDate {
//
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 // specify the format of the date property (string)
   [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 // parse this into a date object
   NSDate *tempDate = [dateFormatter dateFromString:self.date];
  // create a new format for the date
   [dateFormatter setDateFormat:@"EE MMM,dd"];
  // return that date as a string
   return [dateFormatter stringFromDate:tempDate];
}

@end
