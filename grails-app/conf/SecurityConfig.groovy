security {

  active = true
  cacheUsers = false

  loginUserDomainClass = "User"
  authorityDomainClass = "Role"
  userName = "username"
  password = "password"
  basicProcessingFilter = true

  useRequestMapDomainClass = false


  requestMapString = '''
        CONVERT_URL_TO_LOWERCASE_BEFORE_COMPARISON
        PATTERN_TYPE_APACHE_ANT
        /css/**=IS_AUTHENTICATED_ANONYMOUSLY
		/scripts/**=IS_AUTHENTICATED_ANONYMOUSLY
		/js/**=IS_AUTHENTICATED_ANONYMOUSLY
		/images/**=IS_AUTHENTICATED_ANONYMOUSLY
		/login/**=IS_AUTHENTICATED_ANONYMOUSLY
        /**=IS_AUTHENTICATED_ANONYMOUSLY
	   '''
}
