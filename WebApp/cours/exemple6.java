@Path("/")
public class ListeGarage {
   @Path("/garage/{id}")
   public Garage getGarage(@PathParam("id") int id) {
      Garage g = ...;
      return g;
   }
}

public class Garage {
    @GET
    public String get() {...}
    @Path("/adresse")
    public String getAdresse() {...}
}
