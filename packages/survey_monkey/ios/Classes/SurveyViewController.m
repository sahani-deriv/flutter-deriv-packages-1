#import <Foundation/Foundation.h>
#import "SurveyViewController.h"
#import <SurveyMonkeyiOSSDK/SurveyMonkeyiOSSDK.h>
#import <UIKit/UIKit.h>
#import "SurveyMonkeyPlugin.h"

@interface SurveyViewController () <SMFeedbackDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) SMFeedbackViewController * feedbackController;
@end

@implementation SurveyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _feedbackController = [[SMFeedbackViewController alloc] initWithSurvey: _surveyHash];
    _feedbackController.delegate = self;
    _feedbackController.modalPresentationStyle = UIModalPresentationCustom;
    if (@available(iOS 13.0, *)) {
        _feedbackController.modalInPresentation = TRUE;
    }
    [_feedbackController presentFromViewController: self animated: TRUE completion: nil];
}

- (void)respondentDidEndSurvey:(SMRespondent *)respondent error:(NSError *) error {
    
    if (respondent != NULL) {
        
        NSString * status = @"completed";
        NSString * respondentId = respondent.respondentID;
        
        NSDictionary *myData = @{@"status": status, @"respondentId": respondentId, @"description": @""};
        [[NSNotificationCenter defaultCenter] postNotificationName: @"survey-monkey-status" object: nil userInfo: myData];
    } else if (error != NULL) {
        NSDictionary * myData = @{@"status": @"incomplete", @"respondentId": @"",  @"description": error.localizedDescription};
        [[NSNotificationCenter defaultCenter] postNotificationName: @"survey-monkey-status" object: nil userInfo: myData];
    }
    
}


@end
