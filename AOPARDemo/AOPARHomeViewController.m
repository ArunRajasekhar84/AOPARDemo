//////////////////////////////////////////////////////////////////////////////////////////////////////
//  AOPARHomeViewController.m
//  AOPARDemo
//  Purpose: The home view for displaying the scene view which captures
//           planes in real world and places virtual object on top of it
//  Created by Arun on 11/02/18.
//  Copyright © 2018 ArtOfProgramming. All rights reserved.
//////////////////////////////////////////////////////////////////////////////////////////////////////

#import "AOPARHomeViewController.h"
#import "AOPPlane.h"
#import "AOPVirtualObject.h"

@interface AOPARHomeViewController () <ARSCNViewDelegate,UIGestureRecognizerDelegate>
//Create an outlet to Scene view in storyboard
@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;
//Miantain a list of plane nodes that will be detected by ARKit
@property (nonatomic,strong) NSMutableDictionary *planesList;

@end

    
@implementation AOPARHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create a new scene and assign it to the scene view
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
    self.sceneView.delegate = self;
    //We are enabling default lighting for the scene. This can be replaced with
    //custom light nodes and adding it to the scenes.
    self.sceneView.autoenablesDefaultLighting = YES;
    //Create a dictionary for maintaing the list of planes created, which we shall
    // be using later for updating its perimeter
    self.planesList = [NSMutableDictionary new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create an AR session configuration.
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    // Let us enable plane detection since we want to place a virtual object on a plane detected
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate


//// Override to create and configure nodes for anchors added to the view's session.
//- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//    
//    
//}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    //Lets create a plane node for the new plane detected.
    AOPPlane *plane = [[AOPPlane alloc] initWithAnchor: (ARPlaneAnchor *)anchor];
    //We are redcing the opacity of plane so that user gets a better view of real world beneath the plane
    plane.opacity = 0.25;
    //Add the plane node as a child node
    [node addChildNode:plane];
    [self.planesList setObject:plane forKey:anchor.identifier];
    //Now we shall create a virtual object to placed on top of the detected
    //plane. create a new node for the virtual object which is Pyramid in our case
    AOPVirtualObject *virtualObject = [[AOPVirtualObject alloc] initWithAnchor:(ARPlaneAnchor *)anchor];
    //Add the pyramid node as a child node
    [node addChildNode:virtualObject];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    //Retrieve the instance of plane node detected earlier
    AOPPlane *plane = [self.planesList objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }
    //Let us update the plane for which we have received refreshed data
    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}



@end
