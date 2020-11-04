/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_my_matched_filtering_mex.c
 *
 * MATLAB Coder version            : 4.3
 * C/C++ source code generated on  : 25-May-2020 19:43:38
 */

/* Include Files */
#include "_coder_my_matched_filtering_mex.h"
#include "_coder_my_matched_filtering_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void c_my_matched_filtering_mexFunct(int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[1]
 *                int32_T nrhs
 *                const mxArray *prhs[2]
 * Return Type  : void
 */
void c_my_matched_filtering_mexFunct(int32_T nlhs, mxArray *plhs[1], int32_T
  nrhs, const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        20, "my_matched_filtering");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 20,
                        "my_matched_filtering");
  }

  /* Call the function. */
  my_matched_filtering_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[]
 *                int32_T nrhs
 *                const mxArray *prhs[]
 * Return Type  : void
 */
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(my_matched_filtering_atexit);

  /* Module initialization. */
  my_matched_filtering_initialize();

  /* Dispatch the entry-point. */
  c_my_matched_filtering_mexFunct(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  my_matched_filtering_terminate();
}

/*
 * Arguments    : void
 * Return Type  : emlrtCTX
 */
emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/*
 * File trailer for _coder_my_matched_filtering_mex.c
 *
 * [EOF]
 */
