/*
 * sfuntmpl_basic.c: Basic 'C' template for a level 2 S-function.
 *
 *  -------------------------------------------------------------------------
 *  | See matlabroot/simulink/src/sfuntmpl_doc.c for a more detailed template |
 *  -------------------------------------------------------------------------
 *
 * Copyright 1990-2002 The MathWorks, Inc.
 * $Revision: 1.27.4.2 $
 */


/*
 * You must specify the S_FUNCTION_NAME as the name of your S-function
 * (i.e. replace sfuntmpl_basic with the name of your S-function).
 */

#define S_FUNCTION_NAME  playAudio_s
#define S_FUNCTION_LEVEL 2

/*
 * Need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */
#include "simstruc.h"

/* Include pulseaudio headers */
#include <pulse/pulseaudio.h>


/* Error handling
 * --------------
 *
 * You should use the following technique to report errors encountered within
 * an S-function:
 *
 *       ssSetErrorStatus(S,"Error encountered due to ...");
 *       return;
 *
 * Note that the 2nd argument to ssSetErrorStatus must be persistent memory.
 * It cannot be a local variable. For example the following will cause
 * unpredictable errors:
 *
 *      mdlOutputs()
 *      {
 *         char msg[256];         {ILLEGAL: to fix use "static char msg[256];"}
 *         sprintf(msg,"Error due to %s", string);
 *         ssSetErrorStatus(S,msg);
 *         return;
 *      }
 *
 * See matlabroot/simulink/src/sfuntmpl_doc.c for more details.
 */

/*====================*
 * S-function methods *
 *====================*/

static struct pa_settings {
    // Define our pulse audio loop and connection variables
    pa_mainloop *pa_ml;
    pa_mainloop_api *pa_mlapi;
    pa_context *pa_ctx;
    pa_stream *pa_s;
    pa_sample_spec pa_ss;
}pa_ptrs;

// This callback gets called when our context changes state.  We really only
// care about when it's ready or if it has failed
void pa_state_cb(pa_context *c, void *userdata) {
        pa_context_state_t state;
        int *pa_ready = userdata;

        state = pa_context_get_state(c);
        switch  (state) {
                // There are just here for reference
                case PA_CONTEXT_UNCONNECTED:
                case PA_CONTEXT_CONNECTING:
                case PA_CONTEXT_AUTHORIZING:
                case PA_CONTEXT_SETTING_NAME:
                default:
                        break;
                case PA_CONTEXT_FAILED:
                case PA_CONTEXT_TERMINATED:
                        *pa_ready = 2;
                        break;
                case PA_CONTEXT_READY:
                        *pa_ready = 1;
                        break;
        }
}

void pa_stream_cb(pa_stream *p, void *userdata)
{
    pa_stream_state_t state;
    int *pa_conn = userdata;

    state = pa_stream_get_state(p);
    switch  (state) {
        // There are just here for reference
                case PA_STREAM_UNCONNECTED:
                case PA_STREAM_CREATING:
                default:
                        break;
                case PA_STREAM_FAILED:
                case PA_STREAM_TERMINATED:
                        *pa_conn = 2;
                        break;
                case PA_STREAM_READY:
                        *pa_conn = 1;
                        break;
        }
}

/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *    The sizes information is used by Simulink to determine the S-function
 *    block's characteristics (number of inputs, outputs, states, etc.).
 */
