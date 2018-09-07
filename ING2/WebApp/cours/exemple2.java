@Path ("/ServiceTestTexte/{texte}")
public class ServiceTestTexte {
    @GET
    public String test1(@PathParam("texte") String texte) {
	return ;
    }
}
    
