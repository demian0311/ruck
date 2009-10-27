import grails.util.Environment

class BootStrap {
  def authenticateService

  def init = {servletContext ->
    switch (Environment.current) {
      case Environment.DEVELOPMENT:
      case Environment.PRODUCTION:
        createAdminUserIfRequired()
        break;
    }
  }

  void createAdminUserIfRequired() {
    if (!User.findByUsername("admin")) {
      log.debug "Creating admin user and role"
      def role = new Role(authority: "ROLE_ADMINISTRATOR", description: "Super user")
      def user = new User(username: "admin", password: authenticateService.encodePassword("secret"), userRealName: "Administrator", email: "test@test.com", enabled: true)
      role.addToPeople(user)
      role.save()
      def userRole = new Role(authority: "ROLE_USER", description: "Standard user")
      userRole.addToPeople(user)
      userRole.save()
    } else {
      log.debug "Skipping creation of admin user"
    }
  }

  def destroy = {
  }

} 