static void mdlInitializeSizes(SimStruct *S)
{
    /* See sfuntmpl_doc.c for more details on the macros below */

    ssSetNumSFcnParams(S, 0);  /* Number of expected parameters */
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        /* Return if number of expected != number of actual parameters */
        return;
    }

    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 0);

    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, 1);
    ssSetInputPortRequiredContiguous(S, 0, true); /*direct input signal access*/
    ssSetInputPortDataType(S, 0, SS_INT16);
    /*
     * Set direct feedthrough flag (1=yes, 0=no).
     * A port has direct feedthrough if the input is used in either
     * the mdlOutputs or mdlGetTimeOfNextVarHit functions.
     * See matlabroot/simulink/src/sfuntmpl_directfeed.txt.
     */
    ssSetInputPortDirectFeedThrough(S, 0, 0);

    if (!ssSetNumOutputPorts(S, 0)) return;

    ssSetNumSampleTimes(S, 1);
    ssSetNumRWork(S, 0);
    ssSetNumIWork(S, 0);
    ssSetNumPWork(S, 0);
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);

    /* Specify the sim state compliance to be same as a built-in block */
    ssSetSimStateCompliance(S, USE_DEFAULT_SIM_STATE);

    ssSetOptions(S, 0);
}


/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    This function is used to specify the sample time(s) for your
 *    S-function. You must register the same number of sample times as
 *    specified in ssSetNumSampleTimes.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, CONTINUOUS_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);

}



#undef MDL_INITIALIZE_CONDITIONS   /* Change to #undef to remove function */
#if defined(MDL_INITIALIZE_CONDITIONS)
  /* Function: mdlInitializeConditions ========================================
   * Abstract:
   *    In this function, you should initialize the continuous and discrete
   *    states for your S-function block.  The initial states are placed
   *    in the state vector, ssGetContStates(S) or ssGetRealDiscStates(S).
   *    You can also perform any other initialization activities that your
   *    S-function may require. Note, this routine will be called at the
   *    start of simulation and if it is present in an enabled subsystem
   *    configured to reset states, it will be call when the enabled subsystem
   *    restarts execution to reset the states.
   */
  static void mdlInitializeConditions(SimStruct *S)
  {
  }
#endif /* MDL_INITIALIZE_CONDITIONS */



#define MDL_START  /* Change to #undef to remove function */
#if defined(MDL_START) 
  /* Function: mdlStart =======================================================
   * Abstract:
   *    This function is called once at start of model execution. If you
   *    have states that should be initialized once, this is the place
   *    to do it.
   */
  static void mdlStart(SimStruct *S)
  {
    // We'll need these state variables to keep track of our requests
    int pa_ready = 0;
    int pa_conn = 0;
    int fork_id = 0;
    
    // Create a mainloop API and connection to the default server
    pa_ptrs.pa_ss.format = PA_SAMPLE_S16NE;
    pa_ptrs.pa_ss.rate = 22050;
    pa_ptrs.pa_ss.channels = 1;
    pa_ptrs.pa_ml = pa_mainloop_new();
    pa_ptrs.pa_mlapi = pa_mainloop_get_api(pa_ptrs.pa_ml);
    pa_ptrs.pa_ctx = pa_context_new(pa_ptrs.pa_mlapi, "test");

    // This function connects to the pulse server
    pa_context_connect(pa_ptrs.pa_ctx, NULL, 0, NULL);

    // This function defines a callback so the server will tell us it's state.
    // Our callback will wait for the state to be ready.  The callback will
    // modify the variable to 1 so we know when we have a connection and it's
    // ready.
    // If there's an error, the callback will set pa_ready to 2
    pa_context_set_state_callback(pa_ptrs.pa_ctx, pa_state_cb, &pa_ready);

    for (int i=0;pa_ready == 0 && i<1000;i++) {
        pa_mainloop_iterate(pa_ptrs.pa_ml, 1, NULL);
    }

    if (pa_ready == 2 || pa_ready == 0) {
            pa_context_disconnect(pa_ptrs.pa_ctx);
            pa_context_unref(pa_ptrs.pa_ctx);
            pa_mainloop_free(pa_ptrs.pa_ml);
            ssPrintf("Error");
            return;
    }

    // At this point, we're connected to the server and ready to make
	// requests
    ssPrintf("Context connected to PA-daemon\n");

    
    pa_ptrs.pa_s = pa_stream_new(pa_ptrs.pa_ctx,"FooStream",&pa_ptrs.pa_ss,NULL);
    pa_stream_connect_playback(pa_ptrs.pa_s, // The stream to connect to a sink 
            NULL, // Name of the sink to connect to, or NULL for default 
            NULL, // Buffering attributes, or NULL for default 
            PA_STREAM_NOFLAGS, // Additional flags, or 0 for default
            NULL, // Initial volume, or NULL for default 
            NULL // Synchronize this stream with the specified one, or NULL for a standalone stream
            );
    pa_stream_set_state_callback(pa_ptrs.pa_s,pa_stream_cb,&pa_conn);
    
    for (int i=0;pa_conn == 0 && i<1000;i++) {
        pa_mainloop_iterate(pa_ptrs.pa_ml,1,NULL);
        
    }

    if (pa_conn == 2 || pa_conn == 0) {
            pa_stream_disconnect(pa_ptrs.pa_s);
            pa_context_disconnect(pa_ptrs.pa_ctx);
            pa_context_unref(pa_ptrs.pa_ctx);
            pa_mainloop_free(pa_ptrs.pa_ml);
            ssPrintf("Error");
            return;
    }
    
    ssPrintf("Stream connected to PA-daemon\n");
}
#endif /*  MDL_START */



