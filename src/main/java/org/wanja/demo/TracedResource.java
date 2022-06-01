package org.wanja.demo;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.jboss.logging.Logger;

@Path("/person")
public class TracedResource {

    private static final Logger LOG = Logger.getLogger(PersonResource.class);

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        LOG.info("This is the person service"); 
        return "This is the person service";
    }
}
