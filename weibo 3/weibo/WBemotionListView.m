//
//  WBemotionListView.m
//  
//
//  Created by xiong on 15/10/5.
//
//

#import "WBemotionListView.h"
#import "WBemotionPage.h"
#import "UIView+Extension.h"

@interface WBemotionListView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
@implementation WBemotionListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView      = [[UIScrollView alloc] init];
        [self addSubview:self.scrollView];
//        self.scrollView.backgroundColor = [UIColor grayColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate      = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator   = NO;
        
        self.pageControl = [[UIPageControl alloc] init];
//        self.pageControl.backgroundColor = [UIColor blackColor];
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.hidesForSinglePage = YES;
        [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:self.pageControl];
        
    }
    return self;
}
-(void)setEmotion:(NSArray *)emotion{
    _emotion = emotion;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger count = (emotion.count + 20 -1 )/20;
    self.pageControl.numberOfPages = count;
    for (int i = 0; i < count; i++) {
        WBemotionPage *pageview = [[WBemotionPage alloc] init];
//        pageview.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:pageview];
        NSRange range;
        range.location = i * 20;
        
        if (emotion.count - range.location >= 20) {
            range.length = 20;
        }else {
            range.length = emotion.count - range.location;
        }
        pageview.emotions = [emotion subarrayWithRange:range];
    }
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.width  = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0 ;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width  = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    NSUInteger count  = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        WBemotionPage *pageview = self.scrollView.subviews[i];
        pageview.height  = self.scrollView.height;
        pageview.width   = self.scrollView.width;
        pageview.x       = pageview.width * i;
        pageview.y       = 0;
    }
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
    
}
@end
