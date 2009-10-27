import grails.util.Environment

class BootStrap {
  def authenticateService

  def init = {servletContext ->

    createRoles()

    switch (Environment.current) {
      case Environment.DEVELOPMENT:
      case Environment.PRODUCTION:
        createAdminUserIfRequired()
        break;
    }
  }

  void createRoles() {
      def scrumMaster = new Role(authority: "ROLE_SCRUM_MASTER", description: "scrum master")
      scrumMaster.save()

      def productOwner = new Role(authority: "ROLE_PRODUCT_OWNER", description: "product owner")
      productOwner.save()

      def pig = new Role(authority: "ROLE_TEAM_MEMBER", description: "someone committed to the project")
      pig.save()

      def chicken = new Role(authority: "ROLE_OBSERVER", description: "someone involved in the project")
      chicken.save()
  }


  void createAdminUserIfRequired() {
    if (!User.findByUsername("admin")) {
      log.debug "Creating admin user and role"
      def role = new Role(authority: "ROLE_ADMINISTRATOR", description: "administrator for the system")
      def user = new User(username: "admin", password: authenticateService.encodePassword("secret"), userRealName: "Administrator", email: "test@test.com", enabled: true)
      role.addToPeople(user)
      role.save()
      //def userRole = new Role(authority: "ROLE_USER", description: "Standard user")
      //userRole.addToPeople(user)
      //userRole.save()
    } else {
      log.debug "Skipping creation of admin user"
    }
  }

  def destroy = {
  }

} 
