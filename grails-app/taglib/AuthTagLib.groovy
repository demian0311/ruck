/* Copyright 2004-2005 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT c;pWARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * A taglib to help with J2EE security implementations (e.g. ACEGI) within Grails. 
 *
 * @author Joe Mooney
 * @since 23-November-2006  
 */
class AuthTagLib {

	// Execute main body only if the user is logged in
	def ifLoggedIn = {attrs, body ->
		if (request.remoteUser) {
			body{}
		}
	}

	// Execute main body only if the user is NOT logged in
	def ifNotLoggedIn = {attrs, body ->
		//if (!request.remoteUser) {
			body{}
		//}
	}

	// Execute main body only if the user is logged in and has one of the roles requested
	def ifUserHasRole = {attrs, body ->
            if(request.remoteUser)
            {
		if (userHasOneOfRequiredRoles(attrs.roles.split(/,/))) {
			return body{}
		}
            }
	}

	// Execute main body only if the user is logged in and has none of the roles requested
	def ifUserHasNoRole = {attrs, body ->
		if (!userHasOneOfRequiredRoles(attrs.roles.split(/,/))) {
			return body{}
		}
	}

	// Output the signed on user name (if they are logged in)
	def loggedInUser = { attrs, body ->
            def username = request.remoteUser//getUserName()
            if (username)
            {
		out << username
            }
	}

//        def getUsername = { attrs, body ->
//
//            return request.remoteUser
//        }

	/*
	 * Execute main body only if the user is logged in and is either an admin user (based on supplied roles) or
	 * if they were the creator of the bean (based on the supplied userName)
	 */
	def ifUserCanEdit = {attrs, body ->
		def userIsGood = false
		def adminRoles = attrs["adminRoles"]
		if (adminRoles) {
			userIsGood = userHasOneOfRequiredRoles(adminRoles.split(/,/))
		}
		if (!userIsGood) {
		 	def userName = attrs["userName"]
			def signedOnUserName = getUserName();
		 	if (signedOnUserName && userName == signedOnUserName) {
		 		userIsGood = true
		 	}
		}
		if (userIsGood) {
			return body{}
		}
	}

		
	// Helper method to get the user name
	def getUserName = { ->
		return request.remoteUser
	}

	// Helper method to indicate if a user has at least one of the requested roles
	def userHasOneOfRequiredRoles = {requiredRoles ->
		def userHasOneRole = false
		if (getUserName()) {
			requiredRoles.each {roleRequired ->
				if (request.isUserInRole(roleRequired)) {
					userHasOneRole = true
				}
			}
		}
		return userHasOneRole
	}
}

