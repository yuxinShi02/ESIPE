@Path ("/ServiceTestTexte")
public class ServiceTestTexte {
    @GET
    public String test1() {
	return "Un texte";
    }

    @GET
    @Path("/autreTest")
    public String test2() {
	return "Un autre texte";
    }
}
    
