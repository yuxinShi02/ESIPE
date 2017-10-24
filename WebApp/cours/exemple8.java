@Path("/garages")
public class GarageListe {
    ...
    @POST
    @Path("formparam")
    @Consumes("application/x-www-form-urlencoded")
    public String getFormParam(
	   @FormParam("nom") String nom) {
	...
    }
}

<form
    action="....." method="POST">
    <input type="text" name="nom" value="def"\>
    ...
/form>
