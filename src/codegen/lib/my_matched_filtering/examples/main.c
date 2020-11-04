/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: main.c
 *
 * MATLAB Coder version            : 4.3
 * C/C++ source code generated on  : 25-May-2020 19:43:38
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include Files */
#include "main.h"
#include "my_matched_filtering.h"
#include "my_matched_filtering_emxAPI.h"
#include "my_matched_filtering_terminate.h"

/* Function Declarations */
static emxArray_real_T *argInit_Unboundedx1_real_T(void);
static double argInit_real_T(void);
static void main_my_matched_filtering(void);

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : emxArray_real_T *
 */
static emxArray_real_T *argInit_Unboundedx1_real_T(void)
{
  emxArray_real_T *result;
  static const int iv[1] = { 2 };

  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_real_T(1, iv);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0] = argInit_real_T();
  }

  return result;
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_my_matched_filtering(void)
{
  emxArray_real_T *CC;
  emxArray_real_T *x;
  emxArray_real_T *y;
  emxInitArray_real_T(&CC, 2);

  /* Initialize function 'my_matched_filtering' input arguments. */
  /* Initialize function input argument 'x'. */
  x = argInit_Unboundedx1_real_T();

  /* Initialize function input argument 'y'. */
  y = argInit_Unboundedx1_real_T();

  /* Call the entry-point 'my_matched_filtering'. */
  my_matched_filtering(x, y, CC);
  emxDestroyArray_real_T(CC);
  emxDestroyArray_real_T(y);
  emxDestroyArray_real_T(x);
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_my_matched_filtering();

  /* Terminate the application.
     You do not need to do this more than one time. */
  my_matched_filtering_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
