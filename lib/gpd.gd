############################################################################# 
## 
#W  gpd.gd                 GAP4 package `groupoids'             Chris Wensley 
#W                                                               & Emma Moore
#Y  Copyright (C) 2000-2018, Emma Moore and Chris Wensley,  
#Y  School of Computer Science, Bangor University, U.K. 
##  

############################################################################# 
##
#O  RootGroup( <gpd> ) 
#A  RaysOfGroupoid( <gpd> ) 
#O  RayArrowsOfGroupoid( <gpd> ) 
#A  GeneratorsOfGroupoid( <gpd> )
## 
##  (03/10/08)  changed these from Attributes to Operations which
##              call the equivalent MagmaWithObjects attributes 
DeclareOperation( "RootGroup", [ IsGroupoid and IsSinglePiece ] ); 
DeclareAttribute( "RaysOfGroupoid", IsGroupoid ); 
DeclareOperation( "RayArrowsOfGroupoid", [ IsGroupoid ] ); 
DeclareAttribute( "GeneratorsOfGroupoid", IsGroupoid );
  
############################################################################## 
## 
#R  IsSinglePieceRaysRep( <gpd> ) 
#T  IsSinglePieceRaysType( <gpd> ) 
#A  LargerDirectProductGroupoid( <gpd> ) 
## 
##  A connected groupoid with variable object groups is a wide subgroupoid 
##  of an IsDirectProductWithCompleteDigraph with the same objects, and is 
##  determined by a root group, and a set of conjugating elements 
## 
DeclareRepresentation( "IsSinglePieceRaysRep",
  IsGroupoid and IsAttributeStoringRep and IsComponentObjectRep, 
  [ "parent", "rootGroup", "rays" ] ); 
BindGlobal( "IsSinglePieceRaysType", 
            NewType( IsGroupoidFamily, IsSinglePieceRaysRep ) );
DeclareAttribute( "LargerDirectProductGroupoid", IsSinglePieceRaysRep ); 
 
############################################################################# 
## 
#P  IsPermGroupoid( <gpd> )                                    
#P  IsFpGroupoid( <gpd> )                                    
#P  IsPcGroupoid( <gpd> )                                    
#P  IsMatrixGroupoid( <gpd> )                                    
#P  IsFreeGroupoid( <gpd> )                                    
## 
DeclareProperty( "IsPermGroupoid", IsGroupoid );  
DeclareProperty( "IsFpGroupoid", IsGroupoid );  
DeclareProperty( "IsPcGroupoid", IsGroupoid );  
DeclareProperty( "IsMatrixGroupoid", IsGroupoid );  
DeclareProperty( "IsFreeGroupoid", IsGroupoid );  
  
############################################################################# 
## 
#F  Groupoid( <args> )              
## 
DeclareGlobalFunction( "Groupoid" );

############################################################################# 
##           
#O  SinglePieceGroupoidNC( <group>, <objects> )              
#O  SinglePieceGroupoid( <group>, <objects> )              
#O  SubgroupoidWithRaysNC( <parent>, <rootgp>, <rays> )
#O  SubgroupoidWithRays( <parent>, <rootgp>, <rays> )
#O  SinglePieceSubgroupoidByGenerators( <ancestor>, <gens> )
## 
DeclareOperation( "SinglePieceGroupoidNC", 
    [ IsGroup, IsHomogeneousList ] ); 
DeclareOperation( "SinglePieceGroupoid", 
    [ IsGroup, IsHomogeneousList ] ); 
DeclareOperation( "SubgroupoidWithRaysNC", 
    [ IsGroupoid, IsGroup, IsHomogeneousList ] );
DeclareOperation( "SubgroupoidWithRays", 
    [ IsGroupoid, IsGroup, IsHomogeneousList ] );
DeclareOperation( "SinglePieceSubgroupoidByGenerators", 
    [ IsGroupoid, IsList ] ); 

############################################################################# 
##                         
#O  ObjectGroup( <gpd>, <obj> )
#A  ObjectGroups( <gpd> )
## 
DeclareOperation( "ObjectGroup", [ IsGroupoid, IsObject ] );    
DeclareAttribute( "ObjectGroups", IsGroupoid );    


## ======================================================================== ##
##                           Homogeneous groupoids                          ##
## ======================================================================== ##

############################################################################## 
## 
#P  IsHomogeneousDiscreteGroupoid( <gpd> ) 
#R  IsHomogeneousDiscreteGroupoidRep( <gpd> ) 
#T  IsHomogeneousDiscreteGroupoidType( <gpd> ) 
## 
##  A homogeneous, discrete groupoid is a union of identical, single domain 
##  groupoids - just the thing for the source of an xmod of groupoids! 
##  So such structures deserve their own representation and type. 
## 
DeclareSynonymAttr( "IsHomogeneousDiscreteGroupoid", IsGroupoid and 
    IsDiscreteDomainWithObjects and IsHomogeneousDomainWithObjects ); 
