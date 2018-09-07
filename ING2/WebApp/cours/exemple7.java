@Path("/garages")
public class GarageListe {
    ...
    @GET
    @Path("queryparam")
    public String getQueryParam(
	   @DefaultValue("all") @QueryParam("nom") String nom,
	   @DefaultValue("?-???????-?") @QueryParam("matri") String matri,
	   @DefaultValue("false") @QueryParam("pollue") boolean pollue) {
	...
    }
}
