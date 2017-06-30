// Custom ModularCC Button source code (Works with ModularCC 0.10~BETA and later)
// Created by www.twitter.com/SparkDev_
// - Spark 2017

@interface CCUIControlCenterViewController : UIViewController
	-(void) viewDidLoad;
	-(void) addCustomModularCCModule:(UIView*)module;
@end

@interface customModularModule : UIView
	-(void) configure;
	-(void)setDefaultStyle;
@end

%hook CCUIControlCenterViewController
	// We hook here to load the buttons
	- (void)viewDidLoad{
		%orig; // THIS MUST BE HERE, OR THE TWEAK WILL NOT WORK. (In fact, the entire Control Center wont work.)

		// Initialise your custom module with a default position and size (Just like you would a UIView)
		customModularModule* customButton = [[customModularModule alloc] initWithFrame:CGRectMake(100,100,150,150)];
		[customButton configure]; // Call the configure method (See below to customise)

		[self addCustomModularCCModule:customButton]; // Call the method in ModularCC to add the button

		// That's it!
	}
%end

@implementation customModularModule
	// Make your module here!
	-(void)configure{
		// This method will add a background and rounded corners to match the other buttons in ModularCC.
		[self setDefaultStyle];

		// Important! This must be set, otherwise your module will not work.
		// The identifier must be unique to any other modules in ModularCC or
		// conflicts will occur in positioning.
		self.accessibilityLabel = @"SampleButton";

		// Now you can do anything you want!
		// For this example, I will add a simple UILabel
		UILabel* sampleLabel = [[UILabel alloc] initWithFrame: self.bounds];
		sampleLabel.text = @"Sample Module";
		sampleLabel.textAlignment = NSTextAlignmentCenter;
		sampleLabel.textColor = [UIColor whiteColor];
		[self addSubview: sampleLabel];
	}

	-(void)setDefaultStyle{
		UIBlurEffect *darkBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		UIVisualEffectView *darkBlurEffect = [[UIVisualEffectView alloc] initWithEffect:darkBlur];
    	darkBlurEffect.frame = self.bounds;
    	darkBlurEffect.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview: darkBlurEffect];
		[self sendSubviewToBack: darkBlurEffect];
		self.layer.cornerRadius = 15;
		self.layer.masksToBounds = TRUE;
	}
@end