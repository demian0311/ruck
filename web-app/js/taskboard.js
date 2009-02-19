var TaskBoard = Class.create({
    initialize: function(columns) {
        this.columns = columns;
        this.setupBoard();
    },

    setupBoard: function() {
        var columns = this.columns;
        $$('li.storyTitle').each(function(s) {
            for (var i = 0, l = columns.length; i < l; i++) {
                var column = $(columns[i] + "_" + s.id);
                column.childElements().each(function(e) {
                    s.setStyle({height: parseInt(s.getHeight() + s.getHeight()) + "px"});
                })
            }
        });
    }
});