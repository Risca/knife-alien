#include "mex.h"
#include <pulse/pulseaudio.h>
#include <stdio.h>
#include <unistd.h>

typedef
struct pa_settings {
    // Define our pulse audio loop and connection variables
    pa_mainloop *pa_ml;
    pa_mainloop_api *pa_mlapi;
    pa_context *pa_ctx;
    pa_stream *pa_s;
    pa_sample_spec pa_ss;
} pa_settings_t;

void mexFunction(int nlhs, mxArray *plhs[],
    int nrhs, const mxArray *prhs[])
{
    // Get PA settings
    uint64_t ptr = *(uint64_t*)(mxGetData(prhs[0]));
    pa_settings_t pa_ptrs = *(struct pa_settings*)(ptr);
    
    // Shutdown everything
    pa_stream_disconnect(pa_ptrs.pa_s);
    pa_context_disconnect(pa_ptrs.pa_ctx);
    pa_context_unref(pa_ptrs.pa_ctx);
    pa_mainloop_free(pa_ptrs.pa_ml);
    mexPrintf("Pulseaudio destroyed\n");
}