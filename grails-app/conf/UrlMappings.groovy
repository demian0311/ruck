class UrlMappings {
   static mappings = 
   {
      "/$controller/$action?/$id?"
      {
	      constraints 
         {
			 // apply constraints here
		   }
      }
      /*
      "/backlog/$id"
      {
         println '*** going to show the backlog'
         // id is the project id
         controller = "backlog"
         action = "list"
	      constraints 
         {
			 // apply constraints here
		   }
      }
      */
      /*"/"(controller:"project")*/

	  "500"(view:'/error')
	}
}
