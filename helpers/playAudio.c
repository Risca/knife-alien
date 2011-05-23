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
    pa_operation *o;
    int fork_pid;
    size_t writableSize;
    // Get data
    int16_t *data = (int16_t*)mxGetData(prhs[1]);
    size_t r = mxGetM(prhs[1]);
//    mexPrintf("Size of data: %u\n",r);

    // Get PA settings
    uint64_t ptr = *(uint64_t*)(mxGetData(prhs[0]));
    pa_settings_t pa_ptrs = *(struct pa_settings*)(ptr);
    
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