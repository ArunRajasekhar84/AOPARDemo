////////////////////////////////////////////////////////////////////////////////////////////////
//  AOPVirtualObject.h
//  AOPARDemo
//  Purpose: The class helps create a virtual object of geometrical shape
//           pyramid with specified size and position in real world.
//  Created by Arun on 18/02/18.
//  Copyright © 2018 ArtOfProgramming. All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface AOPVirtualObject : SCNNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor;

@end
