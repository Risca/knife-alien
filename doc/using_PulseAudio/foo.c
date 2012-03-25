#include "mex.h"
#include <pulse/simple.h>

void mexFunction(int nlhs, mxArray *plhs[],
    int nrhs, const mxArray *prhs[])
{
    const mxArray *Data = prhs[0];
    int16_t *data = (int16_t*)mxGetData(prhs[0]);
    size_t r = mxGetN(Data);
    
    // PA code
    pa_simple *s;
    pa_sample_spec ss;

    ss.format = PA_SAMPLE_S16LE;
    ss.channels = 1;
    ss.rate = 22050;
    
    s = pa_simple_new(NULL,               // Use the default server.
                      "knife-alien",      // Our application's name.
                      PA_STREAM_PLAYBACK,
                      NULL,               // Use the default device.
                      "Music",            // Description of our stream.
                      &ss,                // Our sample format.
                      NULL,               // Use default channel map
                      NULL,               // Use default buffering attributes.
                      NULL                // Ignore error code.
                      );
    
    pa_simple_write(s,data,(size_t)r,NULL);
}