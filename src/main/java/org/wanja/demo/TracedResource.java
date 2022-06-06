package org.wanja.demo;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import io.jaegertracing.internal.JaegerSpanContext;
import io.opentracing.SpanContext;
import io.opentracing.Tracer;
import io.smallrye.opentracing.contrib.resolver.TracerResolver;

@Path("/trace")
public class TracedResource {

    @Inject
    Tracer tracer;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        String traceId = "none";

        final SpanContext spanContext = tracer.scopeManager().activeSpan().context();
        if (spanContext instanceof JaegerSpanContext) {
            traceId = ((JaegerSpanContext) spanContext).getTraceId();
        }

        TracerResolver.resolveTracer().activeSpan().setTag("traceId", traceId);
        TracerResolver.resolveTracer().activeSpan().setTag("tagMessage", "this is an awesome message");
        TracerResolver.resolveTracer().activeSpan().setBaggageItem("traceId", traceId);

        return "Here is the traceId = " + traceId;
    }

}
