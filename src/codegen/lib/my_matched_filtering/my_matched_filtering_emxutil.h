/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: my_matched_filtering_emxutil.h
 *
 * MATLAB Coder version            : 4.3
 * C/C++ source code generated on  : 25-May-2020 19:43:38
 */

#ifndef MY_MATCHED_FILTERING_EMXUTIL_H
#define MY_MATCHED_FILTERING_EMXUTIL_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "my_matched_filtering_types.h"

/* Function Declarations */
extern void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int oldNumel);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_real_T(emxArray_real_T **pEmxArray, int numDimensions);

#endif

/*
 * File trailer for my_matched_filtering_emxutil.h
 *
 * [EOF]
 */
