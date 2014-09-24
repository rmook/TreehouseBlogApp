#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
   
   NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
   
   NSError *error = nil;
   
   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
   
   self.blogposts = [NSMutableArray array];
   
   NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];

   for (NSDictionary *bpDictionary in blogPostsArray) {
      BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
      blogPost.author =[bpDictionary objectForKey:@"author"];
      blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
      blogPost.date = [bpDictionary objectForKey:@"date"];
      blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
      [self.blogposts addObject:blogPost];
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.blogposts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
   BlogPost *blogpost = [self.blogposts objectAtIndex:indexPath.row];
   
   if ( [blogpost.thumbnail isKindOfClass:[NSString class]]) {
   NSData *imageData = [NSData dataWithContentsOfURL:blogpost.thumbnailURL];
   UIImage *image = [UIImage imageWithData:imageData];
   
   cell.imageView.image = image;
   
   } else {
      cell.imageView.image = [UIImage imageNamed:@"treehouse.png"];
   }
   cell.textLabel.text = blogpost.title;
   cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",blogpost.author, [blogpost formattedDate]];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([segue.identifier isEqualToString:@"showBlogPost"]) {
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      BlogPost *blogpost = [self.blogposts objectAtIndex:indexPath.row];
      [segue.destinationViewController setBlogPostURL:blogpost.url];
   }
}
@end
