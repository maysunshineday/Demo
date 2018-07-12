//
//  ViewController.m
//  KVODemo
//
//  Created by SnowDream on 2018/5/18.
//  Copyright © 2018年 YingLink. All rights reserved.
//

#import "ViewController.h"
#import "KVOData.h"



@interface ViewController ()

@property (nonatomic, strong) KVOData *data;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

- (IBAction)btn1Pressed:(id)sender;
- (IBAction)btn2Pressed:(id)sender;
- (IBAction)btn3Pressed:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self addObserver:self.data forKeyPath:@"firstNum" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self.data forKeyPath:@"secondNum" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.data addObserver:self forKeyPath:@"firstNum" options:NSKeyValueObservingOptionNew context:nil];
    [self.data addObserver:self forKeyPath:@"secondNum" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.data addObserver:self forKeyPath:@"kvoDic.MulDic.thirdNum" options:NSKeyValueObservingOptionNew context:nil];
}

/*2.实现回调方法*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    NSLog(@"the keyPath is %@", keyPath);
    
    if ([keyPath isEqualToString:@"firstNum"]) {
        //
        self.firstLabel.text = [NSString stringWithFormat:@"%ld", (long)self.data.firstNum.integerValue];
    }
    else if ([keyPath isEqualToString:@"secondNum"]) {
    //
        self.secondLabel.text = [NSString stringWithFormat:@"%ld", (long)self.data.secondNum.integerValue];
    }
    else if ([keyPath isEqualToString:@"kvoDic.MulDic.thirdNum"]) {
    
        NSMutableDictionary *mulDic = [self.data.kvoDic objectForKey:@"MulDic"];
        NSNumber *thirdNum = [mulDic objectForKey:@"thirdNum"];
        NSInteger thirdNumber = thirdNum.integerValue;
        self.thirdLabel.text = [NSString stringWithFormat:@"%ld", thirdNumber];
    }
}

- (KVOData *)data {

    if (!_data) {
        _data = [[KVOData alloc] init];
    }
    
    return _data;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn1Pressed:(id)sender {
    
    NSInteger firstNumber = self.data.firstNum.integerValue;
    firstNumber += 1;
    
    self.data.firstNum = [NSNumber numberWithInteger:firstNumber];
    
//    self.data setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>
}

- (IBAction)btn2Pressed:(id)sender {
    
    NSInteger secondNumber = self.data.secondNum.integerValue;
    secondNumber += 2;
    
    self.data.secondNum = [NSNumber numberWithInteger:secondNumber];
}

- (IBAction)btn3Pressed:(id)sender {
    
    NSMutableDictionary *mulDic = [self.data.kvoDic objectForKey:@"MulDic"];
    NSNumber *thirdNum = [mulDic objectForKey:@"thirdNum"];
    NSInteger thirdNumber = thirdNum.integerValue;
    
    thirdNumber += 3;
    
    [mulDic setObject:@(thirdNumber) forKey:@"thirdNum"];
    
    NSLog(@"the dic is %@", self.data.kvoDic);
}

- (void)dealloc {

    [self.data removeObserver:self forKeyPath:@"firstNum" context:nil];
    [self.data removeObserver:self forKeyPath:@"secondNum" context:nil];
}
@end
