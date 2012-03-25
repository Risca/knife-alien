#include "mex.h"
#include <pulse/pulseaudio.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

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

void mexFunction(int nlhs, mxArray *plhs[],
    int nrhs, const mxArray *prhs[])
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
    pa_ptrs.pa_ctx = pa_context_new(pa_ptrs.pa_mlapi, "knife-alien");

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
            printf("Error");
            return;
    }

    // At this point, we're connected to the server and ready to make
	// requests
    printf("Context connected to PA-daemon\n");

    
    pa_ptrs.pa_s = pa_stream_new(pa_ptrs.pa_ctx,"knife-alien",&pa_ptrs.pa_ss,NULL);
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
            printf("Error");
            return;
    }
    
    mexPrintf("Stream connected to PA-daemon\n");
    
    plhs[0]=mxCreateNumericMatrix(1,1,mxUINT64_CLASS,mxREAL);
    uint64_t *ptr = (uint64_t)mxGetData(plhs[0]);
    *ptr = &pa_ptrs;
}
