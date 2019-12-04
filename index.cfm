<cfif IsUserLoggedIn() > 
    <cfset message = "Hello World">
    <cfoutput> #message#</cfoutput>
    <P>Authenticated User (this is the user's oid claim, their cross-application unique ID within your tenant): <cfoutput>#GetAuthUser()#</cfoutput>
<cfelse>
    <cflocation url="http://localhost:8500/auth.cfm">
<cfabort> 
</cfif>