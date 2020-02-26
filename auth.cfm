<cflogin>
    <cfoauth
        clientid = "be2b3203-0453-4f53-bcfb-95e1122c8b01" <!--- azure ad app/client id --->
        secretkey = "]hDlZ2zXDi.PUwg?MKi-sV3QKhxw1Ee4" <!--- azure ad app/client secret --->
        result = "res"
        scope = "api://apps.jpda.dev/ups/cf/user_impersonation" <!--- azure ad app scope uri --->
        authendpoint = "https://login.microsoftonline.com/jpda.onmicrosoft.com/oauth2/v2.0/authorize" <!--- azure ad oauth2 authorize endpoint --->
        accesstokenendpoint = "https://login.microsoftonline.com/jpda.onmicrosoft.com/oauth2/v2.0/token" <!--- azure ad oauth2 token endpoint --->
        redirecturi = "http://localhost:8500/auth.cfm">

    <cfset jwt = createObject("component","lib/JsonWebTokens")> 
    <!--- azure ad kid BB8CeFVqyaGrGNuehJIiL4dfjzw, see https://login.microsoftonline.com/common/disovery/v2.0/keys --->
    <cfset pubkey = "
    MIIDBTCCAe2gAwIBAgIQbiJkXaenk61AKixVocnLRTANBgkqhkiG9w0BAQsFADAt
    MSswKQYDVQQDEyJhY2NvdW50cy5hY2Nlc3Njb250cm9sLndpbmRvd3MubmV0MB4X
    DTE5MTAwNTAwMDAwMFoXDTI0MTAwNDAwMDAwMFowLTErMCkGA1UEAxMiYWNjb3Vu
    dHMuYWNjZXNzY29udHJvbC53aW5kb3dzLm5ldDCCASIwDQYJKoZIhvcNAQEBBQAD
    ggEPADCCAQoCggEBAJ2H9Y6Z+3BXUCtlbmXr6H5owYy15XTl3vdpOZLUkk4OV9LM
    sB1phjNp+wgl28eAgrNNfu4BTVlHdR9x6NTrSiIapsYjzzEz4mOmRh1Bw5tJxit0
    VEGn00/ZENniTjgeEFYgDHYwjrfZQ6dERBFiw1OQb2IG5f3KLtx92lUXeIZ7ZvTa
    PkUpc4Qd6wQZmWgzPqWFocRsJATGyZzXiiXQUrc9cVqm1bws3P0lFBcqNtv+AKDY
    KT5IRYLsyCkueQC9R6LUCsZVD7bVIkeQuA3iehJKIEAlk/e3j5E4VaCRs642ajb/
    z9kByTl2xL2k0AeZGc8/Rcy7SQn0LBcJNZGp/SMCAwEAAaMhMB8wHQYDVR0OBBYE
    FOLhl3BDPLNVYDe38Dp9JbUmd4kKMA0GCSqGSIb3DQEBCwUAA4IBAQAN4XwyqYfV
    dMl0xEbBMa/OzSfIbuI4pQWWpl3isKRAyhXezAX1t/0532LsIcYkwubLifnjHHqo
    4x1jnVqkvkFjcPZ12kjs/q5d1L0LxlQST/Uqwm/9/AeTzRZXtUKNBWBOWy9gmw9D
    EH593sNYytGAEerbWhCR3agUxsnQSYTTwg4K9cSqLWzHX5Kcz0NLCGwLx015/Jc7
    HwPJnp7q5Bo0O0VfhomDiEctIFfzqE5x9T9ZTUSWUDn3J7DYzs2L1pDrOQaNs/YE
    kXsKDP1j4tOFyxic6OvjQ10Yugjo5jg1uWoxeU8pI0BxY6sj2GZt3Ynzev2bZqmj
    68y0I9Z+NTZo">
    <cfset result = jwt.decode(res.access_token, "RS256", "#pubkey#")>
    <cfloginuser  name="#result.oid#"  password="#res.access_token#"  roles="roles">
</cflogin>

<cflocation url="http://localhost:8500/index.cfm">

<cfdump var="#result#" expand="yes">
<cfdump var="#res#" expand="yes">