@Path("/Garage")
public class Garage {
    ...
    @GET
    @Path("{id}")
    public String getGarageById(@PathParam("id") int id) {
	return "Garage : " + id; }
    @GET
    @Path("nom-{nom}-ville-{ville}")
    public String getGarageByName(@PathParam("nom") String nom,
				  @PathParam("ville") String ville) {
	return "Name:" + name + " - Ville: " + ville ;
    }
}


