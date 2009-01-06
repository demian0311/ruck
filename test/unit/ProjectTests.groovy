class ProjectTests extends GroovyTestCase {

   void test2()
   {
      def p = Project.get(1);
      // No signature of method: static Project.get() is applicable for 
      // argument types: (java.lang.Integer) values: {1}
   }

   void test1()
   {
     new Project(name:'Windows Me').save() 
     // No signature of method: Project.save() is applicable for 
     // argument types: () values: {}
   }

   void _test()
   {
      def projectInstance = new Project()
      projectInstance.name = 'Word'
      projectInstance.description = 'word processor'
      projectInstance.startDate = new Date() 
      projectInstance.sprintLength = 2

      projectInstance.save()
   }

   void _testSomething() 
   {
      Project project = new Project()
      project.name = 'Lotus 123'
      project.description = 'spreadsheet'
      project.startDate = new Date()
      project.sprintLength = 3;

      //project.addToSprints(new Sprint(number:0, name:'backlog'))
      //Project.save(project)

      project.save(flush:true)

      print project
   }
}
