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
      "/backlog/$id"
      {
         // id is the project id
         controller = "backlog"
         action = "list"
	      constraints 
         {
			 // apply constraints here
		   }
      }

	  "500"(view:'/error')
	}
}
