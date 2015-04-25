// Convolution kernel from Heterogeneous Computing with OpenCL
// by Gaster, Howes, Kaeli, Mistry, and Schaa

kernel void copy(
      global float* imageIn,
      global float* imageOut,
    constant float* filter,
               int  rows,
               int  cols,
               int  filterWidth,
       local float* localImage,
               int  localHeight,
               int  localWidth)
{

  // Determine where each workgroup begins reading
  int groupStartCol = get_group_id(0)*get_local_size(0);
  int groupStartRow = get_group_id(1)*get_local_size(1);

  // Determine the local ID of each work-item
  int localCol = get_local_id(0);
  int localRow = get_local_id(1);

  // Determine the global ID of each work-item.  Work-items
  // representing the output region will have a unique global ID
  int globalCol = groupStartCol + localCol;
  int globalRow = groupStartRow + localRow;

  // Copy the data
  if(globalRow < rows && globalCol < cols)
    imageOut[globalRow*cols + globalCol] = imageIn[globalRow*cols + globalCol];

  return;
}