DeclareRepresentation( "IsHomogeneousDiscreteGroupoidRep",
  IsGroupoid and IsAttributeStoringRep and IsComponentObjectRep, 
  [ "magma", "objects" ] ); 
BindGlobal( "IsHomogeneousDiscreteGroupoidType", 
            NewType( IsGroupoidFamily, 
                     IsHomogeneousDiscreteGroupoidRep and IsGroupoid ) );

############################################################################## 
## 
#O  HomogeneousGroupoid( <gpd>, <obs> ) 
#O  HomogeneousGroupoidNC( <gpd>, <obs> ) 
#O  HomogeneousDiscreteGroupoid( <gp>, <obs> ) 
## 
DeclareOperation( "HomogeneousGroupoid", [ IsGroupoid, IsHomogeneousList ] ); 
DeclareOperation( "HomogeneousGroupoidNC", [ IsGroupoid, IsHomogeneousList ] ); 
DeclareOperation( "HomogeneousDiscreteGroupoid", 
    [ IsGroup, IsHomogeneousList ] ); 

## ======================================================================== ##
##                       Manipulating groupoid unions                       ##
## ======================================================================== ##

############################################################################## 
## 
#O  ReplaceOnePieceInUnion( <union>, <old>, <new> ) 
## 
DeclareOperation( "ReplaceOnePieceInUnion", 
    [ IsGroupoid and IsPiecesRep, IsGroupoid and IsSinglePiece,  
      IsGroupoid and IsSinglePiece ] ); 
DeclareOperation( "ReplaceOnePieceInUnion", 
    [ IsGroupoid and IsPiecesRep, IsPosInt,  
      IsGroupoid and IsSinglePiece ] ); 


## ======================================================================== ##
##                            Groupoid Elements                             ##
## ======================================================================== ##

############################################################################## 
## 
#O  GroupoidElement( <gpd>, <elt>, <src>, <tgt> ) 
#O  IdentityArrow( <gpd>, <obj> )
## 
##  A connected groupoid element is [ group element, tail, head ]
## 
DeclareSynonym( "GroupoidElement", Arrow ); 
DeclareOperation( "IdentityArrow", [ IsGroupoid, IsObject ] ); 

############################################################################## 
## 
##  Stars, Costars and Homsets are particular subsets of the elements
##  of a connected groupoid for which an iterator is required
##  
##  Six items of data are required: 
##  1.  the family of objects of the parent groupoid,    #? why? 
##  2.  a set of group elements, e.g. an object group, 
##  3.  a list of source objects, 
##  4.  a list of target objects, 
##  5.  a list of rays, 
##  6.  a single character string 'c' in {s,c,h,u,r,l,d}, 
##      specifying star; costar; homset; union; right/left/double coset.
##
#P  IsHomsetCosets( <obj> )
#R  IsHomsetCosetsRep( <obj> )
#R  IsHomsetCosetsFamily( <obj> )
#R  IsHomsetCosetsType( <obj> )
#O  ObjectStarNC( <gpd>, <obj> ) 
#O  ObjectStar( <gpd>, <obj> ) 
#O  ObjectCostarNC( <gpd>, <obj> ) 
#O  ObjectCostar( <gpd>, <obj> ) 
#O  HomsetNC( <gpd>, <obj1>, <obj2> ) 
#O  Homset( <gpd>, <obj1>, <obj2> ) 
#A  ElementsOfGroupoid( <gpd> ) 
##
DeclareProperty( "IsHomsetCosets", IsGroupoidElementCollection );
DeclareRepresentation( "IsHomsetCosetsRep", IsHomsetCosets 
    and IsAttributeStoringRep and IsComponentObjectRep, 
    [ "tgroup", "hgroup", "tobj", "hobj", "trays", "hrays", "rep", "type" ] ); 
BindGlobal( "IsHomsetCosetsFamily", 
            NewFamily( "IsHomsetCosetsFamily", IsList ) ); 
BindGlobal( "IsHomsetCosetsType", 
            NewType( CollectionsFamily( IsGroupoidElementFamily ), 
                     IsHomsetCosetsRep ) );
DeclareOperation( "ObjectStarNC", [ IsGroupoid, IsObject ] ); 
DeclareOperation( "ObjectStar", [ IsGroupoid, IsObject ] ); 
DeclareOperation( "ObjectCostarNC", [ IsGroupoid, IsObject ] ); 
DeclareOperation( "ObjectCostar", [ IsGroupoid, IsObject ] ); 
DeclareOperation( "HomsetNC", [ IsGroupoid, IsObject, IsObject ] ); 
DeclareOperation( "Homset", [ IsGroupoid, IsObject, IsObject ] ); 
DeclareAttribute( "ElementsOfGroupoid", IsGroupoid ); 

