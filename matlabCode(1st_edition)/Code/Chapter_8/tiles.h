#ifndef _TILES_H_
#define _TILES_H_

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#define MAX_NUM_VARS 20        // Maximum number of variables in a grid-tiling      

void GetTiles(int tiles[],int num_tilings,double variables[], int num_variables, 
	       int memory_size,int hash1=-1, int hash2=-1, int hash3=-1);


#endif
