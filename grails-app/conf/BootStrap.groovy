class BootStrap {

     def init = { servletContext ->
         // set up a new project
         Project p = new Project()
         p.name = 'example'
         p.description = 'example project' 
         p.startDate = new Date()
         p.sprintLength = 1
         p.save()

         // now create a default backlog 
         def backlogSprint = new Sprint()
         backlogSprint.name = 'backlog'
         backlogSprint.goal = 'stories to here before being worked on'
         backlogSprint.number = 0 
         p.addToSprints(backlogSprint)

         p.save()


         p.save()

         // add stories to the backlog
         Story s0 = new Story()
         s0.points = 1 
         s0.description = 'as a user I want to change my contact information'
         s0.ordinal = 0
         backlogSprint.addToStories(s0)

         Story s1 = new Story()
         s1.points = 5 
         s1.description = 'as an admin I want to assign roles to users'
         s1.ordinal = 1
         backlogSprint.addToStories(s1)

         Story s2 = new Story()
         s2.points = 3 
         s2.description = 'as an admin I want to de-activate an account'
         s2.ordinal = 2 
         backlogSprint.addToStories(s2)

         Story s3 = new Story()
         s3.points = 2 
         s3.description = 'as a customer I want to request a new account'
         s3.ordinal = 3 
         backlogSprint.addToStories(s3)

         // create the first sprint
         def sprint1 = new Sprint()
         sprint1.number = 1 
         p.addToSprints(sprint1)

         Story s00 = new Story()
         s00.points = 3
         s00.description = 'as a user I want to log into the system'
         s00.ordinal = 0
         sprint1.addToStories(s00)

            Task t000 = new Task()
            t000.name = 'add database tables'
            t000.status = 'done'
            t000.hoursEstimate = 4
            s00.addToTasks(t000)

            Task t001 = new Task()
            t001.name = 'add login screen'
            t001.status = 'verification'
            t001.hoursEstimate = 2 
            s00.addToTasks(t001)

         Story s01 = new Story()
         s01.points = 1 
         s01.description = 'as a user I want to change my password'
         s01.ordinal = 1
         sprint1.addToStories(s01)

            Task t012 = new Task()
            t012.name = 'add database tables'
            t012.status = 'done'
            t012.hoursEstimate = 4
            s01.addToTasks(t012)

            Task t013 = new Task()
            t013.name = 'add account screen'
            t013.status = 'working'
            t013.hoursEstimate = 3 
            s01.addToTasks(t013)

            Task t014 = new Task()
            t014.name = 'email notification'
            t014.status = 'not started'
            t014.hoursEstimate = 3 
            s01.addToTasks(t014)

         Story s02 = new Story()
         s02.points = 2 
         s02.description = 'as an admin I want to maintain users'
         s02.ordinal = 2 
         sprint1.addToStories(s02)

            Task t020 = new Task()
            t020.name = 'user maintenance screen'
            t020.status = 'not started'
            t020.hoursEstimate = 6 
            s02.addToTasks(t020)

         Story s03 = new Story()
         s03.points = 2 
         s03.description = 'as a user I want my account locked if I have too many failed login attempts'
         s03.ordinal = 3 
         sprint1.addToStories(s03)

            Task t030 = new Task()
            t030.name = 'add attributes to user table'
            t030.status = 'done'
            t030.hoursEstimate = 1 
            s03.addToTasks(t030)

            Task t031 = new Task()
            t031.name = 'add logic to authentication processj'
            t031.status = 'working'
            t031.hoursEstimate = 2 
            s03.addToTasks(t031)
     }
     def destroy = {
     }
} 
