var TaskBoard = Class.create({
    initialize: function(columns) {
        this.columns = columns;
        this.setupBoard();
    },

    setupBoard: function() {
        var myself = this;
        $$('ul.task').each(function(s) {
            if (s.childElements().size() > 0) {
                myself.updateHeight(s.id);
            }
        });
    },

    updateHeight: function(id) {
        if ($(id).childElements().size() > 0) {
            var height = 12;
            $(id).childElements().each(function(s) {
                height += s.getHeight();
            });
            $(id).up().setStyle({height: height + 'px'});
            // update the story as well
            var splitStoryName = id.split('_');
            var story = splitStoryName[splitStoryName.length-1];
            height += 20;
            $(story).up().setStyle({height: height + "px"});
        }
    }
});

