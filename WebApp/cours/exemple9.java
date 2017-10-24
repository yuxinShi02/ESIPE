@GET
@PATH("/testCookieParam")
public String testCookieParam(
	 @CookieParam("nom") String nom) {
    { return nom; }

<script type="texte/javascript">
    function testCookieParam() {
    document.cookie = "nom=def; expires=0; path=/";
    document.location="http://localhost:8080/monApp/testCookieParam";
}
</scrip>

<form>
    <input type="button" onclick="testCookieParam()" value="Envoyer"/>
/form>
 

