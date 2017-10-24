@GET
@Path ("/ServiceGarage")
@Produces(MediaType.APPLICATION_JSON)
public Response garageCree() {
    Garage garage = new Garage();
    ...
	try {
	    final URI uri = new URI("Garage/1");
	    return Response.status(Status.CREATED)
		.location(uri)
		.entity(garage)
		.build();
	}
	catch (URISyntaxException e) {
	    return Response.status(Status.INTERNAL_SERVER_ERROR)
		.build();
	}
	    
}
   
