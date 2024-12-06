package at.cgsit.research;

import io.restassured.RestAssured;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import io.restassured.RestAssured;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

class HelloWorldEndpointTest {

  // Set up the base URI for REST-assured before running the tests
  @BeforeAll
  public static void setup() {
    // Make sure to set your application's base URI
    RestAssured.baseURI = "http://localhost:8080/your-webapp-context"; // Update with actual context
  }

  // Test the 'sayHello' endpoint
  // @Test
  public void testSayHello() {
    given()
        .when()
        .get("/hello") // Path to the hello endpoint
        .then()
        .statusCode(200) // Expect a 200 OK status
        .body("message", equalTo("Hello from secured endpoint!")); // Verify the message in the response body
  }


}