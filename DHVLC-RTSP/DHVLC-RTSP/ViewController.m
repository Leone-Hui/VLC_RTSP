//
//  ViewController.m
//  DHVLC-RTSP
//
//  Created by 惠大河 on 2019/3/21.
//  Copyright © 2019 惠大河. All rights reserved.
//

#import "ViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>
@interface ViewController ()<VLCMediaDelegate>

@property(nonatomic,strong)UIView * videoView;
@property(nonatomic,strong)VLCMediaPlayer * player;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /* setup the media player instance, give it a delegate and something to draw into */

    [self.view addSubview:self.videoView];
    
    [self.player play];
}

-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
        _videoView.backgroundColor = [UIColor blackColor];
    }
    return _videoView;
}
-(VLCMediaPlayer *)player{
    if (!_player) {
        //缓存策略设置
        NSDictionary * dict=@{@"network-caching":@"100"};
        VLCMedia * media=[VLCMedia mediaWithURL:[NSURL URLWithString:@"rtsp://admin:qzyey1234@123.161.208.52:554/cam/realmonitor?channel=1&subtype=0"]];
        media.delegate = self;
        [media addOptions:dict];
        _player = [[VLCMediaPlayer alloc] init];
        //设置硬件解码
        [_player setDeinterlaceFilter:@"blend"];
        _player.media=media;
        _player.drawable = self.videoView;
        _player.media.delegate=self;
    }
    
    return _player;
}

@end
