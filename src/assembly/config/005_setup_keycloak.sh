
/subsystem=elytron/key-store=myKeyStore:add(path="truststore.jks", relative-to="jboss.server.config.dir", credential-reference={clear-text="your-keystore-password"})

/subsystem=elytron/trust-manager=myTrustManager:add(algorithm="SunX509", key-store="myKeyStore")

# Add the client-ssl-context (if needed for HTTPS)
/subsystem=elytron/client-ssl-context=mySslContext:add(trust-manager=myTrustManager)

# Set up the OIDC provider configuration
/subsystem=elytron/oidc-provider=my-oidc-provider:add(provider-url="https://krake-rhsso1-dev.bvatst.local/auth/realms/your-realm", \
    client-id="mvbl_2.0",\
    client-secret="0f1e8f1b-608e-4607-9d46-335d4156f985",\
    ssl-context=mySslContext, \
    client-config={"token-minimum-time-to-live" => 30,"enable-caching" => true} )

/subsystem=elytron/oidc-provider=my-oidc-provider:add(provider-url="https://v-rhsso-dev2.vaeb.local/auth/realms/your-realm", \
    client-id="mvbl_2.0",\
    client-secret="3c31ed94-9f89-4d9d-9678-fa940ee1554f",\
    ssl-context=mySslContext)

# Add Keycloak realm configuration
## works
/subsystem=elytron/custom-realm=KeycloakOIDCRealm:write-attribute(name=configuration, value={ \
    "realm-name" => "vaeb", \
    "realm-public-key" => "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs2VN8rMG/HQdx8HPpurFAT/sQsxWEvoG/MBlOGELVvgUrS2KL7HXh/AYMOoNCaWpGkoVRZVTJDu4l165Ps3UxHXTyjFmOHUtfe/vuByLzFNDdpNIkhVedMl2/UwEvo2hi9lHOEyRdURs7jx4exQc1uZYFE7C2delZximzt5jswgbw14PnXpsQDGP3sxfYYO3sDkgwzbtVxims02e+ufuPPJPOFwiogwgk8oRfh1c1Tn+Nz6dbU69JG2O2IpUjtHkUQvL2kNOvb8y8X2aLpEWIxJFQDR4ETqONfevyCTNE2NCcME9iWpVNVhnwZ6bss5oYLhMpIaE4hEyzM6NLPQOhQIDAQAB", \
    "auth-server-url" => "https://v-rhsso-dev2.vaeb.local/auth", \
    "ssl-required" => "none" \
    "resource" => "mvbl_2.0", \
    "credentials.secret" => "3c31ed94-9f89-4d9d-9678-fa940ee1554f" \
})


# Configure the Elytron Security Domain
/subsystem=elytron/security-domain=my-oidc-security-domain:add(realms=[{
    realm="vaeb",
    role-decoder="groups-to-roles"
}], default-realm="vaeb", permission-mapper="default-permission-mapper")

# Assign the security domain to the web application (example assumes WAR deployment)
/subsystem=undertow/application-security-domain=my-application:add(security-domain=my-oidc-security-domain)

