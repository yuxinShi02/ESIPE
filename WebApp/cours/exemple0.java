@Path ("/ServiceTestTexte")
public class ServiceTestTexte {
    @GET
    @Produces("MediaType.TEXT_PLAIN_TYPE")
    public String test1() {
	return "Un texte";
    }
}
    
