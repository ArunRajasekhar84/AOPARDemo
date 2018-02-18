//////////////////////////////////////////////////////////////////////////////////////////////////////
//  AOPPlane.h
//  AOPARDemo
//  Purpose: Represents a plane node detected in real world. The class constructs
//           a plane node, add geometry to it and define its position in real world.
//           Class also provides interface for updating its size based on refreshed data.
//  Created by Arun on 14/02/18.
//  Copyright © 2018 ArtOfProgramming. All rights reserved.
//////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface AOPPlane : SCNNode

@property (nonatomic,strong) SCNPlane *planeHandler;

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor;
- (void)update:(ARPlaneAnchor *)anchor;

@end
