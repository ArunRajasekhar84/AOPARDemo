//////////////////////////////////////////////////////////////////////////////////////////////////////
//  AOPPlane.m
//  AOPARDemo
//  Purpose: Represents a plane node detected in real world. The class constructs
//           a plane node, add geometry to it and define its position in real world.
//           Class also provides interface for updating its size based on refreshed data.
//  Created by Arun on 14/02/18.
//  Copyright © 2018 ArtOfProgramming. All rights reserved.
//////////////////////////////////////////////////////////////////////////////////////////////////////

#import "AOPPlane.h"

@implementation AOPPlane

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor
{
    self = [super init];
    if (self)
    {
        
        self.planeHandler = [SCNPlane planeWithWidth:anchor.extent.x height:anchor.extent.z];
        SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeHandler];
        
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        
        planeNode.transform = SCNMatrix4MakeRotation(-M_PI / 2.0, 1.0, 0.0, 0.0);
        
        [self addChildNode:planeNode];
        
    }
    return self;
}


/**
 Method to update the size and position of plane when user shifts position

 @param anchor  - the anchor of node to which the plane is added
 */
- (void)update:(ARPlaneAnchor *)anchor {
    // As the user moves around the size of the plane may get changed
    self.planeHandler.width = anchor.extent.x;
    self.planeHandler.height = anchor.extent.z;
    
    // The centre of the plane might also get updated as the size of plane changes
    self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    
}


@end
