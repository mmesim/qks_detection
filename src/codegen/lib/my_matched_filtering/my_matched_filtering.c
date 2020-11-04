/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: my_matched_filtering.c
 *
 * MATLAB Coder version            : 4.3
 * C/C++ source code generated on  : 25-May-2020 19:43:38
 */

/* Include Files */
#include "my_matched_filtering.h"
#include "my_matched_filtering_emxutil.h"
#include <math.h>

/* Function Definitions */

/*
 * Function to calculate a naive Pearson Coefficient
 * In the time domain
 * Arguments    : const emxArray_real_T *x
 *                const emxArray_real_T *y
 *                emxArray_real_T *CC
 * Return Type  : void
 */
void my_matched_filtering(const emxArray_real_T *x, const emxArray_real_T *y,
  emxArray_real_T *CC)
{
  int varargin_1;
  int vlen;
  double b_y;
  int k;
  emxArray_real_T *ynew;
  int i;
  emxArray_real_T *b_x;
  double denom2;
  emxArray_real_T *temp;
  int b_i;
  unsigned int u;
  int i1;
  int i2;
  int i3;
  double c_y;
  varargin_1 = y->size[0];

  /* length template */
  /* length station data */
  vlen = y->size[0];
  if (y->size[0] == 0) {
    b_y = 0.0;
  } else {
    b_y = y->data[0];
    for (k = 2; k <= vlen; k++) {
      b_y += y->data[k - 1];
    }
  }

  emxInit_real_T(&ynew, 1);
  b_y /= (double)y->size[0];
  i = ynew->size[0];
  ynew->size[0] = y->size[0];
  emxEnsureCapacity_real_T(ynew, i);
  vlen = y->size[0];
  for (i = 0; i < vlen; i++) {
    ynew->data[i] = y->data[i] - b_y;
  }

  emxInit_real_T(&b_x, 1);

  /* remove mean from the template */
  i = b_x->size[0];
  b_x->size[0] = ynew->size[0];
  emxEnsureCapacity_real_T(b_x, i);
  vlen = ynew->size[0];
  for (i = 0; i < vlen; i++) {
    b_x->data[i] = ynew->data[i] * ynew->data[i];
  }

  vlen = b_x->size[0];
  if (b_x->size[0] == 0) {
    denom2 = 0.0;
  } else {
    denom2 = b_x->data[0];
    for (k = 2; k <= vlen; k++) {
      denom2 += b_x->data[k - 1];
    }
  }

  /* calculate denom for template */
  /* Preallocate */
  i = CC->size[0] * CC->size[1];
  CC->size[0] = 1;
  CC->size[1] = x->size[0];
  emxEnsureCapacity_real_T(CC, i);
  vlen = x->size[0];
  for (i = 0; i < vlen; i++) {
    CC->data[i] = 0.0;
  }

  /*  */
  i = x->size[0] - y->size[0];
  emxInit_real_T(&temp, 1);
  for (b_i = 0; b_i < i; b_i++) {
    /* Remove mean from the raw data fraction */
    u = (unsigned int)b_i + varargin_1;
    if ((unsigned int)(b_i + 1) > u) {
      i1 = 0;
      i2 = 0;
      i3 = -1;
      vlen = -1;
    } else {
      i1 = b_i;
      i2 = (int)u;
      i3 = b_i - 1;
      vlen = (int)u - 1;
    }

    vlen -= i3;
    if (vlen == 0) {
      b_y = 0.0;
    } else {
      b_y = x->data[i3 + 1];
      for (k = 2; k <= vlen; k++) {
        b_y += x->data[i3 + k];
      }
    }

    b_y /= (double)vlen;
    vlen = i2 - i1;
    i2 = temp->size[0];
    temp->size[0] = vlen;
    emxEnsureCapacity_real_T(temp, i2);
    for (i2 = 0; i2 < vlen; i2++) {
      temp->data[i2] = x->data[i1 + i2] - b_y;
    }

    /* First Summation is the numerator */
    /* Calculate denominator for raw data */
    /*  Do the Coefficient */
    i1 = b_x->size[0];
    b_x->size[0] = temp->size[0];
    emxEnsureCapacity_real_T(b_x, i1);
    vlen = temp->size[0];
    for (i1 = 0; i1 < vlen; i1++) {
      b_x->data[i1] = temp->data[i1] * ynew->data[i1];
    }

    i1 = b_x->size[0];
    if (b_x->size[0] == 0) {
      b_y = 0.0;
    } else {
      b_y = b_x->data[0];
      for (k = 2; k <= i1; k++) {
        b_y += b_x->data[k - 1];
      }
    }

    vlen = temp->size[0];
    for (i1 = 0; i1 < vlen; i1++) {
      temp->data[i1] *= temp->data[i1];
    }

    vlen = temp->size[0];
    if (temp->size[0] == 0) {
      c_y = 0.0;
    } else {
      c_y = temp->data[0];
      for (k = 2; k <= vlen; k++) {
        c_y += temp->data[k - 1];
      }
    }

    CC->data[b_i] = b_y / sqrt(c_y * denom2);
  }

  emxFree_real_T(&b_x);
  emxFree_real_T(&temp);
  emxFree_real_T(&ynew);

  /* pad zeros  */
  if (CC->size[1] > x->size[0]) {
    i = -1;
    i1 = 0;
  } else {
    i = CC->size[1] - 2;
    i1 = x->size[0];
  }

  vlen = (i1 - i) - 1;
  for (i1 = 0; i1 < vlen; i1++) {
    CC->data[(i + i1) + 1] = 0.0;
  }
}

/*
 * File trailer for my_matched_filtering.c
 *
 * [EOF]
 */