############################################################################## 
##  
#P  IsGroupoidCoset( <cset> ) 
#A  SuperDomain( <cset> );                          #? rename ?? 
#O  RightCosetRepresentatives( <gpd>, <sgpd> )      #? should be Iterator ?? 
#R  IsLeftCosetWithObjectsDefaultRep( <gp>, <obj> ) 
#O  LeftCosetRepresentatives( <gpd>, <sgpd> )       #? should be Iterator ?? 
#O  LeftCosetRepresentativesFromObject( <gpd>, <sgpd>, <obj> ) 
#O  LeftCosetsNC( <gpd>, <sgpd> ) 
#O  LeftCoset( <gpd>, <sgpd>, <elt> )
#O  DoubleCosetRepresentatives( <gpd>, <sgpd>, <sgpd> )          #? ditto ?? 
## 
DeclareProperty( "IsGroupoidCoset", IsRightCosetDefaultRep ); 
DeclareAttribute( "SuperDomain", IsRightCosetDefaultRep ); 
DeclareCategory( "IsLeftCosetWithObjects", IsDomain and IsExternalOrbit );
DeclareRepresentation( "IsLeftCosetWithObjectsDefaultRep", 
    IsComponentObjectRep and IsAttributeStoringRep 
    and IsLeftCosetWithObjects, [] );
DeclareOperation( "RightCosetRepresentatives", [ IsGroupoid, IsGroupoid ] ); 
DeclareOperation( "LeftCosetRepresentatives", [ IsGroupoid, IsGroupoid ] ); 
DeclareOperation( "LeftCosetRepresentativesFromObject", 
    [ IsGroupoid, IsGroupoid, IsObject ] ); 
DeclareOperation( "LeftCosetsNC", [ IsGroupoid, IsGroupoid ] ); 
DeclareOperation( "LeftCoset", [ IsGroupoid, IsGroupoid, IsGroupoidElement ] ); 
DeclareOperation( "DoubleCosetRepresentatives", 
    [ IsGroupoid, IsGroupoid, IsGroupoid ] ); 


## ======================================================================== ##
##                               Subgroupoids                               ##
## ======================================================================== ##

############################################################################# 
## 
#F  Subgroupoid( <args> )              
#O  IsSubgroupoid( <G>, <S> )
#O  IsWideSubgroupoid( <G>, <S> )                            
## 
DeclareGlobalFunction( "Subgroupoid" );
DeclareOperation( "IsSubgroupoid", [ IsGroupoid, IsGroupoid ] );
DeclareOperation( "IsWideSubgroupoid", [ IsGroupoid, IsGroupoid ] ); 

############################################################################# 
## 
#O  SubgroupoidBySubgroup( <gpd>, <sgp> ) 
#O  SubgroupoidByObjects( <gpd>, <obs> ) 
#O  SubgroupoidByPieces( <gpd>, <obhoms> )              
#O  PiecePositions( <gpd>, <sgpd> )
#O  DiscreteSubgroupoid( <gpd>, <gps>, <obs> )              
#A  MaximalDiscreteSubgroupoid( <gpd> )  
#A  FullTrivialSubgroupoid( <gpd> )  
#A  DiscreteTrivialSubgroupoid( <gpd> )  
## 
DeclareOperation( "SubgroupoidBySubgroup", 
    [ IsGroupoid and IsSinglePiece, IsGroup ] ); 
DeclareOperation( "SubgroupoidByObjects", [ IsGroupoid, IsHomogeneousList ] );
DeclareSynonym( "FullSubgroupoid", SubgroupoidByObjects ); 
DeclareOperation( "SubgroupoidByPieces",
    [ IsGroupoid, IsList ] );
##  DeclareOperation( "PiecePositions", [ IsGroupoid, IsGroupoid ] );
DeclareOperation( "DiscreteSubgroupoid",
    [ IsGroupoid, IsList, IsHomogeneousList ] );
DeclareAttribute( "MaximalDiscreteSubgroupoid", IsGroupoid );
DeclareAttribute( "FullTrivialSubgroupoid", IsGroupoid );
DeclareAttribute( "DiscreteTrivialSubgroupoid", IsGroupoid );

#############################################################################
##
#O  ConjugateGroupoid( <gpd>, <elt> ) . . . . . . conjugate of <gpd> by <elt>
##
DeclareOperation( "ConjugateGroupoid", [ IsGroupoid, IsGroupoidElement ] );

############################################################################# 
## 
#O  NormalSubgroupoid( <G>, <S> )              
#O  IsNormalSubgroupoid( <G>, <S> )
## 
DeclareOperation( "NormalSubgroupoid", [ IsGroupoid, IsGroupoid ] );
DeclareOperation( "IsNormalSubgroupoid", [ IsGroupoid, IsGroupoid ] );

############################################################################## 
## 
#E  gpd.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here 
## 