/* Function: mdlOutputs =======================================================
 * Abstract:
 *    In this function, you compute the outputs of your S-function
 *    block.
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
}



#define MDL_UPDATE  /* Change to #undef to remove function */
#if defined(MDL_UPDATE)
  /* Function: mdlUpdate ======================================================
   * Abstract:
   *    This function is called once for every major integration time step.
   *    Discrete states are typically updated here, but this function is useful
   *    for performing any tasks that should only take place once per
   *    integration step.
   */
  static void mdlUpdate(SimStruct *S, int_T tid)
  {
    // Declare some variables used later
    pa_operation *o;
    size_t writableSize;
    
    // Get data
    if (ssGetInputPortDataType(S,0) != SS_INT16) {
        ssPrintf("Wrong input type");
        return;
    }
    const int16_t *data = ssGetInputPortSignal(S,0);
    size_t r=ssGetInputPortWidth(S,0);

    // Determine how much we can put in buffer
    writableSize=pa_stream_writable_size(pa_ptrs.pa_s);
    if (writableSize < r)
        r=writableSize;
    // Play
    pa_stream_write(pa_ptrs.pa_s,data,r,NULL,0,PA_SEEK_RELATIVE);
    o=pa_stream_drain(pa_ptrs.pa_s,0,NULL);
    while(pa_operation_get_state(o) != PA_OPERATION_DONE) {
        pa_mainloop_iterate(pa_ptrs.pa_ml,1,NULL);
    }
    pa_operation_unref(o);
  }
#endif /* MDL_UPDATE */



#undef MDL_DERIVATIVES  /* Change to #undef to remove function */
#if defined(MDL_DERIVATIVES)
  /* Function: mdlDerivatives =================================================
   * Abstract:
   *    In this function, you compute the S-function block's derivatives.
   *    The derivatives are placed in the derivative vector, ssGetdX(S).
   */
  static void mdlDerivatives(SimStruct *S)
  {
  }
#endif /* MDL_DERIVATIVES */



/* Function: mdlTerminate =====================================================
 * Abstract:
 *    In this function, you should perform any actions that are necessary
 *    at the termination of a simulation.  For example, if memory was
 *    allocated in mdlStart, this is the place to free it.
 */
static void mdlTerminate(SimStruct *S)
{
    pa_stream_disconnect(pa_ptrs.pa_s);
    pa_context_disconnect(pa_ptrs.pa_ctx);
    pa_context_unref(pa_ptrs.pa_ctx);
    pa_mainloop_free(pa_ptrs.pa_ml);
    mexPrintf("Pulseaudio destroyed\n");
}


/*======================================================*
 * See sfuntmpl_doc.c for the optional S-function methods *
 *======================================================*/

/*=============================*
 * Required S-function trailer *
 *=============================*/

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
