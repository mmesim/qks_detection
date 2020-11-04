/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_my_matched_filtering_api.h
 *
 * MATLAB Coder version            : 4.3
 * C/C++ source code generated on  : 25-May-2020 19:43:38
 */

#ifndef _CODER_MY_MATCHED_FILTERING_API_H
#define _CODER_MY_MATCHED_FILTERING_API_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void my_matched_filtering(emxArray_real_T *x, emxArray_real_T *y,
  emxArray_real_T *CC);
extern void my_matched_filtering_api(const mxArray * const prhs[2], int32_T nlhs,
  const mxArray *plhs[1]);
extern void my_matched_filtering_atexit(void);
extern void my_matched_filtering_initialize(void);
extern void my_matched_filtering_terminate(void);
extern void my_matched_filtering_xil_shutdown(void);
extern void my_matched_filtering_xil_terminate(void);

#endif

/*
 * File trailer for _coder_my_matched_filtering_api.h
 *
 * [EOF]
 */
