////////////////////////////////////////////////////////////////////////////////////////////////
//  AOPVirtualObject.m
//  AOPARDemo
//  Purpose: The class helps create a virtual object of geometrical shape
//           pyramid with specified size and position in real world.
//  Created by Arun on 18/02/18.
//  Copyright © 2018 ArtOfProgramming. All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////

#import "AOPVirtualObject.h"

@implementation AOPVirtualObject

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor
{
    self = [super init];
    if (self)
    {
        [self createObjectWithAnchor:anchor];
        
    }
    return self;
}


/**
 The method creates a pyramid shaped geometric structure and
 defines its size and position in real world

 @param anchor - the anchor of node to which the pyramid shape will be added
 */
-(void)createObjectWithAnchor:(ARPlaneAnchor *)anchor
{
    //Create a pyramid shaped node
    SCNPyramid *pyramidDimensions = [SCNPyramid pyramidWithWidth:0.2 height:0.2 length:0.2];
    //Create a mamterial property for the node which defines its color , texture etc.
    SCNMaterial *pyramidMaterial = [SCNMaterial material];
    pyramidMaterial.diffuse.contents = [UIColor redColor];
    pyramidDimensions.firstMaterial = pyramidMaterial;
    
    SCNNode * pyramidNode = [SCNNode nodeWithGeometry:pyramidDimensions];
    //Defining the position of pyramid node w.r.t the coordinates of plane node
    pyramidNode.position = SCNVector3Make(anchor.center.x,anchor.center.y,anchor.center.z);
    [self addChildNode:pyramidNode];
}

@end
