@Path ("/ServiceTestTexte/{texte}")
public class ServiceTestTexte {
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String test1(@PathParam("texte") String texte) {
	...
    }
}
    
